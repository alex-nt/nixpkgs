{ lib, stdenvNoCC, fetchFromGitHub }:

stdenvNoCC.mkDerivation {
  pname = "raspberrypi-wireless-firmware";
  version = "2023-05-04";

  srcs = [
    (fetchFromGitHub {
      name = "bluez-firmware";
      owner = "RPi-Distro";
      repo = "bluez-firmware";
      rev = "9556b08ace2a1735127894642cc8ea6529c04c90";
      hash = "sha512-M8P17gj2OasUCH0U6jDFHraw/6k80WzCJQIIOH9IzORBSOrY8RNXE1Z6czg/MZ81iIVpS1TFpI06y/Qo+Y4DVw==";
    })
    (fetchFromGitHub {
      name = "firmware-nonfree";
      owner = "RPi-Distro";
      repo = "firmware-nonfree";
      rev = "2b465a10b04555b7f45b3acb85959c594922a3ce";
      hash = "sha512-WeAwu1egWC0BNeqFnZl8h7WSsUi8y6ZsdEKs/dIk/d4w7q7rA9ZXcmMUF1ngabRsYrYEZUsUyr1lCgtEFQmtww==";
    })
  ];

  sourceRoot = ".";

  dontBuild = true;
  # Firmware blobs do not need fixing and should not be modified
  dontFixup = true;

  installPhase = ''
    runHook preInstall
    mkdir -p "$out/lib/firmware/brcm"

    # Wifi firmware
    cp -rv "$NIX_BUILD_TOP/firmware-nonfree/debian/config/brcm80211/." "$out/lib/firmware/"

    # Bluetooth firmware
    cp -rv "$NIX_BUILD_TOP/bluez-firmware/broadcom/." "$out/lib/firmware/brcm"

    runHook postInstall
  '';

  meta = with lib; {
    description = "Firmware for builtin Wifi/Bluetooth devices in the Raspberry Pi 3+ and Zero W";
    homepage = "https://github.com/RPi-Distro/firmware-nonfree";
    license = licenses.unfreeRedistributableFirmware;
    platforms = platforms.linux;
    maintainers = with maintainers; [ lopsided98 ];
  };
}
