#leo-cli
===================

leo-cli is a command line tool to lookup words on http://dict.leo.org

This package collide with https://github.com/JoiDegn/leo-cli/ .

##Installation
===================
###install leo-cli

leo-cli requires python3

    pip install leo-cli
    #or 
    pip-3.2 install --user leo-cli

##usage:
===================

    usage: leo [-h] [-t TRANSLATION] [-a] WORD

    dict.leo.org CLI

    positional arguments:
      WORD                  a string to lookup in dictionary

    optional arguments:
      -h, --help            show this help message and exit
      -t TRANSLATION, --trans TRANSLATION, --translation TRANSLATION
                            Translation (e.g. ende, esde)
      -l LANGUAGE-CODE, --lang LANGUAGE-CODE
                            Interface language (eg. de, en)
      -a                    Show additional matches

