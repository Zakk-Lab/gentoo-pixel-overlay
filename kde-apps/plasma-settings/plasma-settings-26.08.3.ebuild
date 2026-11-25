# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KDE_ORG_CATEGORY="plasma-mobile"
KFMIN=6.27.0
QTMIN=6.11.2
inherit ecm gear.kde.org xdg

DESCRIPTION="Settings application for Plasma Mobile"
HOMEPAGE="https://invent.kde.org/plasma-mobile/plasma-settings"

LICENSE="BSD-2 CC0-1.0 CC-BY-4.0 GPL-2+ || ( GPL-2 GPL-3 )"
SLOT="6"
KEYWORDS="~arm64"

DEPEND="
	>=dev-libs/kirigami-addons-1.0:6
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=kde-frameworks/kcmutils-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kcrash-${KFMIN}:6
	>=kde-frameworks/kdbusaddons-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kitemmodels-${KFMIN}:6
	>=kde-frameworks/kitemviews-${KFMIN}:6
	>=kde-frameworks/kservice-${KFMIN}:6
"
RDEPEND="${DEPEND}
	>=kde-frameworks/kirigami-${KFMIN}:6
"
