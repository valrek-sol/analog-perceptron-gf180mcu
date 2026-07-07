"""
Chipathon 2026 - Analog Perceptron (GF180MCU)
Post-processing / plotting pipeline for the ngspice wrdata exports
produced by the revised .control blocks.

Run this from the directory containing the exported .txt files
(or set DATA_DIR below), after running the testbenches in ngspice.

Expected input files (2 columns each, whitespace separated, no header):
  cg_amp_tia_sweep.txt            I_SENSOR, V_out                 (single sweep) gilbert_single_sweep.txt        V_W_P,    V_diff                (single sweep)
  gilbert_family_sweep.txt        V_W_P,    V_diff   x 5 stacked  (V_X_P = 1.10..1.30 step 0.05)
  tanh_ota_sweep.txt               V_IN_P,   V_out                (single sweep)
  perceptron_graph1_weights.txt   I_X1,     V_out    x 3 stacked  (V_W1 = 1.45/1.65/1.85)
  perceptron_graph2_sensors.txt   I_X1,     V_out    x 3 stacked  (I_X2 = 0/25u/50u)
  perceptron_graph3_bias.txt      I_X1,     V_out    x 3 stacked  (V_B  = 1.45/1.65/1.85)
  3d_sensors.txt                  I_X1,     V_out    x 26 stacked (I_X2 = 0..50u step 2u)
  3d_weights.txt                  V_W1,     V_out    x 21 stacked (V_W2 = 1.45..1.85 step 0.02)

Any file that's missing is skipped with a warning rather than crashing the
whole run, so you can generate/plot blocks incrementally.
"""

import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D  # noqa: F401  (needed for 3d projection)
from pathlib import Path

DATA_DIR = Path("./plots")
OUT_DIR = Path("./plots/plots_generated")
OUT_DIR.mkdir(exist_ok=True)

# ---- xschem white-theme-matching style ----
plt.rcParams.update({
    "figure.facecolor": "white",
    "axes.facecolor": "white",
    "axes.edgecolor": "black",
    "axes.labelcolor": "black",
    "text.color": "black",
    "xtick.color": "black",
    "ytick.color": "black",
    "grid.color": "#bbbbbb",
    "grid.linestyle": "--",
    "grid.linewidth": 0.6,
    "axes.grid": True,
    "font.size": 11,
    "figure.dpi": 150,
    "savefig.facecolor": "white",
})

CURVE_COLORS = ["#1f4e8c", "#c0392b", "#1a8a3d", "#8e44ad", "#e67e22"]


def _path(fname):
    p = DATA_DIR / fname
    if not p.exists():
        print(f"[skip] {fname} not found — run the matching .control block first.")
        return None
    return p


def load_simple(fname):
    p = _path(fname)
    if p is None:
        return None
    data = np.loadtxt(p)
    return data[:, 0], data[:, 1]


def load_stacked(fname, npts, labels):
    p = _path(fname)
    if p is None:
        return None
    data = np.loadtxt(p)
    x = data[:npts, 0]
    y = data[:, 1].reshape(len(labels), npts)
    return x, y


def load_grid(fname, n_inner, outer_values):
    p = _path(fname)
    if p is None:
        return None
    data = np.loadtxt(p)
    x_inner = data[:n_inner, 0]
    z = data[:, 1].reshape(len(outer_values), n_inner)
    return x_inner, np.array(outer_values), z


def save(fig, name):
    fig.tight_layout()
    fig.savefig(OUT_DIR / f"{name}.png")
    plt.close(fig)
    print(f"[ok] {name}.png")


# ---------------------------------------------------------------
# 1. TIA -- linear I-to-V
# ---------------------------------------------------------------
res = load_simple("cg_amp_tia_sweep.txt")
if res:
    i_sensor, v_out = res
    fig, ax = plt.subplots(figsize=(5.5, 4))
    ax.plot(i_sensor * 1e6, v_out, color=CURVE_COLORS[0], lw=2)
    ax.set_xlabel("I_sensor (\u00b5A)")
    ax.set_ylabel("V_out (V)")
    ax.set_title("CG-TIA: Sensor Current to Voltage")
    save(fig, "01_tia_linear")

# ---------------------------------------------------------------
# 2. Gilbert -- single sweep
# ---------------------------------------------------------------
res = load_simple("gilbert_single_sweep.txt")
if res:
    vwp, vdiff = res
    fig, ax = plt.subplots(figsize=(5.5, 4))
    ax.plot(vwp, vdiff * 1e3, color=CURVE_COLORS[0], lw=2)
    ax.set_xlabel("V_W_P (V)")
    ax.set_ylabel("V_diff_out (mV)")
    ax.set_title("Gilbert Multiplier: Single Weight Sweep")
    save(fig, "02_gilbert_single")

# ---------------------------------------------------------------
# 3. Gilbert -- family of curves ("spider")
# ---------------------------------------------------------------
vxp_labels = [1.10, 1.15, 1.20, 1.25, 1.30]
res = load_stacked("gilbert_family_sweep.txt", 101, vxp_labels)
if res:
    vwp_f, vdiff_f = res
    fig, ax = plt.subplots(figsize=(6, 4.5))
    for row, vxp, c in zip(vdiff_f, vxp_labels, CURVE_COLORS):
        ax.plot(vwp_f, row * 1e3, label=f"V_X_P = {vxp:.2f} V", color=c, lw=2)
    ax.set_xlabel("V_W_P (V)")
    ax.set_ylabel("V_diff_out (mV)")
    ax.set_title("Gilbert Multiplier: Weight Sweep Family (4-Quadrant)")
    ax.legend(fontsize=8)
    save(fig, "03_gilbert_family")

# ---------------------------------------------------------------
# 4. tanh OTA -- single sweep
# ---------------------------------------------------------------
res = load_simple("tanh_ota_sweep.txt")
if res:
    vin, vout_tanh = res
    fig, ax = plt.subplots(figsize=(5.5, 4))
    ax.plot(vin, vout_tanh, color=CURVE_COLORS[0], lw=2)
    ax.set_xlabel("V_in_p (V)")
    ax.set_ylabel("V_out (V)")
    ax.set_title("tanh OTA: Saturating Transfer Characteristic")
    save(fig, "04_tanh_ota")


# ---------------------------------------------------------------
# 5-7. Perceptron graphs (weights / sensor interference / bias)
# ---------------------------------------------------------------
def plot_perceptron_family(fname, npts, labels, label_fmt, title, out_name):
    res = load_stacked(fname, npts, labels)
    if not res:
        return
    x, y = res
    fig, ax = plt.subplots(figsize=(6, 4.5))
    for row, lab, c in zip(y, labels, CURVE_COLORS):
        ax.plot(x * 1e6, row, label=label_fmt.format(lab), color=c, lw=2)
    ax.set_xlabel("I_X1 (\u00b5A)")
    ax.set_ylabel("V_out_perceptron (V)")
    ax.set_title(title)
    ax.legend(fontsize=8)
    save(fig, out_name)


plot_perceptron_family(
    "perceptron_graph1_weights.txt", 51, [1.45, 1.65, 1.85],
    "V_W1 = {:.2f} V", "Perceptron: Weight Sweep (Inhib. / Neutral / Excit.)",
    "05_perceptron_weights")

plot_perceptron_family(
    "perceptron_graph2_sensors.txt", 51, [0, 25, 50],
    "I_X2 = {:g} \u00b5A", "Perceptron: Sensor 1 Sweep, Sensor 2 Interference",
    "06_perceptron_sensors")

plot_perceptron_family(
    "perceptron_graph3_bias.txt", 51, [1.45, 1.65, 1.85],
    "V_B = {:.2f} V", "Perceptron: Bias Shifting the S-Curve",
    "07_perceptron_bias")

# ---------------------------------------------------------------
# 8-9. 3D surfaces
# ---------------------------------------------------------------
ix2_values = np.arange(0, 50 + 2, 2)  # uA, matches 2u step in sim
res = load_grid("3d_sensors.txt", 51, ix2_values)
if res:
    ix1, ix2, z_sensors = res
    fig = plt.figure(figsize=(6.5, 5.5))
    ax = fig.add_subplot(111, projection="3d")
    X, Y = np.meshgrid(ix1 * 1e6, ix2_values)
    surf = ax.plot_surface(X, Y, z_sensors, cmap="coolwarm", edgecolor="k", linewidth=0.2)
    ax.set_xlabel("I_X1 (\u00b5A)")
    ax.set_ylabel("I_X2 (\u00b5A)")
    ax.set_zlabel("V_out_perceptron (V)")
    ax.set_title("Perceptron Output Surface vs. Sensor Currents")
    fig.colorbar(surf, shrink=0.6, pad=0.1)
    save(fig, "08_perceptron_3d_sensors")

vw2_values = np.round(1.45 + np.arange(21) * 0.02, 3)
res = load_grid("3d_weights.txt", 41, vw2_values)
if res:
    vw1, vw2, z_weights = res
    fig = plt.figure(figsize=(6.5, 5.5))
    ax = fig.add_subplot(111, projection="3d")
    X, Y = np.meshgrid(vw1, vw2_values)
    surf = ax.plot_surface(X, Y, z_weights, cmap="coolwarm", edgecolor="k", linewidth=0.2)
    ax.set_xlabel("V_W1 (V)")
    ax.set_ylabel("V_W2 (V)")
    ax.set_zlabel("V_out_perceptron (V)")
    ax.set_title("Perceptron Output Surface vs. Weights")
    fig.colorbar(surf, shrink=0.6, pad=0.1)
    save(fig, "09_perceptron_3d_weights")

print(f"\nDone. Plots saved in {OUT_DIR.resolve()}")
