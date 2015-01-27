# Distributed under the terms of the GNU General Public License v2

EAPI="5"

PLOCALES="es ja"

PLOCALE_BACKUP=""

inherit eutils l10n qmake-utils

DESCRIPTION="Cross-platform content manager assistant for the PS Vita"
HOMEPAGE="https://github.com/codestation/qcma"
SRC_URI="https://github.com/codestation/qcma/archive/v${PV}.tar.gz -> ${P}.tar.gz"

RESTRICT="mirror"

SLOT="0"
LICENSE="GPL3"
KEYWORDS="*"
IUSE="+qt4
	kde libnotify unity"

REQUIRED_USE="kde? ( qt4 )
	unity? ( qt4 )"

RDEPEND="dev-qt/qtcore:4
	games-util/vitamtp
	sys-apps/dbus
	virtual/ffmpeg
	kde? ( kde-base/knotify )
	libnotify? ( virtual/notification-daemon )
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

	if ! use_if_iuse kde ; then
		sed -e "s;ENABLE_KDENOTIFIER;DISABLE_KDENOTIFIER;" \
			-i "${S}/${PN}.pro" || die
	fi

	if ! use_if_iuse unity ; then
		sed -e "s;ENABLE_APPINDICATOR;DISABLE_APPINDICATOR;" \
			-i "${S}/${PN}.pro" || die
	fi

	if [[ $(l10n_get_locales) ]] ; then
		lrelease -silent ${PN}.pro || die
	fi
}

src_compile() {
	eqmake4
	if use qt4 ; then
		emake -j1 sub-qcma_gui-pro
	else
		emake -j1 sub-qcma_cli-pro
	fi
}

src_install() {
	dobin "${S}/qcma_cli"

	if use qt4 ; then
		dobin "${S}/qcma"
		doicon "${S}/resources/images/${PN}.png"
		domenu "${S}/resources/${PN}.desktop"
	fi
}
