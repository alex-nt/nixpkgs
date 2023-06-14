{ lib, stdenv, fetchurl, jdk, makeWrapper }:

assert jdk != null;

stdenv.mkDerivation rec {
  pname = "apache-maven";
  version = "3.9.2";

  builder = ./builder.sh;

  src = fetchurl {
    url = "mirror://apache/maven/maven-3/${version}/binaries/${pname}-${version}-bin.tar.gz";
    sha512 = "sha512-900bdeeeae550d2d2b3920fe0e00e41b0069f32c019d566465015bdd1b3866395cbe016e22d95d25d51d3a5e614af2c83ec9b282d73309f644859bbad08b63db";
  };

  nativeBuildInputs = [ makeWrapper ];

  inherit jdk;

  meta = with lib; {
    mainProgram = "mvn";
    description = "Build automation tool (used primarily for Java projects)";
    homepage = "https://maven.apache.org/";
    license = licenses.asl20;
    platforms = platforms.unix;
    maintainers = with maintainers; [ cko ];
  };
}
