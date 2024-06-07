#!/bin/bash
js_to_lua="C:/Users/User/Documents/GitHub/js-to-lua"
input="C:/Users/User/Documents/GitHub/material-color-utilities"
sintesa="C:/Users/User/Documents/GitHub/sintesa"
out="${sintesa}/src/Shared/Sintesa/Styles/MaterialColor"
convertFile="${js_to_lua}/apps/convert-js-to-lua/src/index.js"
echo $convertFile
#$convertFile 
"${convertFile}"  --experimental-modules --input "${input}/typescript" --output $out 
