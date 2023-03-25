{ lib, stdenvNoCC, fetchFromGitHub }:

stdenvNoCC.mkDerivation rec {
  # NOTE: this should be updated with linux_rpi
  pname = "raspberrypi-firmware";
  version = "1.2023-03-25-6.2.8";

  src = fetchFromGitHub {
    owner = "raspberrypi";
    repo = "firmware";
    rev = "c4617e02da233ff70940223a06e568a193fc446d";
    hash = "sha256-r98sKGDeG8X90kz+IYV+VjkcQusWvSe3pOv+DaYJqCs=";
  };

  installPhase = ''
    mkdir -p $out/share/raspberrypi/
    mv boot "$out/share/raspberrypi/"
  '';

  dontConfigure = true;
  dontBuild = true;
  dontFixup = true;

  meta = with lib; {
    description = "Firmware for the Raspberry Pi board";
    homepage = "https://github.com/raspberrypi/firmware";
    license = licenses.unfreeRedistributableFirmware; # See https://github.com/raspberrypi/firmware/blob/master/boot/LICENCE.broadcom
    maintainers = with maintainers; [ dezgeg ];
    broken = stdenvNoCC.isDarwin; # Hash mismatch on source, mystery.
  };
}
