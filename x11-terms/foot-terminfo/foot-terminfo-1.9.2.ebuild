# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Terminfo for foot, wayland terminal emulator"
HOMEPAGE="https://codeberg.org/dnkl/foot"
SRC_URI="https://codeberg.org/dnkl/foot/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/foot"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
RESTRICT="test"

BDEPEND="sys-libs/ncurses"

src_configure() {
	local emesonargs=(
		-Dterminfo=disabled
		-Ddocs=disabled
		-Dime=false
		-Dgrapheme-clustering=disabled
		-Dterminfo=enabled
		-Ddefault-terminfo=xterm-foot
	)

	meson_src_configure
}

src_compile() { :; }

src_install() {
	dodir /usr/share/terminfo
	tic -xo "${ED}"/usr/share/terminfo ${BUILD_DIR}/foot.info.preprocessed || die
}