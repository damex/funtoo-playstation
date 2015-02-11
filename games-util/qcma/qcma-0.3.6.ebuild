# Distributed under the terms of the GNU General Public License v2

EAPI="5"

PLOCALES="es ja"

PLOCALE_BACKUP=""

inherit l10n qmake-utils

DESCRIPTION="Cross-platform content manager assistant for the PS Vita"
HOMEPAGE="https://github.com/codestation/qcma"
SRC_URI="https://github.com/codestation/qcma/archive/v${PV}.tar.gz -> ${P}.tar.gz"

RESTRICT="mirror"

SLOT="0"
LICENSE="GPL3"
KEYWORDS="*"
IUSE="+qt4
	kde unity"

REQUIRED_USE="kde? ( qt4 )
	unity? ( qt4 )"

RDEPEND="dev-qt/qtcore:4
	games-util/vitamtp
	sys-apps/dbus
	virtual/ffmpeg
	virtual/notification-daemon
	kde? ( kde-base/knotify )
	qt4? ( dev-qt/qtdbus:4
		dev-qt/qtgui:4 )
	unity? ( dev-libs/libappindicator )"

DEPEND="${RDEPEND}"

locale_info_cleanup() {
	sed -e "s;resources/translations/qcma_${1}.ts;;" \
		-i "${S}/${PN}.pro" || die
	sed -e "s;<file>resources/translations/qcma_${1}.qm</file>;;" \
		-i "${S}/translations.qrc" || die
}

src_prepare() {
	l10n_for_each_disabled_locale_do locale_info_cleanup

	use kde || sed -e "s;qcma_kdenotifier.pro;;" -i "${S}/${PN}.pro" || die
	use unity || sed -e "s;qcma_appindicator.pro;;" -i "${S}/${PN}.pro" || die

	if [[ $(l10n_get_locales) ]] ; then
		lrelease -silent "${PN}.pro" || die
	fi
}

src_configure() {
	eqmake4
}

src_compile() {
	emake -j1 sub-qcma_cli-pro
	use qt4 && emake -j1 sub-qcma_gui-pro
}

src_install() {
	dobin "${S}/qcma_cli"

	if use qt4 ; then
		dobin "${S}/qcma"
		doicon "${S}/resources/images/${PN}.png"
		domenu "${S}/resources/${PN}.desktop"
	fi
}
