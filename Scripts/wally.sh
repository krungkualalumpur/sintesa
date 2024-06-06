#!/bin/bash
echo Wally Update Started
wally install
rojo sourcemap default.project.json --output sourcemap.json
wally-package-types --sourcemap sourcemap.json Packages
echo Finished Wally Update