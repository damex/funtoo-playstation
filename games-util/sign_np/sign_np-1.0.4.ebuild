# Distributed under the terms of the GNU General Public License v2

EAPI="5"

DESCRIPTION="Tool to encrypt and sign PSP ISO images into PSN PBP files"
HOMEPAGE="https://github.com/Hykem/sign_np"
SRC_URI="https://github.com/Hykem/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

RESTRICT="mirror"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="*"
IUSE=""

src_install() {
	dobin "${S}/${PN}"
}
