{
  lib,
  stdenv,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  makeWrapper,
  xcodeWrapper
}:

buildPythonPackage rec {
  pname = "pyobjc-framework-Cocoa";
  version = "10.3";
  format = "pyproject";

  src = fetchPypi {
    pname = "pyobjc_framework_cocoa";
    inherit version;
    hash = "sha256-05+Q/+BBQ5EQYMOS5iuVFPFMqroRllfW4rixl69J4Rc=";
  };

  propagatedBuildInputs = [
    setuptools
  ];

  nativeBuildInputs = [ makeWrapper ]
    ++ lib.optionals stdenv.isDarwin [ xcodeWrapper ];

  meta = with lib; {
    description = "Wrappers for framework 'Cocoa', that is frameworks 'CoreFoundation','Foundation' and 'AppKit'.";
    homepage = "https://github.com/ronaldoussoren/pyobjc/tree/master/pyobjc-framework-Cocoa";
    license = licenses.mit;
    platforms = [ "aarch64-darwin" ];
  };
}