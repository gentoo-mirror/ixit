# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson xdg vala virtualx

COMMIT="4c9153abe3e936fb9bf3f4aa1c3c745ca222615b"
DESCRIPTION="Library with GTK widgets for mobile phones"
HOMEPAGE="https://gitlab.gnome.org/GNOME/libhandy/"
SRC_URI="https://gitlab.gnome.org/GNOME/libhandy/-/archive/${PV}/${PV}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="LGPL-2.1+"
SLOT="1.0/0" # It may or may not break ABI in future versions at this point; if new
# SLOT happens, it'll likely file conflict on gtk-doc and glade library and catalog
KEYWORDS="~amd64 ~arm ~arm64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"

IUSE="examples glade gtk-doc +introspection test +vala"
REQUIRED_USE="vala? ( introspection )"
RESTRICT="!test? ( test )"
S="${WORKDIR}/${P}-${COMMIT}"

RDEPEND="
	>=dev-libs/glib-2.44:2
	>=x11-libs/gtk+-3.24.1:3[introspection?]
	glade? ( dev-util/glade:3.10= )
	introspection? ( >=dev-libs/gobject-introspection-1.54:= )
"
DEPEND="${RDEPEND}"
BDEPEND="
	vala? ( $(vala_depend) )
	dev-libs/libxml2:2
	dev-util/glib-utils
	>=sys-devel/gettext-0.19.8
	virtual/pkgconfig
	gtk-doc? ( dev-util/gtk-doc
		app-text/docbook-xml-dtd:4.3 )
"

src_prepare() {
	cp "${FILESDIR}/${P}-run.in" "${S}/run.in" || die
	use vala && vala_src_prepare
	xdg_src_prepare
}

src_configure() {
	local emesonargs=(
		-Dprofiling=false # -pg passing
		-Dstatic=false
		$(meson_feature introspection)
		$(meson_use vala vapi)
		$(meson_use gtk-doc gtk_doc)
		$(meson_use test tests)
		$(meson_use examples)
		$(meson_feature glade glade_catalog)
	)
	meson_src_configure
}

src_test() {
	virtx meson_src_test
}