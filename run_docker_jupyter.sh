#!/bin/bash
docker build -t icon .
docker run --gpus all -p 8888:8888 -v `pwd`:/app  -it icon conda run -n icon jupyter notebook --ip=0.0.0.0 --no-browser --allow-root --NotebookApp.token='' --NotebookApp.password=''

