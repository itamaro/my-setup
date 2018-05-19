#!/bin/bash

echo "Save versions of installed Python & Pip"
python -V &> python.version
pip -V > pip.version 2> /dev/null
