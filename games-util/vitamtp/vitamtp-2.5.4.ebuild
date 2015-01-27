# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit autotools

DESCRIPTION="Library to interact with Vita's USB MTP protocol"
HOMEPAGE="https://github.com/codestation/vitamtp"
SRC_URI="https://github.com/codestation/vitamtp/archive/v${PV}.tar.gz -> ${P}.tar.gz"

RESTRICT="mirror"

SLOT="0"
LICENSE="GPL3"
KEYWORDS="*"
IUSE="rpath +usb +wireless"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf $(use_enable rpath) \
		$(use_enable usb usb-support) \
		$(use_enable wireless wireless-support)
}
