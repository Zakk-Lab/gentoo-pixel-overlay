# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_BUILD="cheetah-cp4a.261105.040.a1"
MY_ARCHIVE="${MY_BUILD}-factory-b255f8dd.zip"

DESCRIPTION="Google Pixel 7 Pro haptics, AoC, speaker protection and Bluetooth firmware"
HOMEPAGE="https://developers.google.com/android/images#cheetah"
SRC_URI="${MY_ARCHIVE}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~arm64"
RESTRICT="fetch bindist mirror"

BDEPEND="
	app-arch/7zip
	app-arch/unzip
"

pkg_nofetch() {
	einfo "Review Google's terms at ${HOMEPAGE}, then download CP4A.261105.040.A1:"
	einfo "https://dl.google.com/dl/android/aosp/${MY_ARCHIVE}"
	einfo "SHA256: b255f8dd30041fad74cb4985f26770b37643914f9fa5eea5a18b1f92e0b45e91"
	einfo "Place ${MY_ARCHIVE} in your Portage distfiles directory."
}

src_unpack() {
	unzip -p "${DISTDIR}/${MY_ARCHIVE}" "${MY_BUILD}/image-${MY_BUILD}.zip" \
		> "${T}/images.zip" || die "Could not extract the partition archive"
	unzip -p "${T}/images.zip" vendor.img > "${T}/vendor.img" || die
	rm "${T}/images.zip" || die

	# This build ships a raw ext4 vendor.img, not Android sparse or super.img.
	7zz e -tExt -o"${S}" "${T}/vendor.img" \
		firmware/{cs40l26.wmfw,cs40l26.bin,aoc.bin} \
		firmware/{cs35l41-dsp1-spk-prot.wmfw,cs35l41-dsp1-spk-prot.bin,R-cs35l41-dsp1-spk-prot.bin} \
		firmware/fast_switch{3,4}.txt \
		firmware/brcm/BCM.hcd || die
	rm "${T}/vendor.img" || die
}

src_install() {
	insinto /lib/firmware
	doins cs40l26.wmfw cs40l26.bin aoc.bin

	insinto /lib/firmware/cirrus
	newins cs35l41-dsp1-spk-prot.wmfw cs35l41-dsp1-spk-prot-cheetah.wmfw
	newins cs35l41-dsp1-spk-prot.bin cs35l41-dsp1-spk-prot-cheetah-top.bin
	newins R-cs35l41-dsp1-spk-prot.bin cs35l41-dsp1-spk-prot-cheetah-bottom.bin
	# Stock's media "Bypass FIR" deltas, under the names omamobile-audio's
	# speaker watchdog reads (omarchy-mobile tools/extract-vendor-firmware).
	newins fast_switch3.txt cs35l41-cheetah-top-media-delta.txt
	newins fast_switch4.txt cs35l41-cheetah-bottom-media-delta.txt

	# BCM4389C1 Bluetooth patch RAM. btbcm tries the board name first
	# (omarchy-mobile device/cheetah/BLUETOOTH-PLAN.md:138).
	insinto /lib/firmware/brcm
	newins BCM.hcd BCM.google,gs201-cheetah.hcd
}
