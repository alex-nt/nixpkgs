{ lib, buildPackages, fetchurl, perl, buildLinux, nixosTests, modDirVersionArg ? null, ... } @ args:

with lib;

lib.overrideDerivation (buildLinux (args // rec {
  version = "6.0.10";

  # modDirVersion needs to be x.y.z, will automatically add .0 if needed
  modDirVersion = if (modDirVersionArg == null) then concatStringsSep "." (take 3 (splitVersion "${version}.0")) else modDirVersionArg;

  # branchVersion needs to be x.y
  extraMeta.branch = versions.majorMinor version;

  src = fetchurl {
    url = "mirror://kernel/linux/kernel/v6.x/linux-${version}.tar.xz";
    sha256 = "1l0xak4w7c16cg8lhracy8r18zzdl0x5s654w6ivyw6dhk6pzr9r";
  };
} // (args.argsOverride or { })))
  (oldAttrs: {
    postConfigure = ''
      # The v7 defconfig has this set to '-v7' which screws up our modDirVersion.
      sed -i $buildRoot/.config -e 's/^CONFIG_LOCALVERSION=.*/CONFIG_LOCALVERSION=""/'
      sed -i $buildRoot/include/config/auto.conf -e 's/^CONFIG_LOCALVERSION=.*/CONFIG_LOCALVERSION=""/'
    '';

    # Make copies of the DTBs named after the upstream names so that U-Boot finds them.
    # This is ugly as heck, but I don't know a better solution so far.
    postFixup = ''
      dtbDir=${if stdenv.isAarch64 then "$out/dtbs/broadcom" else "$out/dtbs"}
      rm $dtbDir/bcm283*.dtb
      copyDTB() {
        cp -v "$dtbDir/$1" "$dtbDir/$2"
      }
    '' + lib.optionalString (lib.elem stdenv.hostPlatform.system [ "armv6l-linux" ]) ''
      copyDTB bcm2708-rpi-zero-w.dtb bcm2835-rpi-zero.dtb
      copyDTB bcm2708-rpi-zero-w.dtb bcm2835-rpi-zero-w.dtb
      copyDTB bcm2708-rpi-b.dtb bcm2835-rpi-a.dtb
      copyDTB bcm2708-rpi-b.dtb bcm2835-rpi-b.dtb
      copyDTB bcm2708-rpi-b.dtb bcm2835-rpi-b-rev2.dtb
      copyDTB bcm2708-rpi-b-plus.dtb bcm2835-rpi-a-plus.dtb
      copyDTB bcm2708-rpi-b-plus.dtb bcm2835-rpi-b-plus.dtb
      copyDTB bcm2708-rpi-b-plus.dtb bcm2835-rpi-zero.dtb
      copyDTB bcm2708-rpi-cm.dtb bcm2835-rpi-cm.dtb
    '' + lib.optionalString (lib.elem stdenv.hostPlatform.system [ "armv7l-linux" ]) ''
      copyDTB bcm2709-rpi-2-b.dtb bcm2836-rpi-2-b.dtb
    '' + lib.optionalString (lib.elem stdenv.hostPlatform.system [ "armv7l-linux" "aarch64-linux" ]) ''
      copyDTB bcm2710-rpi-zero-2-w.dtb bcm2837-rpi-zero-2-w.dtb
      copyDTB bcm2710-rpi-3-b.dtb bcm2837-rpi-3-b.dtb
      copyDTB bcm2710-rpi-3-b-plus.dtb bcm2837-rpi-3-a-plus.dtb
      copyDTB bcm2710-rpi-3-b-plus.dtb bcm2837-rpi-3-b-plus.dtb
      copyDTB bcm2710-rpi-cm3.dtb bcm2837-rpi-cm3.dtb
      copyDTB bcm2711-rpi-4-b.dtb bcm2838-rpi-4-b.dtb
    '';
  })

