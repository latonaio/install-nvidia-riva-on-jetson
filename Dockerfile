FROM ubuntu:22.04
RUN apt update && apt install -y \
	python3 git gcc python3.10-venv python3-dev
RUN mkdir -p /app/src /app/mnt
WORKDIR /app/src
RUN git clone https://github.com/nvidia-riva/tutorials.git
COPY riva_quickstart_arm64_v2.1.0/riva_api-2.1.0-py3-none-any.whl /app/src/tutorials
COPY asr-python-basics.ipynb /app/src/tutorials
WORKDIR /app/src/tutorials
RUN python3 -m venv venv-riva-tutorials && . venv-riva-tutorials/bin/activate \
	&& pip3 install jupyter \
	&& pip install riva_api-2.1.0-py3-none-any.whl \
	&& ipython kernel install --user --name=venv-riva-tutorials
CMD bash
