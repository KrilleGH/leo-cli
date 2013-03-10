#leo-cli
===================

leo-cli is a command line tool which can be used to translate words or phrases from several languages to german. It uses the open dictionary [dict.leo.org][]. I wrote this because visiting their website, choosing the language, typing the word and clicking the submit button required several too many steps. I am a lazy person.

[dict.leo.org]: http://dict.leo.org



##Installation
===================
This tool requires the wonderful requests library.
###install requests
pip install requests

###install leo-cli
pip install leo-cli

This package collides with https://github.com/JoiDegn/leo-cli/

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

