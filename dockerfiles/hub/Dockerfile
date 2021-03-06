FROM ubuntu:20.04


ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      git \
      vim \
      less \
      python-dev \
      python3 \
      python3-dev \
      python3-pip \
      python3-setuptools \
      python3-wheel \
      libssl-dev \
      libffi-dev \
      libxml2-dev \
      libxslt1-dev \
      zlib1g-dev \
      libpq-dev \
      libcurl4-openssl-dev \
      build-essential \
      sqlite3 \
      curl \
      dnsutils \
      && \
    apt-get purge && apt-get clean

ARG NB_USER=jovyan
ARG NB_UID=1000
ARG HOME=/home/jovyan

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    --home ${HOME} \
    --force-badname \
    ${NB_USER}

RUN python3 -m pip install --upgrade --no-cache setuptools pip wheel

#RUN wget https://files.pythonhosted.org/packages/8e/a7/ab45c9ee3c4654edda3efbd6b8e2fa4962226718a7e3e3be6e3926bf3617/py_spy-0.3.3-py2.py3-none-manylinux1_x86_64.whl
#RUN PYCURL_SSL_LIBRARY=openssl pip3 install --no-cache-dir https://files.pythonhosted.org/packages/8e/a7/ab45c9ee3c4654edda3efbd6b8e2fa4962226718a7e3e3be6e3926bf3617/py_spy-0.3.3-py2.py3-none-manylinux1_x86_64.whl

COPY requirements.txt /tmp/requirements.txt

## NOTE: This is a default and be overridden by chartpress using the
##       chartpress.yaml configuration
ARG JUPYTERHUB_VERSION=1.1.0

RUN PYCURL_SSL_LIBRARY=openssl pip3 install --no-cache-dir \
         -r /tmp/requirements.txt \
         $(bash -c 'if [[ $JUPYTERHUB_VERSION == "git"* ]]; then \
            echo ${JUPYTERHUB_VERSION}; \
          else \
            echo jupyterhub==${JUPYTERHUB_VERSION}; \
          fi')

WORKDIR /srv/jupyterhub

# So we can actually write a db file here
RUN chown ${NB_USER}:${NB_USER} /srv/jupyterhub

# JupyterHub API port
EXPOSE 8081

# when building the dependencies image
# add pip-tools necessary for computing dependencies
# this is not done in production builds by chartpress
ARG PIP_TOOLS=
RUN test -z "$PIP_TOOLS" || pip install --no-cache pip-tools==$PIP_TOOLS

USER ${NB_USER}
CMD ["jupyterhub", "--config", "/etc/jupyterhub/jupyterhub_config.py"]
