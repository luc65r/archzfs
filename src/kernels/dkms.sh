# For build.sh
mode_name="dkms"
mode_desc="Select and use the dkms packages"

# version
pkgrel="1"

# Version for GIT packages
pkgrel_git="1"
zfs_git_commit=""
zfs_git_url="https://github.com/zfsonlinux/zfs.git"

# Version for RC packages
pkgrel_rc="1"

header="\
# Maintainer: Jan Houben <jan@nexttrex.de>
# Contributor: Jesus Alvarez <jeezusjr at gmail dot com>
#
# This PKGBUILD was generated by the archzfs build scripts located at
#
# http://github.com/archzfs/archzfs
#"

update_dkms_pkgbuilds() {
    pkg_list=("zfs-dkms")
    archzfs_package_group="archzfs-dkms"
    zfs_pkgver=${zol_version}
    zfs_mod_ver="\${pkgver}"
    zfs_pkgrel=${pkgrel}
    zfs_pkgname="zfs-dkms"
    zfs_utils_pkgname="zfs-utils=\${pkgver}"
    # Paths are relative to build.sh
    zfs_dkms_pkgbuild_path="packages/${kernel_name}/${zfs_pkgname}"
    zfs_src_target="https://github.com/zfsonlinux/zfs/releases/download/zfs-\${pkgver}/zfs-\${pkgver}.tar.gz"
    zfs_workdir="\${srcdir}/zfs-\${pkgver}"
    zfs_replaces='replaces=("spl-dkms")'
}

# update_dkms_rc_pkgbuilds() {
#     pkg_list=("zfs-dkms-rc")
#     archzfs_package_group="archzfs-dkms-rc"
#     zfs_pkgver=${zol_rc_version/-/_}
#     zfs_mod_ver="\${pkgver}"
#     zfs_pkgrel=${pkgrel_rc}
#     zfs_pkgname="zfs-dkms-rc"
#     zfs_utils_pkgname="zfs-utils-rc=\${pkgver}"
#     zfs_src_hash=${zfs_rc_src_hash}
#     Paths are relative to build.sh
#     zfs_dkms_pkgbuild_path="packages/${kernel_name}/${zfs_pkgname}"
#     zfs_src_target="https://github.com/zfsonlinux/zfs/releases/download/zfs-\${pkgver/_/-}/zfs-\${pkgver/_/-}.tar.gz"
#     zfs_workdir="\${srcdir}/zfs-\${pkgver/_rc*/}"
# }

update_dkms_git_pkgbuilds() {
    pkg_list=("zfs-dkms-git")
    archzfs_package_group="archzfs-dkms-git"
    zfs_pkgver="" # Set later by call to git_calc_pkgver
    zfs_pkgrel=${pkgrel_git}
    zfs_pkgname="zfs-dkms-git"
    zfs_dkms_pkgbuild_path="packages/${kernel_name}/${zfs_pkgname}"
    zfs_src_target="git+${zfs_git_url}"
    zfs_src_hash="SKIP"
    zfs_makedepends="\"git\""
    zfs_replaces='replaces=("spl-dkms-git")'
    zfs_workdir="\${srcdir}/zfs"

    if have_command "update"; then
        git_check_repo
        git_calc_pkgver
    fi
    zfs_utils_pkgname="zfs-utils-git=\${pkgver}"
    zfs_mod_ver="git"
    zfs_set_commit="_commit='${latest_zfs_git_commit}'"
    zfs_src_target="git+${zfs_git_url}#commit=\${_commit}"
}
