# gentoo-pixel overlay

Gentoo ebuilds for running Gentoo with KDE Plasma Mobile on the Google Pixel 7 Pro (cheetah, arm64).
Build, flash and rootfs scripts live in [gentoo-pixel7pro](https://github.com/Zakk-Lab/gentoo-pixel7pro).

## Packages

| Package | Purpose |
|---|---|
| `kde-plasma/plasma-mobile`, `kde-apps/plasma-settings` | Plasma Mobile shell and settings |
| `dev-libs/feedbackd` | haptic and sound feedback; GURU's 0.8.9 with two build fixes (`-r1` so it wins over GURU's copy) |
| `app-i18n/fcitx5-osk` | touch keyboard for Fcitx 5 ([fortime/fcitx5-osk](https://github.com/fortime/fcitx5-osk)) |
| `sys-firmware/cheetah-vendor-firmware` | haptics, AoC audio, speaker protection and Bluetooth firmware, unpacked from your own copy of Google's factory image |

`sys-firmware/cheetah-vendor-firmware` is fetch-restricted and contains no firmware.
Download `cheetah-cp4a.261105.040.a1` from <https://developers.google.com/android/images#cheetah>, accept Google's terms, and put it in your distfiles directory; `pkg_nofetch` prints the exact file name and checksum.

## Use

feedbackd's dependencies (`dev-libs/gmobile`, `dev-libs/feedbackd-device-themes`, `sec-keys/openpgp-keys-phosh`) come from [GURU](https://wiki.gentoo.org/wiki/Project:GURU):

```sh
eselect repository enable guru
eselect repository add gentoo-pixel git https://github.com/Zakk-Lab/gentoo-pixel-overlay.git
emaint sync -r guru
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
