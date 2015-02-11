# Distributed under the terms of the GNU General Public License v2

EAPI="5"

PYTHON_COMPAT=( python{2_7,3_3} )

inherit distutils-r1 linux-info udev

DESCRIPTION="A Sony DualShock 4 userspace driver for Linux"
HOMEPAGE="https://github.com/chrippa/ds4drv"
SRC_URI="https://github.com/chrippa/ds4drv/archive/v${PV}.tar.gz -> ${P}.tar.gz"

RESTRICT="mirror"

SLOT="0"
LICENSE="MIT"
KEYWORDS="*"
IUSE=""

RDEPEND="dev-python/python-evdev
	dev-python/pyudev
	dev-python/setuptools
	virtual/udev"

DEPEND="${RDEPEND}"

pkg_setup() {
	linux-info_pkg_setup
	CONFIG_CHECK="INPUT_UINPUT HID_SONY"
	check_extra_config
}

python_install() {
	echo 'KERNEL=="uinput", MODE="0666"' > "${S}/50-ds4drv.rules"
	# hidraw wired mode
	echo 'SUBSYSTEMS=="usb", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="05c4", MODE="0666"' >> "${S}/50-ds4drv.rules"
	echo 'SUBSYSTEMS=="hid", KERNELS=="0003:054C:05C4.*", MODE="0666"' >> "${S}/50-ds4drv.rules"
	# hidraw bluetooth mode
	echo 'SUBSYSTEMS=="hid", KERNELS=="0005:054C:05C4.*", MODE="0666"' >> "${S}/50-ds4drv.rules"
	udev_dorules "${S}/50-ds4drv.rules"

	insinto "/etc"
	doins "${S}/ds4drv.conf"

	distutils-r1_python_install
}

pkg_postinst() {
	udev_reload
}
