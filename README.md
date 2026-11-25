# gentoo-pixel overlay

Gentoo ebuilds for running Gentoo with KDE Plasma Mobile on the Google Pixel 7 Pro (cheetah, arm64).
Build, flash and rootfs scripts live in [gentoo-pixel7pro](https://github.com/Zakk-Lab/gentoo-pixel7pro).

## Packages

| Package | Purpose |
|---|---|
| `kde-plasma/plasma-mobile`, `kde-apps/plasma-settings` | Plasma Mobile shell and settings |
| `dev-libs/feedbackd`, `dev-libs/feedbackd-device-themes`, `dev-libs/gmobile`, `sec-keys/openpgp-keys-phosh` | haptic and sound feedback |
| `app-i18n/fcitx5-osk` | touch keyboard for Fcitx 5 ([fortime/fcitx5-osk](https://github.com/fortime/fcitx5-osk)) |
| `sys-firmware/cheetah-vendor-firmware` | haptics, AoC audio, speaker protection and Bluetooth firmware, unpacked from your own copy of Google's factory image |

`sys-firmware/cheetah-vendor-firmware` is fetch-restricted and contains no firmware.
Download `cheetah-cp4a.261105.040.a1` from <https://developers.google.com/android/images#cheetah>, accept Google's terms, and put it in your distfiles directory; `pkg_nofetch` prints the exact file name and checksum.

## Use

```sh
eselect repository add gentoo-pixel git https://github.com/Zakk-Lab/gentoo-pixel-overlay.git
emaint sync -r gentoo-pixel
```

`kde-plasma/plasma-mobile` needs `kde-plasma/plasma-nano` from ::gentoo, which is keyworded only `~amd64` there, so `~arm64` does not unmask it:

```
# /etc/portage/package.accept_keywords/plasma-mobile
=kde-plasma/plasma-nano-6.7.6 **
```

All packages are keyworded `~arm64` (some also `~amd64`).

## Credits

The device support builds on Derek Ross's [omarchy-mobile](https://github.com/derekross/omarchy-mobile) and [linux-omarchy-mobile](https://github.com/derekross/linux-omarchy-mobile).
