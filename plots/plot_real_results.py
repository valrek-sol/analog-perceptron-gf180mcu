"""
Chipathon 2026 - Analog Perceptron (GF180MCU)
Post-processing / plotting pipeline for the ngspice wrdata exports
produced by the revised .control blocks.
assisted (grunt work and epic tips, google on steroids!) by claude AI.
Author : Guru Charan (and claude! and gemini!) 
(newb, cut some slack? no ? yes? idk? help)
totally my idea tho i will say that straight. 

Run this from the directory containing the exported .txt files
(or set DATA_DIR below), after running the testbenches in ngspice.
"""

import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from pathlib import Path

DATA_DIR = Path("./plots")
OUT_DIR = Path("./plots/plots_generated_real")
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

CURVE_COLORS = ["#1f4e8c", "#c0392b", "#1a8a3d", "#8e44ad", "#e67e22", "#16a085"]

def _path(fname):
    p = DATA_DIR / fname
    if not p.exists():
        print(f"[skip] {fname} not found , please run the matching .control block first.")
        return None
    return p

def load_simple(fname):
    p = _path(fname)
    if p is None: return None
    data = np.loadtxt(p)
    return data[:, 0], data[:, 1]

def load_ac(fname):
    p = _path(fname)
    if p is None: return None
    data = np.loadtxt(p)
    # AC ngspice format: frequency, real_part, frequency, imaginary_part
    freq = data[:, 0]
    real = data[:, 1]
    imag = data[:, 2]
    magnitude = 20 * np.log10(np.sqrt(real**2 + imag**2) + 1e-12)
    phase = np.degrees(np.arctan2(imag, real))
    return freq, magnitude, phase

def load_stacked(fname, npts, labels):
    p = _path(fname)
    if p is None: return None
    data = np.loadtxt(p)
    x = data[:npts, 0]
    y = data[:, 1].reshape(len(labels), npts)
    return x, y

def load_grid(fname, n_inner, outer_values):
    p = _path(fname)
    if p is None: return None
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
# 1. TRANSIENT ANALYSIS
# ---------------------------------------------------------------
res = load_simple("real_tran_perceptron.txt")
if res:
    t, v_out = res
    fig, ax = plt.subplots(figsize=(6, 4))
    ax.plot(t * 1e6, v_out, color=CURVE_COLORS[1], lw=2)
    ax.set_xlabel("Time (\u00b5s)")
    ax.set_ylabel("V_out_perceptron (V)")
    ax.set_title("Transient Response (50\u00b5A Pulse on I_X1)")
    save(fig, "01_real_tran_response")

# ---------------------------------------------------------------
# 2. AC / STABILITY ANALYSIS
# ---------------------------------------------------------------
res = load_ac("real_ac_perceptron.txt")
if res:
    freq, mag, phase = res
    fig, (ax_mag, ax_phase) = plt.subplots(2, 1, figsize=(6, 6), sharex=True)
    
    ax_mag.semilogx(freq, mag, color=CURVE_COLORS[0], lw=2)
    ax_mag.set_ylabel("Magnitude (dB)")
    ax_mag.set_title("AC Response (Bode Plot)")
    
    ax_phase.semilogx(freq, phase, color=CURVE_COLORS[2], lw=2)
    ax_phase.set_ylabel("Phase (Degrees)")
    ax_phase.set_xlabel("Frequency (Hz)")
    save(fig, "02_real_ac_response")

# ---------------------------------------------------------------
# 3. Perceptron graphs
# ---------------------------------------------------------------
def plot_perceptron_family(fname, npts, labels, label_fmt, title, out_name):
    res = load_stacked(fname, npts, labels)
    if not res: return
    x, y = res
    fig, ax = plt.subplots(figsize=(6, 4.5))
    for row, lab, c in zip(y, labels, CURVE_COLORS):
        ax.plot(x * 1e6, row, label=label_fmt.format(lab), color=c, lw=2)
    ax.set_xlabel("I_X1 (\u00b5A)")
    ax.set_ylabel("V_out_perceptron (V)")
    ax.set_title(title)
    ax.legend(fontsize=8)
    save(fig, out_name)

plot_perceptron_family("real_perceptron_graph1_weights.txt", 51, [1.45, 1.65, 1.85], "V_W1 = {:.2f} V", "Perceptron: Weight Sweep", "03_real_perceptron_weights")
plot_perceptron_family("real_perceptron_graph2_sensors.txt", 51, [0, 25, 50], "I_X2 = {:g} \u00b5A", "Perceptron: Sensor 1 Sweep", "04_real_perceptron_sensors")
plot_perceptron_family("real_perceptron_graph3_bias.txt", 51, [1.45, 1.65, 1.85], "V_B = {:.2f} V", "Perceptron: Bias Shifting", "05_real_perceptron_bias")
plot_perceptron_family("real_perceptron_graph4_vshift.txt", 51, [3.25, 3.27, 3.29, 3.31, 3.33, 3.35], "V_Shift = {:.2f} V", "Perceptron: V_Shift Sweep", "06_real_perceptron_vshift")

# ---------------------------------------------------------------
# 4. 3D surfaces
# ---------------------------------------------------------------
ix2_values = np.arange(0, 50 + 2, 2)
res = load_grid("real_3d_sensors.txt", 51, ix2_values)
if res:
    ix1, ix2, z_sensors = res
    fig = plt.figure(figsize=(6.5, 5.5))
    ax = fig.add_subplot(111, projection="3d")
    X, Y = np.meshgrid(ix1 * 1e6, ix2_values)
    surf = ax.plot_surface(X, Y, z_sensors, cmap="coolwarm", edgecolor="k", linewidth=0.2)
    ax.set_xlabel("I_X1 (\u00b5A)")
    ax.set_ylabel("I_X2 (\u00b5A)")
    ax.set_zlabel("V_out_perceptron (V)")
    ax.set_title("Output vs. Sensors")
    fig.colorbar(surf, shrink=0.6, pad=0.1)
    save(fig, "07_real_3d_sensors")

vw2_values = np.round(1.45 + np.arange(21) * 0.02, 3)
res = load_grid("real_3d_weights.txt", 41, vw2_values)
if res:
    vw1, vw2, z_weights = res
    fig = plt.figure(figsize=(6.5, 5.5))
    ax = fig.add_subplot(111, projection="3d")
    X, Y = np.meshgrid(vw1, vw2_values)
    surf = ax.plot_surface(X, Y, z_weights, cmap="coolwarm", edgecolor="k", linewidth=0.2)
    ax.set_xlabel("V_W1 (V)")
    ax.set_ylabel("V_W2 (V)")
    ax.set_zlabel("V_out_perceptron (V)")
    ax.set_title("Output vs. Weights")
    fig.colorbar(surf, shrink=0.6, pad=0.1)
    save(fig, "08_real_3d_weights")

print(f"\nDone. Plots saved in {OUT_DIR.resolve()}")
