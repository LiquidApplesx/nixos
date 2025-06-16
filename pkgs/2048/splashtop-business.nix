{
  stdenv,
  lib,
  fetchzip,
  dpkg,
  autoPatchelfHook,
  patchelf,
  ffmpeg_6-full,
  keyutils,
  libcap,
  libpulseaudio,
  libuuid,
  xdotool,
  zlib,
  libsForQt5,
}:
let
  ffmpeg' = ffmpeg_6-full;
in
stdenv.mkDerivation (finalAttrs: {
  pname = "splashtop-business";
  version = "3.6.4.1";
  src = fetchzip {
    url = "https://download.splashtop.com/linuxclient/splashtop-business_Ubuntu_v${finalAttrs.version}_amd64.tar.gz";
    hash = "sha256-q5lnryj1e55D87sZ3QisEGvYIUiAY+tpQMCqbAtIDAw=";
    stripRoot = false;
  };

  nativeBuildInputs = [
    autoPatchelfHook
    dpkg
    patchelf
    libsForQt5.wrapQtAppsHook
  ];

  dontConfigure = true;
  dontBuild = true;

  buildInputs = [
    keyutils
    libcap
    libpulseaudio
    libuuid
    libsForQt5.qtbase
    xdotool
    zlib
  ];

  installPhase = ''
    runHook preInstall
    dpkg -x splashtop-business_Ubuntu_amd64.deb .
    mkdir -p $out/{bin,libexec,share}
    mv opt/splashtop-business/splashtop-business opt/splashtop-business/script/* $out/libexec
    makeWrapper $out/libexec/splashtop-business $out/bin/splashtop-business \
      ''${qtWrapperArgs[@]}

    # Clever workaround for log directory issue
    ln -s /tmp $out/libexec/log

    mv usr/share $out/
    substituteInPlace $out/share/applications/splashtop-business.desktop \
      --replace-fail /usr/ $out/
    runHook postInstall
  '';

  runtimeDependencies = [ (lib.getLib ffmpeg') ];
  dontWrapQtApps = true;

  meta = with lib; {
    description = "Splashtop Business - Remote access tool";
    platforms = platforms.linux;
  };
})
