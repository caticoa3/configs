#!/bin/bash
cd "$HOME"||exit
source "$HOME/anaconda3/bin/activate"
conda activate 
make jupyter_light
source "$HOME/anaconda3/bin/deactivate"
