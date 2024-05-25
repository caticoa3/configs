#!/bin/bash
cd "$HOME"||exit
source "$HOME/anaconda3/bin/activate"
conda activate 
make jupyter_dark
source "$HOME/anaconda3/bin/deactivate"
