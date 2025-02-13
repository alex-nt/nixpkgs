{
  lib,
  stdenv,
  fetchurl,
  meson,
  ninja,
  pkg-config,
  vala,
  gettext,
  itstool,
  desktop-file-utils,
  wrapGAppsHook3,
  glib,
  gtk3,
  libhandy,
  libsecret,
  libxml2,
  gtk-vnc,
  gtk-frdp,
  gnome,
}:

stdenv.mkDerivation rec {
  pname = "gnome-connections";
  version = "47.0";

  src = fetchurl {
    url = "mirror://gnome/sources/gnome-connections/${lib.versions.major version}/gnome-connections-${version}.tar.xz";
    hash = "sha256-lT4jQ8C9SRawLtE6Ce8Rhv6WmSSSct/tuKI9ibQ3Lm0=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    vala
    gettext
    itstool
    desktop-file-utils
    glib # glib-compile-resources
    wrapGAppsHook3
  ];

  buildInputs = [
    glib
    gtk-vnc
    gtk3
    libhandy
    libsecret
    libxml2
    gtk-frdp
  ];

  passthru = {
    updateScript = gnome.updateScript { packageName = "gnome-connections"; };
  };

  meta = with lib; {
    homepage = "https://gitlab.gnome.org/GNOME/connections";
    changelog = "https://gitlab.gnome.org/GNOME/connections/-/blob/${version}/NEWS?ref_type=tags";
    description = "Remote desktop client for the GNOME desktop environment";
    mainProgram = "gnome-connections";
    maintainers = teams.gnome.members;
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
  };
}
