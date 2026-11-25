# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=6.26.0
QTMIN=6.11.2
inherit ecm plasma.kde.org xdg

DESCRIPTION="Plasma shell and components for phones"
HOMEPAGE="https://plasma-mobile.org/ https://invent.kde.org/plasma/plasma-mobile"

LICENSE="Apache-2.0 BSD-2 CC0-1.0 CC-BY-SA-4.0 GPL-2+ GPL-3+ LGPL-2+ LGPL-2.1+ MIT
	|| ( GPL-2 GPL-3 ) || ( LGPL-2.1 LGPL-3 )"
SLOT="6"
KEYWORDS="~arm64"

# libkwin has no stable ABI; the KWin plugins must match the 6.y series they were built against
COMMON_DEPEND="
	>=dev-libs/qcoro-0.10.0[dbus,qml]
	dev-libs/kirigami-addons:6
	dev-libs/wayland
	>=dev-qt/qtbase-${QTMIN}:6=[dbus,gui,network,wayland,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=dev-qt/qtsensors-${QTMIN}:6
	>=kde-frameworks/kauth-${KFMIN}:6
	>=kde-frameworks/kcmutils-${KFMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kdbusaddons-${KFMIN}:6
	>=kde-frameworks/kglobalaccel-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
	>=kde-frameworks/kitemmodels-${KFMIN}:6
	>=kde-frameworks/kjobwidgets-${KFMIN}:6
	>=kde-frameworks/knotifications-${KFMIN}:6
	>=kde-frameworks/kpackage-${KFMIN}:6
	>=kde-frameworks/kservice-${KFMIN}:6
	>=kde-frameworks/kwindowsystem-${KFMIN}:6
	>=kde-frameworks/modemmanager-qt-${KFMIN}:6
	>=kde-frameworks/networkmanager-qt-${KFMIN}:6
	>=kde-plasma/kpipewire-${KDE_CATV}:6
	>=kde-plasma/kwayland-${KDE_CATV}:6
	=kde-plasma/kwin-$(ver_cut 1-2)*:6
	>=kde-plasma/layer-shell-qt-${KDE_CATV}:6
	>=kde-plasma/libkscreen-${KDE_CATV}:6=
	>=kde-plasma/libplasma-${KDE_CATV}:6=
	>=kde-plasma/plasma-activities-${KDE_CATV}:6=
	>=kde-plasma/plasma-workspace-${KDE_CATV}:6=
	media-libs/libepoxy
	virtual/libudev:=
	x11-libs/libxcb:=
"
# vulkan-headers: KWinConfig.cmake calls find_dependency(Vulkan)
DEPEND="${COMMON_DEPEND}
	>=dev-libs/plasma-wayland-protocols-1.8
	dev-util/vulkan-headers
"
RDEPEND="${COMMON_DEPEND}
	dev-libs/feedbackd
	kde-apps/plasma-settings:6
	>=kde-frameworks/bluez-qt-${KFMIN}:6
	>=kde-frameworks/breeze-icons-${KFMIN}:6
	>=kde-frameworks/kdeclarative-${KFMIN}:6
	>=kde-frameworks/kirigami-${KFMIN}:6
	>=kde-frameworks/kquickcharts-${KFMIN}:6
	>=kde-frameworks/ksvg-${KFMIN}:6
	>=kde-plasma/kde-cli-tools-${KDE_CATV}:6
	>=kde-plasma/milou-${KDE_CATV}:6
	>=kde-plasma/plasma-keyboard-${KDE_CATV}:6
	>=kde-plasma/plasma-nano-${KDE_CATV}:6
	>=kde-plasma/plasma-nm-${KDE_CATV}:6
	>=kde-plasma/plasma-pa-${KDE_CATV}:6
	>=kde-plasma/powerdevil-${KDE_CATV}:6
	>=kde-plasma/qqc2-breeze-style-${KDE_CATV}:6
"
BDEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[wayland]
	dev-util/wayland-scanner
"

PATCHES=( "${FILESDIR}"/${P}-waydroid-include-ecmqmlmodule.patch )

src_configure() {
	local mycmakeargs=(
		-DINSTALL_SYSTEMD_SERVICE=ON
	)
	ecm_src_configure
}
