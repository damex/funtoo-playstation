# Distributed under the terms of the GNU General Public License v2

EAPI="5"

GITHUB_USERNAME="Hykem"
GITHUB_REPOSITORY="sign_np"

DESCRIPTION="Tool to encrypt and sign PSP ISO images into PSN PBP files"
HOMEPAGE="https://github.com/${GITHUB_USERNAME}/${GITHUB_REPOSITORY}"
SRC_URI="https://github.com/${GITHUB_USERNAME}/${GITHUB_REPOSITORY}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

RESTRICT="mirror"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="*"
IUSE=""

src_install() {
	dobin "${S}/${PN}"
}
