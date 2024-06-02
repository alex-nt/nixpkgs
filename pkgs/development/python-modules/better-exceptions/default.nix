{
  lib,
  buildPythonPackage,
  fetchPypi
}:

buildPythonPackage rec {
  pname = "better-exceptions";
  version = "0.3.3";
  format = "setuptools";

  src = fetchPypi {
    pname = "better_exceptions";
    inherit version;
    hash = "";
  };

  meta = with lib; {
    description = "Pretty and more helpful exceptions in Python, automatically.";
    homepage = "https://github.com/qix-/better-exceptions";
    license = licenses.mit;
  };
}