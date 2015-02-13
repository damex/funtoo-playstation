# Distributed under the terms of the GNU General Public License v2

EAPI="5"

DESCRIPTION="Tool to decrypt and convert PSOne Classics from PSP/PS3"
HOMEPAGE="https://github.com/Hykem/psxtract"
SRC_URI="https://github.com/Hykem/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

RESTRICT="mirror"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="*"
IUSE=""

S="${WORKDIR}/${P}/Linux"

src_compile() {
	emake -j1
}

src_install() {
	dobin "${S}/${PN}"
	dodoc ../README.md
}
