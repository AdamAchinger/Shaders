import re
import tkinter as tk 
file_path = "GLSL/Noise/Noise.glsl"

with open(file_path, "r") as file:
    content = file.read()

new_value = 11.0
parameter = "float uvScale"

pattern = rf"{parameter}\s*=\s*[^;]+;"
replacement = f"{parameter} = {new_value};"

updated_content = re.sub(pattern, replacement, content)

with open(file_path, "w") as file:
    file.write(updated_content)

print("Value replaced successfully!")

# Create GUI window
root = tk.Tk()
root.title("GLSL Value Replacer")

# Entry for new value
tk.Label(root, text="Enter new value for uvScale:").pack()
new_value_entry = tk.Entry(root)
new_value_entry.pack()

# Button to trigger the replacement
replace_button = tk.Button(root, text="Replace Value")
replace_button.pack()

# Label to show the result
result_label = tk.Label(root, text="")
result_label.pack()

root.mainloop()
