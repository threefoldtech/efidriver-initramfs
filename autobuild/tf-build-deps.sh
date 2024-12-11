#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
export DEBCONF_NONINTERACTIVE_SEEN=true

# install dependencies for building
apt-get update

# toolchain dependencies
deps=(pkg-config make m4 autoconf zstd build-essential)

# system tools and libs
deps+=(libssl-dev dnsmasq git curl bc wget)

# dirty list, needs to be documented
deps+=(xz-utils lbzip2 libtool gettext uuid-dev)
deps+=(libglib2.0-dev libfuse-dev libxml2-dev libpciaccess-dev)

# udev and modules
deps+=(gperf libelf-dev libkmod-dev liblzma-dev kmod xsltproc linuxdoc-tools docbook-xsl)

# efivar and efibootmgr
deps+=(libefiboot-dev libpopt-dev mandoc)

# hexdump
deps+=(bsdmainutils)

apt-get install -y ${deps[@]}

