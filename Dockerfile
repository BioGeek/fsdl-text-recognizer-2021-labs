FROM nvidia/cuda:10.2-cudnn7-runtime-ubuntu18.04

WORKDIR /workspace

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
  && apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python

COPY . .

RUN python -m pip install -r ./requirements/dev.in
RUN python -m pip install -r ./requirements/prod.in

RUN echo "export PYTHONPATH=.:$PYTHONPATH" > ~/.bashrc