# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit autotools udev

GITHUB_USERNAME="codestation"
GITHUB_REPOSITORY="vitamtp"

DESCRIPTION="Library to interact with Vita's USB MTP protocol"
HOMEPAGE="https://github.com/${GITHUB_USERNAME}/${GITHUB_REPOSITORY}"
SRC_URI="https://github.com/${GITHUB_USERNAME}/${GITHUB_REPOSITORY}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

RESTRICT="mirror"

SLOT="0"
LICENSE="GPL3"
KEYWORDS="*"
IUSE="+usb +wireless
	doc rpath"

RDEPEND="virtual/udev
	doc? ( app-doc/doxygen )"

DEPEND="${RDEPEND}"

src_prepare() {
	sed -e '$a\' \
		-i "${S}/debian/${PN}4.udev" || die
	eautoreconf
}

src_configure() {
	econf --disable-static \
		$(use_enable doc doxygen) \
		$(use_enable rpath) \
		$(use_enable usb usb-support) \
		$(use_enable wireless wireless-support)
}

src_install() {
	emake DESTDIR="${D}" install
	udev_newrules "${S}/debian/${PN}4.udev" "50-${PN}.rules"
}

pkg_postinst() {
	udev_reload
}
