{ lib, stdenv, fetchurl, jdk, makeWrapper }:

assert jdk != null;

stdenv.mkDerivation rec {
  pname = "apache-maven";
  version = "3.9.2";

  builder = ./builder.sh;

  src = fetchurl {
    url = "mirror://apache/maven/maven-3/${version}/binaries/${pname}-${version}-bin.tar.gz";
    sha512 = "sha512-25lvjmxfrpb3w5mph85q44940d0qi5hgpra4rhim1lj1wmy2d3hb3dvygmlzrrki407vbgknajqacyyndnkrkkd2cc2igrbvn8sspdi";
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
