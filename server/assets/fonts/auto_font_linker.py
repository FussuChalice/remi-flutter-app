#! /usr/bin/env python3
# file: auto_font_linker.py

import os

"""
    author: FussuChalice (Max Makaluk)
    date of creation: 02.12.2022 21:04
"""

def main():

    print("============| Auto Font Linker |============")

    font_folder = input("Enter font name: ")
    font_linker_file = input("Enter font linker file name (font.linker.css): ")
    all_files = os.listdir(font_folder)

    # Remove extension of files
    font_names = []

    for i in range(len(all_files)):

        file_name = str(all_files[i].split('.')[0])
        print(file_name)

        if file_name != "LICENSE":
            font_names.append(file_name)

    # print(font_names)

    font_linker_file_name = None

    if font_linker_file == "":
        font_linker_file_name = "font.linker.css"

    else:
        font_linker_file_name = font_linker_file

    with open("./" + font_linker_file_name, 'a') as file:
        file.write("/* " + str(font_folder) +" */\n")
        
        for i in range(len(font_names)):
            file.write("@font-face { font-family: " + 
                       font_names[i] + "; src: url(./" + str(font_folder) + "/" +
                         font_names[i] + ".ttf); }\n")


if __name__ == "__main__":
    main()
