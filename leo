#!/usr/bin/env python3
import sys, argparse, fcntl, termios, struct
from io import StringIO
import xml.etree.ElementTree as ET
import requests

terminal_height, terminal_width, hp, wp = struct.unpack("HHHH",
        fcntl.ioctl(0, termios.TIOCGWINSZ, struct.pack("HHHH", 0, 0, 0, 0)))

parser = argparse.ArgumentParser(description="dict.leo.org CLI")
parser.add_argument("word", metavar="WORD", nargs=1,
        help="a string to lookup in dictionary")
parser.add_argument("-t","--trans","--translation", default="ende",
        metavar="TRANSLATION", help="Translation (eg. ende, esde)")
parser.add_argument("-l","--lang", default="de",
        metavar="LANGUAGE-CODE", help="Interface language (eg. de, en)")
parser.add_argument("-a", action="store_true", dest="show_add",
        help="Show additional matches")
args = parser.parse_args()

url = "http://dict.leo.org/dictQuery/m-vocab/{translation}/query.xml"
r = requests.get(url.format(translation=args.trans),
        params={"lang":args.lang, "search":args.word})

if r.status_code != 200:
    print("Error: {code}".format(code=r.status_code))
    sys.exit(1)

def textvalue(element): 
    return " ".join(element.itertext())

def print_header(text,symbol):
    w = terminal_width - len(text) - 2
    print("{border} {text}{extra} {border}".format(
                border="".join([symbol]*int(w/2)),
                extra=[""," "][w%2],
                text=text))

def print_left_right(left,right):
    w = terminal_width - 1
    wl, wr = int(w/2)-len(left), int(w/2)-len(right)

    print("{left}{spaceL}|{extra}{spaceR}{right}".format(
                left=left, right=right,
                spaceL=" "*int(wl), spaceR=" "*int(wr),
                extra=[""," "][w%2]))

xmlsource = StringIO(r.text)
xml = ET.parse(xmlsource, parser=ET.XMLParser(encoding=r.encoding))
for part in xml.findall("part"):
    if part.get("direct") != "1" and not args.show_add:
        continue
    print_header(part.get("title"), "=")
    for section in part.findall("section"):
        print_header(section.get("sctTitle"),"-")
        for entry in section.findall("entry"):
            left = textvalue( entry.findall("side")[0].find("repr"))
            right = textvalue( entry.findall("side")[1].find("repr"))
            print_left_right(left,right)
