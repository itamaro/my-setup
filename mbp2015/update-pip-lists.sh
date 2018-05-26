#!/bin/bash

echo "Save versions of installed Python & Pip, 2 & 3"
python3 -V &> python3.version
pip3 -V > pip3.version 2> /dev/null
python2 -V &> python2.version
pip2 -V > pip2.version 2> /dev/null

echo "Save list of installed pip3 packages"
pip3 freeze > pip3.freeze 2> /dev/null
