# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit autotools git-r3

DESCRIPTION="Library for Neighbor Discovery Protocol"
HOMEPAGE="https://github.com/jpirko/libndp"
EGIT_REPO_URI="https://github.com/jpirko/${PN}.git"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND=""
RDEPEND=""

src_prepare() {
	eautoreconf
}
