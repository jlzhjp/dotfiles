{ ... }:

{
  services.flatpak.enable = true;

  services.flatpak.update.onActivation = true;
  services.flatpak.uninstallUnmanaged = true;

  services.flatpak.packages = [
    "com.github.tchx84.Flatseal"
    "com.github.xournalpp.xournalpp"
    "com.obsproject.Studio"
    "com.qq.QQ"
    "com.tencent.WeChat"
    "io.github.kolunmi.Bazaar"
    "org.qbittorrent.qBittorrent"
    "org.telegram.desktop"
  ];
}
