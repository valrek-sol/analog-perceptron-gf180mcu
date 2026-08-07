"""
as understandably so, this code was directed by me (guru charan),
but written entirely by AI, it does what exactly I wanted to code.
well, thats some information i guess.
gemini 3.1 pro was able to do it. simple stuff. good.

perhaps there was no point writing this myself? or was there?
remains to be seen. I do write my own code, especially when I do it like an "Art" or
recreation... anyways.
"""
import math

def calculate_vout(i_x1_ua, i_x2_ua, v_w1, v_w2, v_b):
    # System Constants
    V_CM = 1.65       # Neutral common mode voltage
    MAX_SWING = 0.15  # Max voltage swing above/below V_CM (1.50V to 1.80V)
    GAIN = 12.0       # Tuning parameter (adjust to match SPICE curve steepness)
    I_MAX = 50.0      # Max expected sensor current in uA

    # 1. Normalize Inputs (0 to 50uA -> 0.0 to 1.0)
    x1_norm = i_x1_ua / I_MAX
    x2_norm = i_x2_ua / I_MAX
    
    # 2. Extract Effective Weights and Bias (Centered around V_CM)
    w1_eff = v_w1 - V_CM
    w2_eff = v_w2 - V_CM
    b_eff  = v_b - V_CM
    
    # 3. Multiply and Sum (MAC operation)
    mac_sum = (x1_norm * w1_eff) + (x2_norm * w2_eff) + b_eff
    
    # 4. Activation Function (tanh)
    activation = math.tanh(GAIN * mac_sum)
    
    # 5. Map back to physical output voltage
    v_out = V_CM + (MAX_SWING * activation)
    
    return v_out

def main():
    print("==================================================")
    print("  Analog Perceptron Math Emulator (Interactive)   ")
    print("  Type 'q' or 'quit' at any prompt to exit.       ")
    print("==================================================")
    
    while True:
        try:
            print("\n--- Enter Parameters ---")
            
            i_x1_str = input("I_X1 (in µA, e.g., 25): ")
            if i_x1_str.lower() in ['q', 'quit']: break
            i_x1_ua = float(i_x1_str)
            
            i_x2_str = input("I_X2 (in µA, e.g., 0): ")
            if i_x2_str.lower() in ['q', 'quit']: break
            i_x2_ua = float(i_x2_str)
            
            v_w1_str = input("V_W1 (in V, e.g., 1.85): ")
            if v_w1_str.lower() in ['q', 'quit']: break
            v_w1 = float(v_w1_str)
            
            v_w2_str = input("V_W2 (in V, e.g., 1.65): ")
            if v_w2_str.lower() in ['q', 'quit']: break
            v_w2 = float(v_w2_str)
            
            v_b_str = input("V_B  (in V, e.g., 1.65): ")
            if v_b_str.lower() in ['q', 'quit']: break
            v_b = float(v_b_str)
            
            # Crunch the numbers
            v_out = calculate_vout(i_x1_ua, i_x2_ua, v_w1, v_w2, v_b)
            
            print("\n--------------------------------------------------")
            print(f">>> Expected V_out = {v_out:.4f} V")
            print("--------------------------------------------------")
            
        except ValueError:
            print("\n[!] Invalid input. Please enter numbers only.")

if __name__ == "__main__":
    main()
