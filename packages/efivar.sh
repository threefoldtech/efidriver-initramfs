EFIVAR_VERSION="39"
EFIVAR_CHECKSUM="a8fc3e79336cd6e738ab44f9bc96a5aa"
EFIVAR_LINK="https://github.com/rhboot/efivar/archive/refs/tags/${EFIVAR_VERSION}.tar.gz"

download_efivar() {
    download_file $EFIVAR_LINK $EFIVAR_CHECKSUM efivar-${EFIVAR_VERSION}.tar.gz
}

extract_efivar() {
    if [ ! -d "efivar-${EFIVAR_VERSION}" ]; then
        echo "[+] extracting: efivar-v${EFIVAR_VERSION}"
        tar -xf ${DISTFILES}/efivar-${EFIVAR_VERSION}.tar.gz -C .
    fi
}

prepare_efivar() {
    echo "[+] preparing efivar"
}

compile_efivar() {
    make LIBDIR=/usr/lib/x86_64-linux-gnu ${MAKEOPTS}
}

install_efivar() {
    make LIBDIR=/usr/lib/x86_64-linux-gnu install
    make LIBDIR=/usr/lib/x86_64-linux-gnu DESTDIR=${ROOTDIR} install
}

build_efivar() {
    pushd "${WORKDIR}/efivar-${EFIVAR_VERSION}"

    prepare_efivar
    compile_efivar
    install_efivar

    popd
}

registrar_efivar() {
    DOWNLOADERS+=(download_efivar)
    EXTRACTORS+=(extract_efivar)
}

registrar_efivar
