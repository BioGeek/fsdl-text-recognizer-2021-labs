FROM nvidia/cuda:10.2-cudnn7-runtime-ubuntu18.04

WORKDIR /workspace

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get -y install gcc g++ python3 python3-pip && \
    rm -rf /var/lib/apt/lists/*

COPY . .

RUN python -m pip install -r ./requirements/dev.in
RUN python -m pip install -r ./requirements/prod.in

RUN echo "export PYTHONPATH=.:$PYTHONPATH" > ~/.bashrc