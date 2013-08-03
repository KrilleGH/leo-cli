#!/usr/bin/env python3
"""http://dict.leo.org CLI utility"""
import sys, argparse, fcntl, termios, struct
import xml.etree.ElementTree as ET
import requests

TERMINAL_HEIGHT, TERMINAL_WIDTH, HP, WP = struct.unpack("HHHH",
        fcntl.ioctl(0, termios.TIOCGWINSZ, struct.pack("HHHH", 0, 0, 0, 0)))

def textvalue(element): 
    """returns the textual representation of a xml fragment"""
    return " ".join(element.itertext())

def print_header(text, symbol):
    """prints a ======== header ======= row"""
    width = TERMINAL_WIDTH - len(text) - 2
    print("{border} {text}{extra} {border}".format(
                border="".join([symbol]*int(width/2)),
                extra=[""," "][width%2],
                text=text))

def print_left_right(left, right):
    """prints two columns of text"""
    width = TERMINAL_WIDTH - 1
    width_left, width_right = int(width/2)-len(left), int(width/2)-len(right)

    print("{left}{spaceL}|{extra}{spaceR}{right}".format(
                left=left, right=right,
                spaceL=" "*int(width_left), spaceR=" "*int(width_right),
                extra=[""," "][width%2]))

def main():
    """main entry point"""
    parser = argparse.ArgumentParser(description="dict.leo.org CLI")
    parser.add_argument("word", metavar="WORD", nargs='?',
            help="a string to lookup in dictionary")
    parser.add_argument("-t", "--trans", "--translation", default="ende",
            metavar="TRANSLATION", help="Translation (eg. ende, esde)")
    parser.add_argument("-l", "--lang", default="de",
            metavar="LANGUAGE-CODE", help="Interface language (eg. de, en)")
    args = parser.parse_args()

    if not args.word:
        args.word = input("leo {0}> ".format(args.trans))

    url = "http://dict.leo.org/dictQuery/m-vocab/{translation}/query.xml"
    response = requests.get(url.format(translation=args.trans),
            params={"lang":args.lang, "search":args.word})

    if response.status_code != 200:
        print("Error: {code}".format(code=response.status_code))
        sys.exit(1)

    xml = ET.fromstring(response.text)
    for section in xml.findall("sectionlist/section"):
        print_header(section.get("sctTitle"),"-")
        for entry in section.findall("entry"):
            left = textvalue(entry.findall("side")[0].find("repr"))
            right = textvalue(entry.findall("side")[1].find("repr"))
            print_left_right(left, right)

if __name__ == "__main__":
    main()
