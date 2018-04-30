FROM ubuntu:16.04

# PACKAGES: Build and runtime.
#   NOTE: PYTHONDONTWRITEBYTECODE: Configure Python not to try to write .pyc files on the import of source
#         modules.
#   NOTE: DEBIAN_FRONTEND: Avoid installations ask for user input.
ENV \
    DEBIAN_FRONTEND=noninteractive  \
    PYTHONDONTWRITEBYTECODE=true  \
    RUNTIME_PACKAGES="curl git unzip ca-certificates"
RUN apt-get update -q  && \
    apt-get install -y --no-install-recommends $RUNTIME_PACKAGES

# LOCALE
#   NOTE: We must agree to have one language, timezone and locale for all our docker images.
RUN apt-get install -y --no-install-recommends locales  && \
    locale-gen en_US.UTF-8  && \
    dpkg-reconfigure locales
ENV \
    LANG=en_US.UTF-8  \
    LANGUAGE=en_US.UTF-8  \
    LC_ALL=en_US.UTF-8

# TIMEZONE
RUN apt-get install -y --no-install-recommends  tzdata  && \
    echo "America/Sao_Paulo" > /etc/timezone && \
    dpkg-reconfigure --frontend noninteractive tzdata

# PYENV: Use pyenv to build the desired version of Python (defined by PYENV_VERSION var).
ENV PYENV_ROOT=/pyenv
ENV PYENV_INSTALL_VERSION=v1.2.3  \
    PATH=$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH  \
    PYENV_VERSION=3.6.5
RUN BUILD_DEPS="build-essential dpkg-dev libbz2-dev libreadline-dev libsqlite3-dev libssl-dev zlib1g-dev"  && \
    apt-get install -y --no-install-recommends $BUILD_DEPS  && \
    git clone https://github.com/pyenv/pyenv.git $PYENV_ROOT  && \
    cd $PYENV_ROOT  && \
    git checkout $PYENV_INSTALL_VERSION -b deploy  && \
    $PYENV_ROOT/bin/pyenv install $PYENV_VERSION  && \
    apt-get purge -y --auto-remove $BUILD_DEPS
