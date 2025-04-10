FROM ubuntu:24.04

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install prerequisites
RUN apt update && apt upgrade -y && \
    apt install -y \
    sudo \
    git \
    wget \
    curl \
    build-essential \
    cmake \
    pkg-config \
    gettext \
    ninja-build \
    libtool \
    libtool-bin \
    autoconf \
    automake \
    g++ \
    unzip \
    python3 \
    python3-pip \
    locales \
    ripgrep \
    fd-find

# Set up locale
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

# Create a non-root user
RUN useradd -m -s /bin/bash nvim_user && \
    echo "nvim_user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/nvim_user

# Switch to the non-root user
USER nvim_user
WORKDIR /home/nvim_user

# Download and run the installer script
RUN wget https://raw.githubusercontent.com/S-Spektrum-M/mach-nvim/main/install.sh && \
    chmod +x install.sh && \
    ./install.sh -nupig -m SOURCE

# Add mach-update to PATH
ENV PATH="/home/nvim_user/.local/bin:${PATH}"

# Set up a working directory for projects
RUN mkdir -p /home/nvim_user/projects
WORKDIR /home/nvim_user/projects

# Set the entrypoint to nvim
ENTRYPOINT ["nvim"]
