EFIBOOTMGR_VERSION="18"
EFIBOOTMGR_CHECKSUM="a92ce8fd2b282fa30f066797b14095ef"
EFIBOOTMGR_LINK="https://github.com/rhboot/efibootmgr/releases/download/${EFIBOOTMGR_VERSION}/efibootmgr-${EFIBOOTMGR_VERSION}.tar.bz2"

download_efibootmgr() {
    download_file $EFIBOOTMGR_LINK $EFIBOOTMGR_CHECKSUM
}

extract_efibootmgr() {
    if [ ! -d "efibootmgr-${EFIBOOTMGR_VERSION}" ]; then
        echo "[+] extracting: efibootmgr-v${EFIBOOTMGR_VERSION}"
        tar -xf ${DISTFILES}/efibootmgr-${EFIBOOTMGR_VERSION}.tar.bz2 -C .
    fi
}

prepare_efibootmgr() {
    echo "[+] preparing efibootmgr"
    sed -e '/extern int efi_set_verbose/d' -i src/efibootmgr.c
    sed 's/-Werror//' -i Make.defaults
}

compile_efibootmgr() {
    PKG_CONFIG_PATH=/usr/lib64/pkgconfig make ${MAKEOPTS} efibootmgr
}

install_efibootmgr() {
    cd src
    PKG_CONFIG_PATH=/usr/lib64/pkgconfig make DESTDIR=${ROOTDIR} install
}

build_efibootmgr() {
    pushd "${WORKDIR}/efibootmgr-${EFIBOOTMGR_VERSION}"

    prepare_efibootmgr
    compile_efibootmgr
    install_efibootmgr

    popd
}

registrar_efibootmgr() {
    DOWNLOADERS+=(download_efibootmgr)
    EXTRACTORS+=(extract_efibootmgr)
}

registrar_efibootmgr
