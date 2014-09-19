# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="git://github.com/rafaelmartins/rant.git
		https://github.com/rafaelmartins/rant.git"
	inherit git-r3 autotools
fi

DESCRIPTION="A web app to publish single-page rants written in markdown using GitHub Gists."
HOMEPAGE="https://github.com/rafaelmartins/rant"

SRC_URI="https://github.com/rafaelmartins/${PN}/releases/download/v${PV}/${P}.tar.bz2"
KEYWORDS="~amd64 ~x86"
if [[ ${PV} = *9999* ]]; then
	SRC_URI=""
	KEYWORDS=""
fi

LICENSE="LGPL-2"
SLOT="0"
IUSE="test"

RDEPEND="
	=net-libs/balde-9999
	=net-libs/balde-markdown-9999
	>=dev-libs/json-glib-0.16.2
	net-misc/curl"

DEPEND="${RDEPEND}"

src_prepare() {
	[[ ${PV} = *9999* ]] && eautoreconf
	default
}

src_configure() {
	econf \
		--without-valgrind
}
