{ lib
, stdenv
, buildPythonApplication
, fetchPypi
, copyDesktopItems
, gobject-introspection
, poetry-core
, wrapGAppsHook3
, gtksourceview4
, pango
, gaphas
, generic
, jedi
, pycairo
, pillow
, dulwich
, pydot
, defusedxml
, better-exceptions
, pyobjc-framework-cocoa
, babel
, pygobject3
, tinycss2
, gtk3
, librsvg
, makeDesktopItem
, python
}:

buildPythonApplication rec {
  pname = "gaphor";
  version = "2.25.1";

  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-9PNgU1/9RL6QXba0gn4zHCAtSV3iY0HOY1Rf6bkyzxY=";
  };

  nativeBuildInputs = [
    copyDesktopItems
    gobject-introspection
    poetry-core
    wrapGAppsHook3
  ];

  buildInputs = [
    gtksourceview4
    pango
  ];

  propagatedBuildInputs = [
    gaphas
    generic
    jedi
    pycairo
    pygobject3
    tinycss2
    pillow
    dulwich
    pydot
    defusedxml
    better-exceptions
    babel
  ] ++ lib.optionals stdenv.isDarwin [
    pyobjc-framework-cocoa
  ];

  desktopItems = makeDesktopItem {
    name = pname;
    exec = "gaphor";
    icon = "gaphor";
    comment = meta.description;
    desktopName = "Gaphor";
  };

  # Disable automatic wrapGAppsHook3 to prevent double wrapping
  dontWrapGApps = true;

  postInstall = ''
    install -Dm644 $out/${python.sitePackages}/gaphor/ui/icons/hicolor/scalable/apps/org.gaphor.Gaphor.svg $out/share/pixmaps/gaphor.svg
  '';

  preFixup = ''
    makeWrapperArgs+=(
      "''${gappsWrapperArgs[@]}" \
      --prefix XDG_DATA_DIRS : "${gtk3}/share/gsettings-schemas/${gtk3.name}/" \
      --set GDK_PIXBUF_MODULE_FILE "${librsvg.out}/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache"
    )
  '';

  meta = with lib; {
    description = "Simple modeling tool written in Python";
    maintainers = with maintainers; [ wolfangaukang ];
    homepage = "https://github.com/gaphor/gaphor";
    license = licenses.asl20;
    platforms = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];
  };
}
