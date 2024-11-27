import tkinter as tk
import customtkinter as ctk
import re

LEFT = "left"
RIGHT = "right"
BG = "#202020"
COLOR1 = "#555555"
COLOR2 = "#666666"

root = ctk.CTk(fg_color=BG)
screenWidth = root.winfo_screenwidth()
screenHeight = root.winfo_screenheight()
appXpos = int((screenWidth / 2) - (400 / 2))
appYpos = int((screenHeight / 2) - (115 / 2))
root.resizable("FALSE", "FALSE")
root.geometry(f"{400}x{115}+{appXpos}+{appYpos}")
root.title("Float Slider")
root.attributes('-topmost', True)
fileEnt = ctk.CTkEntry(root, width=390, placeholder_text="File Path",font=("Helvetica", 16))
fileEnt.pack(pady=2)


param1Frame = ctk.CTkFrame(root,fg_color=BG)
param1Frame.pack(pady=2)



def replace(value1):
    file_path = fileEnt.get().strip()  
    with open(file_path, "r") as file:
        content = file.read()
    new_value = round(value1, 2)
    parameter = param1Name.get().strip()  
    parameter = f"float {parameter}"
    pattern = rf"{parameter}\s*=\s*[^;]+;"
    replacement = f"{parameter} = {new_value};"
    updated_content = re.sub(pattern, replacement, content)
    with open(file_path, "w") as file:
        file.write(updated_content)
    param1PrevValue.configure(text=str(new_value))


param1Frame1 = ctk.CTkFrame(param1Frame,width=390,fg_color=BG)
param1Frame1.pack(pady=2)

param1Frame2 = ctk.CTkFrame(param1Frame,width=390,fg_color=BG)
param1Frame2.pack(pady=4)

param1Name = ctk.CTkEntry(param1Frame1, placeholder_text="Parameter",font=("Helvetica", 18))
param1Name.pack(side=LEFT, padx=5)

param1Min = 0.0
param1Max = 1.0
param1PrevValue = ctk.CTkLabel(param1Frame2, text="0.0", font=("Helvetica", 24),width=60)
param1PrevValue.pack(side=LEFT,padx=5,pady=5)
param1Slider = ctk.CTkSlider(
    param1Frame2,
    from_=param1Min,
    to=param1Max,
    command=replace, 
    width=390,
    button_color=COLOR1,
    button_hover_color=COLOR1
)

param1MinEnt = ctk.CTkEntry(param1Frame1, placeholder_text="0.0",font=("Helvetica", 18), width=50)
param1MinEnt.pack(side=LEFT, padx=2)
param1MaxEnt = ctk.CTkEntry(param1Frame1, placeholder_text="1.0",font=("Helvetica", 18), width=50)
param1MaxEnt.pack(side=LEFT, padx=2)

def setRange():
    minVal = float(param1MinEnt.get())
    maxVal = float(param1MaxEnt.get())
    param1Slider.configure(from_=minVal,to=maxVal)


param1RangeBut = ctk.CTkButton(param1Frame1,text="Set Range",font=("Helvetica", 18), command=setRange,fg_color=COLOR1,hover_color=COLOR2)
param1RangeBut.pack(side=LEFT, padx=5)

param1Slider.set(0)
param1Slider.pack(side=LEFT,pady=10)


root.mainloop()
