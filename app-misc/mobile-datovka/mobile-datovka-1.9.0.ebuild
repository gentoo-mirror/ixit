# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils xdg-utils

DESCRIPTION="GUI to access the Czech data box e-government system"
HOMEPAGE="https://www.datovka.cz/"
SRC_URI="https://gitlab.labs.nic.cz/datovka/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~arm ~arm64 ~amd64 ~x86"
IUSE=""

# minimum Qt version required
QT_PV="5.13.1:5"

RDEPEND="
	>=dev-libs/openssl-1.1.1:0=
	>=dev-qt/qtcore-${QT_PV}
	>=dev-qt/qtgui-${QT_PV}
	>=dev-qt/qtnetwork-${QT_PV}
	>=dev-qt/qtprintsupport-${QT_PV}
	>=dev-qt/qtsql-${QT_PV}[sqlite]
	>=dev-qt/qtsvg-${QT_PV}
	>=dev-qt/qtwidgets-${QT_PV}
	>=dev-qt/qtquickcontrols-${QT_PV}
	>=dev-qt/qtquickcontrols2-${QT_PV}
"
DEPEND="
	${RDEPEND}
	>=dev-qt/linguist-tools-${QT_PV}
	virtual/pkgconfig
"

S="${WORKDIR}/${PN}-v${PV}"

PATCHES=( "${FILESDIR}/${PN}-1.9.0-builddirtyfix.patch" )

src_configure() {
	lrelease ${PN}.pro || die
	eqmake5 PREFIX="/usr" TEXT_FILES_INST_DIR="/usr/share/${PN}/"
}

src_install() {
	emake install INSTALL_ROOT="${D}"
	einstalldocs
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
