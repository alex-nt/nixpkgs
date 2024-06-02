{
  lib,
  buildPythonPackage,
  fetchPypi,
}:

buildPythonPackage rec {
  pname = "pyobjc-framework-Cocoa";
  version = "10.3";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "";
  };

  buildInputs = [];

  meta = with lib; {
    description = "Wrappers for framework 'Cocoa', that is frameworks 'CoreFoundation','Foundation' and 'AppKit'.";
    homepage = "https://github.com/ronaldoussoren/pyobjc/tree/master/pyobjc-framework-Cocoa";
    license = licenses.mit;
    platforms = [ "aarch64-darwin" ];
  };
}