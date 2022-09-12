FROM nvidia/cuda:11.3.1-base-ubuntu20.04
ARG PYTHON_VERSION=3.8.5
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    ccache \
    cmake \
    curl \
    wget \
    git \
    byobu \
    libglib2.0-0 \
    libjpeg-dev \
    libsm6 libxext6 libxrender-dev \
    libpng-dev && \
    rm -rf /var/lib/apt/lists/*

RUN /usr/sbin/update-ccache-symlinks
RUN mkdir /opt/ccache && ccache --set-config=cache_dir=/opt/ccache
ENV PATH /opt/conda/bin:$PATH

RUN curl -fsSL -v -o ~/miniconda.sh -O "https://repo.anaconda.com/miniconda/Miniconda3-py38_4.12.0-Linux-x86_64.sh" \
    && chmod +x ~/miniconda.sh \
    && ~/miniconda.sh -b -p /opt/conda \
    && rm ~/miniconda.sh \
    && /opt/conda/bin/conda init \
    && /opt/conda/bin/conda install -y python=${PYTHON_VERSION} numpy=1.19.2 cmake conda-build pyyaml ipython \
    && /opt/conda/bin/conda install -y -c pytorch magma-cuda113 \
    && /opt/conda/bin/conda clean -ya
ENV PATH /opt/conda/bin:$PATH

COPY requirements.txt .
RUN /opt/conda/bin/conda install pytorch=1.11.0 torchvision=0.12.0 cudatoolkit=11.3 -c pytorch

RUN pip install --upgrade pip \
    && pip install -r requirements.txt \
    && pip install gradio==3.1.7 \
    && pip install Jinja2==3.0.1

VOLUME /root/.cache
VOLUME /data
VOLUME /output
VOLUME /model

ENV PYTHONUNBUFFERED=1
ENV GRADIO_SERVER_NAME=0.0.0.0
ENV GRADIO_SERVER_PORT=7860
EXPOSE 7860

# RUN ln -s /model /root/stable-diffusion/models/ldm/stable-diffusion-v1 \
#     && mkdir -p /output /root/stable-diffusion/outputs \
#     && ln -s /output /root/stable-diffusion/outputs/txt2img-samples

WORKDIR /workspace/stable-diffusion

# ENTRYPOINT ["/root/stable-diffusion/docker-bootstrap.sh"]
# CMD python opt/txt2img_gradio.py
