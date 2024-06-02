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
    hash = "sha256-e4e6bc18444d5f04e6e894b10381e5e921d3d544240418162c7db57e9eb3453b=";
  };

  buildInputs = [];

  meta = with lib; {
    description = "Pretty and more helpful exceptions in Python, automatically.";
    homepage = "https://github.com/qix-/better-exceptions";
    license = licenses.mit;
  };
}