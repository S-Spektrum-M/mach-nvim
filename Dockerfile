# Use this Dockerfile to test the installation script in different environments.
#
# To build the Ubuntu tester:
#   docker build --target ubuntu-tester -t mach-nvim-ubuntu-tester .
#
# To run the Ubuntu tester interactively:
#   docker run -it mach-nvim-ubuntu-tester
#
# To build the RHEL (Fedora) tester:
#   docker build --target rhel-tester -t mach-nvim-rhel-tester .
#
# To run the RHEL (Fedora) tester interactively:
#   docker run -it mach-nvim-rhel-tester

# --- Ubuntu Build Stage ---
FROM ubuntu:22.04 AS ubuntu-tester

# Set non-interactive frontend
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies for the script and for building Neovim
RUN apt-get update && apt-get install -y \
    sudo \
    git \
    curl \
    make \
    unzip \
    ninja-build \
    gettext \
    libtool \
    libtool-bin \
    autoconf \
    automake \
    cmake \
    g++ \
    pkg-config

# Create a non-root user and grant passwordless sudo
RUN useradd -m -s /bin/bash -G sudo tester
RUN echo "tester ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Switch to the non-root user
USER tester
WORKDIR /home/tester

# Copy the project files
COPY . /home/tester/mach-nvim

WORKDIR /home/tester/mach-nvim

# Provide an interactive shell to run the tests
CMD ["/bin/bash"]


# --- RHEL (Fedora) Build Stage ---
FROM fedora:latest AS rhel-tester

# Install dependencies for the script and for building Neovim
RUN dnf install -y \
    sudo \
    git \
    curl \
    make \
    unzip \
    ninja-build \
    gettext \
    libtool \
    autoconf \
    automake \
    cmake \
    gcc \
    gcc-c++ \
    pkgconfig \
    patch

# Create a non-root user and grant passwordless sudo
RUN useradd -m -s /bin/bash tester
RUN echo "tester ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Switch to the non-root user
USER tester
WORKDIR /home/tester

# Copy the project files
COPY . /home/tester/mach-nvim

WORKDIR /home/tester/mach-nvim

# Provide an interactive shell to run the tests
CMD ["/bin/bash"]
