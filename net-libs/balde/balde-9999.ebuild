# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="git://github.com/balde/balde.git
		https://github.com/balde/balde.git"
	inherit git-r3 autotools
fi

DESCRIPTION="A microframework for C based on GLib and bad intentions."
HOMEPAGE="http://balde.io/"

SRC_URI="https://github.com/${PN}/${PN}/releases/download/v${PV}/${P}.tar.bz2"
KEYWORDS="~amd64 ~x86"
if [[ ${PV} = *9999* ]]; then
	SRC_URI=""
	KEYWORDS=""
fi

LICENSE="LGPL-2"
SLOT="0"
IUSE="doc test static-libs"

RDEPEND="
	>=dev-libs/glib-2.34
	x11-misc/shared-mime-info"

if [[ ${PV} = *9999* ]]; then
	RDEPEND="${RDEPEND}
		dev-util/peg"
fi

DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

REQUIRED_USE="test? ( static-libs )"

src_prepare() {
	[[ ${PV} = *9999* ]] && eautoreconf
	default
}

src_configure() {
	local myconf="--disable-leg"
	[[ ${PV} = *9999* ]] && myconf="--enable-leg"
	econf \
		$(use_enable doc) \
		$(use_enable static-libs static) \
		--disable-examples \
		--disable-valgrind \
		${myconf}
}

src_compile() {
	default
	use doc && emake doxygen
}

src_install() {
	default
	use doc && dohtml -r doc/build/html/.
}
