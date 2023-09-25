# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1 go-module toolchain-funcs

DESCRIPTION="Customization of kubernetes YAML configurations"
HOMEPAGE="https://kustomize.io/"
SRC_URI="https://github.com/kubernetes-sigs/${PN}/archive/${PN}/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://github.com/ambasta/${PN}/releases/download/${PV}/${P}-deps.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN}-${PN}-v${PV}"

# Non-fatal verify since ziphash for sub-project is missing
NONFATAL_VERIFY=1

src_compile() {
	# ego build
	CGO_LDFLAGS="" emake -j1 GOFLAGS="" GOLDFLAGS="" LDFLAGS="" WHAT=${PN}
}

src_install() {
	dobin ${PN}
	_output/bin/${PN} completion bash > ${PN}.bash || die
	_output/bin/${PN} completion zsh > ${PN}.zsh || die
	newbashcomp ${PN}.bash ${PN}
	insinto /usr/share/zsh/site-functions
	newins ${PN}.zsh _${PN}
}
