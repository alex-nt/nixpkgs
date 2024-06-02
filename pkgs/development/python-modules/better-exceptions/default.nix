{
  lib,
  buildPythonPackage,
  fetchPypi,
}:

buildPythonPackage rec {
  pname = "better-exceptions";
  version = "0.3.3";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-0000000000000000000000000000000000000000000=";
  };

  buildInputs = [];

  meta = with lib; {
    description = "Pretty and more helpful exceptions in Python, automatically.";
    homepage = "https://github.com/qix-/better-exceptions";
    license = licenses.mit;
  };
}