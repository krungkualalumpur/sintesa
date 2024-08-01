#!/bin/bash
echo Wally Update Started
wally install
rojo sourcemap dev.project.json --output sourcemap.json
wally-package-types --sourcemap sourcemap.json Packages #"C:/Users/Aryo Seno/Desktop/Roblox and Minecraft Stuff/sintesa"
echo Finished Wally Update