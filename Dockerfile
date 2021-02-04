FROM pytorch/pytorch:1.7.1-cuda11.0-cudnn8-runtime

WORKDIR /workspace

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get -y install gcc g++ && \
    rm -rf /var/lib/apt/lists/*

COPY . .

RUN python -m pip install -r ./requirements/dev.in
RUN python -m pip install -r ./requirements/prod.in

RUN echo "export PYTHONPATH=.:$PYTHONPATH" > ~/.bashrc