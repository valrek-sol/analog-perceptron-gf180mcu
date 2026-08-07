"""
Chipathon 2026 - Analog Perceptron (GF180MCU)
OP-SWEEP DIAGNOSTIC post-processing script.
assisted (grunt work and epic tips, google on steroids!) by claude AI.
Author : Guru Charan (and claude!) 
(newb, cut some slack? no ? yes? idk? help)
totally my idea tho i will say that straight. 

This is a SEPARATE, PARALLEL script to plot_results.py — it does not read
or write any of the same files, and does not touch that script or its
output folder. Purpose here is different: instead of plotting the
transfer-curve *result* (V_out vs input), this reads the per-device
operating-point vectors (vgs, vth, vdsat, id, gm, gds) logged alongside
each DC sweep, and answers one question per block:

    "Across my full intended input/weight range, does every transistor
     stay in its intended region of operation (i.e. does Vov = Vgs - Vth
     stay positive / does it stay comfortably saturated), or does it
     cross into weak inversion / triode somewhere in the sweep?"

IMPORTANT ngspice quirk this script accounts for:
  `wrdata file v1 v2 v3 ...` does NOT write one shared x-column followed
  by N y-columns. It writes EVERY vector as its own (x, y) pair, so N
  vectors on the wrdata line become 2*N columns: x,y1,x,y2,x,y3,...
  All the x's are identical (the swept variable), so we just take column
  0 as x and every odd-indexed column (1, 3, 5, ...) as the real y-data,
  in the order the vectors were listed in the .control wrdata line.

Expected input files (produced by the OP-SWEEP DIAGNOSTIC .control blocks
added to each testbench — NOT the original transfer-curve sweeps):

  opsweep_cg_amp_tia.txt          7 vectors -> 14 raw cols: v_out, vgs, vth, vdsat, id, gm, gds
                                      (swept: I_SENSOR 0-50uA)
  opsweep_gilbert.txt            50 vectors -> 100 raw cols: v_o_p, v_o_n, then 6 cols x 8 devices (M1..M8)
                                      (swept: V_W_P 1.15-2.15V)
  opsweep_tanh_ota.txt           31 vectors -> 62 raw cols: v_out, then 6 cols x 5 devices (M1..M5)
                                      (swept: V_IN_P 2.1-2.5V -- matches tb_tanh_ota.sch's
                                       dc line, NOT the older 1.4-1.9V range this comment
                                       used to claim; the testbench moved V_IN_N to a 2.3V
                                       common-mode, so keep this in sync if it moves again)
  opsweep_perceptron_chain.txt   22 vectors -> 44 raw cols: v_out, then 3 cols x 7 canary devices
                                      (TIA1, TIA2, Gilbert1_tail, Gilbert2_tail,
                                       Gilbert3_tail, tanhOTA_M1, tanhOTA_M2)
                                      (swept: I_X1 0-50uA, neutral bias, I_X2 HELD AT 0 --
                                       so TIA2 carries no current anywhere in this file by
                                       construction; see opsweep_perceptron_chain_ix2.txt)
  opsweep_perceptron_chain_ix2.txt  same 22 vectors/44 cols as above, but swept over I_X2
                                      0-50uA with I_X1 held at 25uA instead -- this is the
                                      one that actually exercises TIA2.

Any missing file is skipped with a warning, same convention as plot_results.py.

Run this from the same directory you'd run plot_results.py from (the one
containing ./plots/). Outputs go to ./plots/opsweep_generated/ — a
different folder than plot_results.py uses, so nothing gets overwritten.


PLEASE LET ME KNOW IF AI docstrings are not readable , i will re-write manually upon request. (or when i am bored and have time)
the line is blurred. dont know what is proper and what is not. 
verified it to be correct btw, dw.
"""

import numpy as np
import matplotlib.pyplot as plt
from pathlib import Path

DATA_DIR = Path("./plots")
OUT_DIR = Path("./plots/opsweep_generated")   # separate from plot_results.py's output dir
OUT_DIR.mkdir(parents=True, exist_ok=True)

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

DEVICE_COLORS = ["#1f4e8c", "#c0392b", "#1a8a3d", "#8e44ad", "#e67e22",
                 "#16a085", "#d35400", "#2c3e50"]


def _path(fname):
    p = DATA_DIR / fname
    if not p.exists():
        print(f"[skip] {fname} not found — run the matching OP-SWEEP .control block first.")
        return None
    return p


def _load_wrdata(path, n_vectors):
    """
    Read an ngspice wrdata file that was produced with N vectors on the
    wrdata line. ngspice writes 2*N columns (x,y pairs per vector, all
    x's identical). Returns (x, y) where x is 1D (the sweep variable)
    and y is 2D with shape (n_points, n_vectors), columns in the same
    order the vectors were listed in the .control wrdata line.
    """
    data = np.loadtxt(path)
    expected_cols = 2 * n_vectors
    if data.shape[1] != expected_cols:
        raise ValueError(
            f"{path.name}: expected {expected_cols} columns (2 x {n_vectors} "
            f"vectors, from ngspice's wrdata x/y-per-vector pairing) but "
            f"found {data.shape[1]}. Check the wrdata line in the .control "
            f"block still lists exactly {n_vectors} vectors."
        )
    x = data[:, 0]
    y = data[:, 1::2]  # every other column starting at index 1 = the real y-data
    return x, y


def _save(fig, name):
    fig.tight_layout()
    fig.savefig(OUT_DIR / f"{name}.png")
    plt.close(fig)
    print(f"[ok] {name}.png")


def _report_headroom(label, x, vov, x_units="", x_name="sweep var",
                      mode="strict", op_window=None, note=None):
    """
    Print a one-line, human-readable verdict for a single device's Vov trace.

    mode:
      "strict"  (default) - device is meant to stay in strong inversion
                 everywhere in the sweep. Vov < 0 anywhere is flagged.
      "weak_ok" - device is *designed* to run in weak/moderate inversion
                 (e.g. a subthreshold differential pair used for its
                 exponential I-V to make a tanh/translinear shape). Vov < 0
                 is the expected operating point here, not a fault -- the
                 raw range is still printed so it stays inspectable, but the
                 verdict doesn't cry wolf about it.

    op_window: optional (lo, hi) in the same units as x. Some diagnostic
      sweeps deliberately run past the range a signal ever really takes
      (e.g. the standalone Gilbert cell is swept 1.15-2.15V to find its
      limits, but the perceptron only ever drives it 1.45-1.85V). When
      given, this checks headroom specifically inside that real operating
      window and reports the margin to the nearest edge, instead of only
      reporting on the wider diagnostic sweep. A device can fail the
      full-sweep check and still be perfectly fine at the operating point
      that's actually used -- or vice versa, which is the case worth
      catching before layout.

    note: optional one-line free-text context printed under the verdict,
      for things a bare Vov number can't say on its own (e.g. "this device
      carries no current in this particular sweep, look elsewhere").
    """
    vmin = vov.min()
    vmax = vov.max()
    if mode == "weak_ok":
        verdict = "EXPECTED - weak-inversion by design (this is what makes the tanh shape work)"
    elif vmin >= 0:
        verdict = f"OK - stays saturated, min Vov = {vmin*1e3:.1f} mV"
    else:
        below = x[vov < 0]
        lo, hi = below.min(), below.max()
        verdict = (f"LEAVES SATURATION - Vov < 0 for {x_name} in "
                   f"[{lo:.4g}{x_units}, {hi:.4g}{x_units}] (min Vov = {vmin*1e3:.1f} mV)")
    print(f"    {label:<18s} Vov range [{vmin*1e3:7.1f}, {vmax*1e3:7.1f}] mV  -> {verdict}")
    if note:
        print(f"    {'':18s} note: {note}")
    if op_window is not None:
        lo_w, hi_w = op_window
        in_window = (x >= lo_w) & (x <= hi_w)
        if not in_window.any():
            print(f"    {'':18s} operating range [{lo_w:g}{x_units}, {hi_w:g}{x_units}] not covered by this sweep -- skipping margin check")
        else:
            vov_w = vov[in_window]
            if vov_w.min() >= 0:
                unsafe_x = x[vov < 0]
                left = unsafe_x[unsafe_x < lo_w]
                right = unsafe_x[unsafe_x > hi_w]
                left_margin = (lo_w - left.max()) if left.size else None
                right_margin = (right.min() - hi_w) if right.size else None
                margins = [m for m in (left_margin, right_margin) if m is not None]
                if margins:
                    tightest = min(margins)
                    flag = " <-- getting tight, worth a second look before layout" if tightest < 0.1 * (hi_w - lo_w) else ""
                    print(f"    {'':18s} operating range [{lo_w:g}{x_units}, {hi_w:g}{x_units}] OK, "
                          f"tightest margin to edge = {tightest:.4g}{x_units}{flag}")
                else:
                    print(f"    {'':18s} operating range [{lo_w:g}{x_units}, {hi_w:g}{x_units}] OK, comfortable margin (no unsafe point anywhere nearby in this sweep)")
            else:
                print(f"    {'':18s} *** operating range [{lo_w:g}{x_units}, {hi_w:g}{x_units}] -- Vov < 0 "
                      f"INSIDE this window, not just at the sweep's edges -- this one is real ***")


# ---------------------------------------------------------------
# 1. CG-TIA - single device (M1), swept over I_SENSOR 0-50uA
#    7 vectors: v_out, vgs, vth, vdsat, id, gm, gds
# ---------------------------------------------------------------
p = _path("opsweep_cg_amp_tia.txt")
if p:
    i_sensor, y = _load_wrdata(p, 7)
    v_out, vgs, vth, vdsat, id_, gm, gds = y.T
    vov = vgs - vth

    print("\n=== CG-TIA (M1) - headroom across I_sensor 0-50uA ===")
    _report_headroom("M1", i_sensor * 1e6, vov, x_units="uA", x_name="I_sensor",
                      note="near-zero I_sensor is an inherent corner for a current-input stage "
                           "(no forced drain current -> nothing forces Vgs above Vth); what matters "
                           "is the current at which it recovers, not whether Vov is ever negative")

    fig, ax1 = plt.subplots(figsize=(6, 4.5))
    ax1.plot(i_sensor * 1e6, vov * 1e3, color=DEVICE_COLORS[0], lw=2, label="Vov = Vgs-Vth")
    ax1.axhline(0, color="gray", ls=":", lw=1)
    ax1.set_xlabel("I_sensor (\u00b5A)")
    ax1.set_ylabel("Vov (mV)")
    ax1.set_title("CG-TIA M1: Overdrive Margin vs. Sensor Current")
    _save(fig, "opsweep_01_tia_vov")

    # Implied resistance via Ohm's law (V_ref tied to V_SUPPLY = 1.25V in
    # tb_cg_amp_tia.sch -- update V_REF_ASSUMED if you change that source).
    # Cross-check against your W/L * sheet-rho hand calc before locking values.
    V_REF_ASSUMED = 1.25
    with np.errstate(divide="ignore", invalid="ignore"):
        r_implied = np.where(id_ > 0, (V_REF_ASSUMED - v_out) / id_, np.nan)
    valid = np.isfinite(r_implied) & (i_sensor > 1e-8)
    if valid.any():
        print(f"    Implied R1 (Ohm's law, V_ref={V_REF_ASSUMED}V): "
              f"{np.nanmean(r_implied[valid]):.1f} ohm "
              f"(range {np.nanmin(r_implied[valid]):.1f}-{np.nanmax(r_implied[valid]):.1f} ohm)")

# ---------------------------------------------------------------
# 2. Gilbert cell - 8 devices, swept over V_W_P 1.15-2.15V
#    50 vectors: v_o_p, v_o_n, then 6 cols x 8 devices
# ---------------------------------------------------------------
p = _path("opsweep_gilbert.txt")
if p:
    v_w_p, y = _load_wrdata(p, 50)
    device_cols = y[:, 2:]  # skip v_o_p, v_o_n -> 48 cols, 8 devices x 6 params

    print("\n=== Gilbert Cell - headroom across V_W_P 1.15-2.15V ===")
    print("    (M3-M6 are the weight-steering quad; the perceptron itself only ever drives")
    print("     V_W1/V_W2 across 1.45-1.85V -- see 'operating range' line below for each)")
    # M3-M6 (index 2..5) are the switching quad gated by V_w_p/V_w_n; the standalone
    # sweep here deliberately over-ranges to 1.15-2.15V to find the real limits, but
    # the perceptron never drives them outside 1.45-1.85V (see tb_perceptron.sch's
    # weight sweeps). That's the window that actually matters for tapeout.
    WEIGHT_OP_WINDOW = (1.45, 1.85)
    fig, ax = plt.subplots(figsize=(7, 5))
    for i in range(8):
        block = device_cols[:, i*6:(i+1)*6]
        vgs_i, vth_i = block[:, 0], block[:, 1]
        vov_i = vgs_i - vth_i
        label = f"M{i+1}"
        op_window = WEIGHT_OP_WINDOW if i in (2, 3, 4, 5) else None
        _report_headroom(label, v_w_p, vov_i, x_units="V", x_name="V_W_P", op_window=op_window)
        ax.plot(v_w_p, vov_i * 1e3, color=DEVICE_COLORS[i % len(DEVICE_COLORS)],
                lw=1.6, label=label)
    ax.axvspan(WEIGHT_OP_WINDOW[0], WEIGHT_OP_WINDOW[1], color="gray", alpha=0.12,
               label="real V_W range")
    ax.axhline(0, color="gray", ls=":", lw=1)
    ax.set_xlabel("V_W_P (V)")
    ax.set_ylabel("Vov (mV)")
    ax.set_title("Gilbert Cell: Overdrive Margin, All 8 Devices")
    ax.legend(fontsize=8, ncol=2)
    _save(fig, "opsweep_02_gilbert_vov")

# ---------------------------------------------------------------
# 3. tanh OTA - 5 devices, swept over V_IN_P 1.4-1.9V
#    31 vectors: v_out, then 6 cols x 5 devices
# ---------------------------------------------------------------
p = _path("opsweep_tanh_ota.txt")
if p:
    v_in_p, y = _load_wrdata(p, 31)
    device_cols = y[:, 1:]  # skip v_out -> 30 cols, 5 devices x 6 params

    print("\n=== tanh OTA - headroom across V_IN_P 2.1-2.5V ===")
    print("    (M1-M5 are the diff pair + tail, run in weak/moderate inversion on purpose --")
    print("     tail gate sits at V_bias=0.7V, well below Vth -- the exponential subthreshold")
    print("     I-V is what gives this stage its tanh shape, so negative Vov here is the design")
    print("     working as intended, not a saturation failure. Confirm that's really the intent")
    print("     if this comes as a surprise.)")
    fig, ax = plt.subplots(figsize=(6.5, 4.5))
    for i in range(5):
        block = device_cols[:, i*6:(i+1)*6]
        vgs_i, vth_i = block[:, 0], block[:, 1]
        vov_i = vgs_i - vth_i
        label = f"M{i+1}"
        _report_headroom(label, v_in_p, vov_i, x_units="V", x_name="V_IN_P", mode="weak_ok")
        ax.plot(v_in_p, vov_i * 1e3, color=DEVICE_COLORS[i % len(DEVICE_COLORS)],
                lw=1.8, label=label)
    ax.axhline(0, color="gray", ls=":", lw=1)
    ax.set_xlabel("V_IN_P (V)")
    ax.set_ylabel("Vov (mV)")
    ax.set_title("tanh OTA: Overdrive Margin, All 5 Devices")
    ax.legend(fontsize=8)
    _save(fig, "opsweep_03_tanh_vov")

# ---------------------------------------------------------------
# 4/5. Full-chain (perceptron) - 7 canary devices, two complementary sweeps.
#    22 vectors each: v_out, then 3 cols x 7 canary devices
#    (TIA1, TIA2, Gilbert1_tail, Gilbert2_tail, Gilbert3_tail, tanhOTA_M1, tanhOTA_M2)
# ---------------------------------------------------------------
CANARY_NAMES = ["TIA1_M1", "TIA2_M1", "Gilbert1_tail_M7",
                 "Gilbert2_tail_M7", "Gilbert3_tail_M7",
                 "tanhOTA_M1", "tanhOTA_M2"]


def _report_chain_canaries(x, y, x_units, x_name, extra_notes=None):
    """
    Shared per-device Vov report + plot for the 7 full-chain canary devices.
    Used by both the I_X1-swept and I_X2-swept chain diagnostics below so
    the two stay consistent. extra_notes is an optional {canary_name: note}
    dict for context specific to one sweep (e.g. "held at 0 for this run").
    tanhOTA_* devices are always reported as weak-inversion-by-design (see
    the standalone tanh OTA section above for why); everything else is
    held to the normal strong-inversion bar.
    """
    extra_notes = extra_notes or {}
    v_out = y[:, 0]
    device_cols = y[:, 1:]  # skip v_out -> 21 cols, 7 devices x 3 params (vgs, vth, id)
    fig, ax = plt.subplots(figsize=(7, 5))
    for i, name in enumerate(CANARY_NAMES):
        block = device_cols[:, i*3:(i+1)*3]
        vgs_i, vth_i = block[:, 0], block[:, 1]
        vov_i = vgs_i - vth_i
        mode = "weak_ok" if name.startswith("tanhOTA") else "strict"
        _report_headroom(name, x * 1e6, vov_i, x_units=x_units, x_name=x_name,
                          mode=mode, note=extra_notes.get(name))
        ax.plot(x * 1e6, vov_i * 1e3, color=DEVICE_COLORS[i % len(DEVICE_COLORS)],
                lw=1.8, label=name)
    ax.axhline(0, color="gray", ls=":", lw=1)
    ax.set_xlabel(f"{x_name} (\u00b5A)")
    ax.set_ylabel("Vov (mV)")
    ax.legend(fontsize=7, ncol=2)
    return fig, ax, v_out


# --- 4. swept over I_X1, neutral bias, I_X2 held at 0 ---
p = _path("opsweep_perceptron_chain.txt")
if p:
    i_x1, y = _load_wrdata(p, 22)
    print("\n=== Full-Chain (Perceptron, neutral bias) - headroom across I_X1 0-50uA ===")
    print("    (I_X2 is held at 0 for this entire sweep -> TIA2 is idle here by construction,")
    print("     not a fault; see the I_X2-swept diagnostic right after this one)")
    notes_ix1 = {
        "TIA1_M1": "near-zero I_X1 is an inherent corner for a current-input stage, "
                   "same as the standalone CG-TIA sweep above",
        "TIA2_M1": "I_X2 held at 0 across this whole sweep (neutral-bias diagnostic) -> "
                   "carries no forced current here by construction, not a sizing problem; "
                   "see opsweep_perceptron_chain_ix2.txt below for its real headroom check",
    }
    fig, ax, v_out = _report_chain_canaries(i_x1, y, "uA", "I_X1", extra_notes=notes_ix1)
    ax.set_title("Full Chain: Canary Device Overdrive Margin (I_X1 swept, neutral bias)")
    _save(fig, "opsweep_04_chain_vov")

    # Rail-clipping sanity check on the final output
    print(f"\n    V_out_perceptron range: [{v_out.min():.4f}, {v_out.max():.4f}] V "
          f"(VDD=3.3V, mid-rail=1.65V)")
    if v_out.max() - v_out.min() < 1e-3:
        print("    Output is essentially flat across the full I_X1 sweep -- expected: V_W1=1.65V is")
        print("    the neutral/zero weight, so a zero-weight synapse should produce no output")
        print("    modulation regardless of input current. This is a null-check passing, not a bug.")
        print("    See perceptron_graph1_weights.txt for the swing at a non-neutral weight.")
    if v_out.min() < 0.15 or v_out.max() > 3.15:
        print("    WARNING: output swings within ~150mV of a supply rail somewhere in this sweep.")

# --- 5. swept over I_X2, I_X1 held at 25uA -- this is the one that actually
#        puts current through TIA2, which block 4 above never does ---
p = _path("opsweep_perceptron_chain_ix2.txt")
if p:
    i_x2, y = _load_wrdata(p, 22)
    print("\n=== Full-Chain (Perceptron) - headroom across I_X2 0-50uA, I_X1 held at 25uA ===")
    notes_ix2 = {"TIA2_M1": "this is TIA2's real headroom check -- I_X2 is actually swept here"}
    fig, ax, v_out = _report_chain_canaries(i_x2, y, "uA", "I_X2", extra_notes=notes_ix2)
    ax.set_title("Full Chain: Canary Device Overdrive Margin (I_X2 swept, I_X1=25uA)")
    _save(fig, "opsweep_05_chain_ix2_vov")

print(f"\nDone. Diagnostic plots + console report above saved in {OUT_DIR.resolve()}")
