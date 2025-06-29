# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Autogenerated by pycargoebuild 0.13.2

EAPI=8

CRATES="
	ab_glyph_rasterizer@0.1.8
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	autocfg@1.2.0
	bitflags@1.3.2
	bumpalo@3.16.0
	calloop@0.9.3
	cc@1.0.95
	cfg-if@1.0.0
	chrono@0.4.38
	core-foundation-sys@0.8.6
	dlib@0.5.2
	downcast-rs@1.2.1
	getopts@0.2.21
	greetd_ipc@0.10.0
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.60
	itoa@1.0.11
	js-sys@0.3.69
	lazy_static@1.4.0
	libc@0.2.153
	libloading@0.8.3
	log@0.4.21
	memmap2@0.3.1
	memoffset@0.6.5
	nix@0.22.3
	nix@0.24.3
	nix@0.25.1
	num-traits@0.2.18
	once_cell@1.19.0
	os_pipe@1.1.5
	owned_ttf_parser@0.15.2
	pin-utils@0.1.0
	pkg-config@0.3.30
	proc-macro2@1.0.81
	quote@1.0.36
	rusttype@0.9.3
	ryu@1.0.17
	scoped-tls@1.0.1
	serde@1.0.198
	serde_derive@1.0.198
	serde_json@1.0.116
	smallvec@1.13.2
	smithay-client-toolkit@0.15.4
	syn@2.0.60
	thiserror-impl@1.0.58
	thiserror@1.0.58
	toml@0.5.11
	ttf-parser@0.15.2
	unicode-ident@1.0.12
	unicode-width@0.1.11
	wasm-bindgen-backend@0.2.92
	wasm-bindgen-macro-support@0.2.92
	wasm-bindgen-macro@0.2.92
	wasm-bindgen-shared@0.2.92
	wasm-bindgen@0.2.92
	wayland-client@0.29.5
	wayland-commons@0.29.5
	wayland-cursor@0.29.5
	wayland-protocols@0.29.5
	wayland-scanner@0.29.5
	wayland-sys@0.29.5
	windows-core@0.52.0
	windows-sys@0.52.0
	windows-targets@0.52.5
	windows_aarch64_gnullvm@0.52.5
	windows_aarch64_msvc@0.52.5
	windows_i686_gnu@0.52.5
	windows_i686_gnullvm@0.52.5
	windows_i686_msvc@0.52.5
	windows_x86_64_gnu@0.52.5
	windows_x86_64_gnullvm@0.52.5
	windows_x86_64_msvc@0.52.5
	xcursor@0.3.5
	xml-rs@0.8.20
"

RUST_MAX_VER="1.87.0"
RUST_MIN_VER="1.71.1"

inherit flag-o-matic cargo rust

DESCRIPTION="wlgreet"
HOMEPAGE="https://git.sr.ht/~kennylevinsen/wlgreet"
SRC_URI="
	https://git.sr.ht/~kennylevinsen/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris ${CRATES})
"
RESTRICT="mirror"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+clang"

BDEPEND="
	clang? (
		llvm-core/clang
		|| (
			llvm-core/lld
			sys-devel/mold
		)
		llvm-core/llvm
	)
"
DEPEND="${BDEPEND}
	>=gui-libs/greetd-0.6.1
	>=dev-libs/wayland-protocols-1.20
"

pkg_setup() {
	rust_pkg_setup
}

src_configure() {
	if use clang && ! tc-is-clang; then
		CC=${CHOST}-clang
		CXX=${CHOST}-clang++
		strip-unsupported-flags
	elif ! use clang && ! tc-is-gcc; then
		CC=${CHOST}-gcc
		CXX=${CHOST}-g++
		strip-unsupported-flags
	fi
}

src_compile() {
	cargo_src_compile
}
