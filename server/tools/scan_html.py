"""
    author: FussuChalice,
    date of creation: 06.04.2023
"""

import sys
import os
import argparse
import time
from bs4 import BeautifulSoup

VERSION = '1.0.0'

class ArgumentParser:
    def __init__(self):
        self.parser = argparse.ArgumentParser(description='Description of the script.')

        self.parser.add_argument('-v', '--version', action='version', version='%(prog)s version ' + VERSION)
        self.parser.add_argument('-f', '--file', help="Set path to HTML file", required=True)
        self.parser.add_argument('-o', '--output', help="Path to output JS file")
        self.parser.add_argument('-s', "--selector", help="Selector: ID, QuerySelector, JQuery")
    
    def parse_args(self):
        args = self.parser.parse_args()
        return args
    
    def print_help(self):
        self.parser.print_help()


def readfile(path):
    result = ""
    with open(path, 'r') as file:
        result += file.read()

    return result


def scan_html(html):
    soup = BeautifulSoup(html, 'html.parser')

    elements_with_id = soup.find_all(id=True)


    result = []
    for i in range(len(elements_with_id)):
        buffer_element = []

        buffer_element.append(elements_with_id[i]['id'])
        buffer_element.append(elements_with_id[i].name)

        result.append(buffer_element)

    return result


def listToString(list):
 
    str1 = ""
 
    for ele in list:
        str1 += ele
 
    return str1


def saveToFile(path, data):

    header = "/*\n* File is auto generated\n*Created at: " + str(time.localtime()) + "\n*/\n"

    if os.path.isfile(path) == True:
        with open(path, 'a') as file:
            file.write(data)

    else:
        with open(path, 'a') as file:
            file.write(header)
            file.write(data)


def createDOMList(elements, type):

    if type == "ID":
        temp = []
        for _ in range(len(elements)):
            str = "const " + "id_" + elements[_][1] + "_" + elements[_][0].replace(
                "-", "_") + " = " + 'document.getElementById("' + elements[_][0] + '")' + ";\n"
            temp.append(str)

        return temp

    elif type == "QuerySelector":
        temp = []
        for _ in range(len(elements)):
            str = "const " + "id_" + elements[_][1] + "_" + elements[_][0].replace(
                "-", "_") + " = " + 'document.QuerySelector("#' + elements[_][0] + '")' + ";\n"
            temp.append(str)

        return temp

    elif type == "Jquery":
        temp = []
        for _ in range(len(elements)):
            str = "const " + "id_" + elements[_][1] + "_" + elements[_][0].replace(
                "-", "_") + " = " + '$("#' + elements[_][0] + '")' + ";\n"
            temp.append(str)

        return temp
    
    else:
        return ["Incorrect type"]


def main(argv):
    argvParser = ArgumentParser()

    if len(argv) == 1:
        argvParser.print_help()
        sys.exit(0)

    result = listToString(createDOMList(scan_html(readfile(argvParser.parse_args().file)), argvParser.parse_args().selector))

    if len(result) == 1:
        argvParser.print_help()
        sys.exit(0)

    else:
        if argvParser.parse_args().output == '':
            print(result)

        else:
            saveToFile(argvParser.parse_args().output, result)
            print("File saved")

    
if __name__ == "__main__":
    main(sys.argv)