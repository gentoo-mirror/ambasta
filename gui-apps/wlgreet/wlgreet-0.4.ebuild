# Copyright 2017-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Auto-Generated by cargo-ebuild 0.3.1

EAPI=7

CRATES="
android_system_properties-0.1.5
approx-0.3.2
autocfg-1.1.0
bitflags-1.3.2
bumpalo-3.11.1
byteorder-1.4.3
calloop-0.9.3
cc-1.0.78
cfg-if-0.1.10
cfg-if-1.0.0
chrono-0.4.23
codespan-reporting-0.11.1
core-foundation-sys-0.8.3
cxx-1.0.85
cxx-build-1.0.85
cxxbridge-flags-1.0.85
cxxbridge-macro-1.0.85
dlib-0.5.0
downcast-rs-1.2.0
getopts-0.2.21
greetd_ipc-0.8.0
iana-time-zone-0.1.53
iana-time-zone-haiku-0.1.1
itoa-1.0.5
js-sys-0.3.60
lazy_static-1.4.0
libc-0.2.139
libloading-0.7.4
link-cplusplus-1.0.8
log-0.4.17
memchr-2.5.0
memmap2-0.3.1
memoffset-0.6.5
minimal-lexical-0.2.1
nix-0.15.0
nix-0.22.3
nix-0.24.3
nom-7.1.1
num-integer-0.1.45
num-traits-0.2.15
once_cell-1.16.0
ordered-float-1.1.1
os_pipe-0.8.2
pkg-config-0.3.26
proc-macro2-1.0.49
quote-1.0.23
rusttype-0.7.9
rusttype-0.8.3
ryu-1.0.12
scoped-tls-1.0.1
scratch-1.0.3
serde-1.0.151
serde_derive-1.0.151
serde_json-1.0.91
smallvec-1.10.0
smithay-client-toolkit-0.15.4
stb_truetype-0.3.1
syn-1.0.107
termcolor-1.1.3
thiserror-1.0.38
thiserror-impl-1.0.38
time-0.1.45
toml-0.5.10
unicode-ident-1.0.6
unicode-width-0.1.10
unicode-xid-0.2.2
version_check-0.9.3
void-1.0.2
wasi-0.10.0+wasi-snapshot-preview1
wasm-bindgen-0.2.83
wasm-bindgen-backend-0.2.83
wasm-bindgen-macro-0.2.83
wasm-bindgen-macro-support-0.2.83
wasm-bindgen-shared-0.2.83
wayland-client-0.29.5
wayland-commons-0.29.5
wayland-cursor-0.29.5
wayland-protocols-0.29.5
wayland-scanner-0.29.5
wayland-sys-0.29.5
winapi-0.3.9
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.5
winapi-x86_64-pc-windows-gnu-0.4.0
xcursor-0.3.4
xml-rs-0.8.4
"

inherit flag-o-matic cargo

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
		sys-devel/clang
		|| (
			sys-devel/lld
			sys-devel/mold
		)
		sys-devel/llvm
	)
"
DEPEND="${BDEPEND}
	>=gui-libs/greetd-0.6.1
	>=dev-libs/wayland-protocols-1.20
"

PATCHES=(
	"${FILESDIR}/0001-Bump-dependencies.patch"
)

src_configure() {
	if use clang && ! tc-is-clang ; then
		CC=${CHOST}-clang
		CXX=${CHOST}-clang++
		strip-unsupported-flags
	elif ! use clang && ! tc-is-gcc ; then
		CC=${CHOST}-gcc
		CXX=${CHOST}-g++
		strip-unsupported-flags
	fi
}

src_compile() {
	cargo_src_compile
}
