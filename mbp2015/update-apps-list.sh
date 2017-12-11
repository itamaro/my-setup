#!/bin/bash

echo "Save all apps found under /Applications directory"
find /Applications -maxdepth 1 -type d -iname "*.app" > apps.list
