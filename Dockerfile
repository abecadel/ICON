FROM nvidia/cuda:11.1.1-cudnn8-devel-ubuntu20.04
WORKDIR /app

ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"

RUN apt-get update
RUN apt-get install -y wget git

RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh 
RUN conda update -n base -c defaults conda -y
RUN conda init

COPY environment.yaml .
RUN conda env create -f environment.yaml

SHELL ["conda", "run", "-n", "icon", "/bin/bash", "-c"]

COPY requirements.txt .
RUN pip install -r requirements.txt --use-deprecated=legacy-resolver
