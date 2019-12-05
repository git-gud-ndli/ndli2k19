module.exports = {
  pwa: {
    name: "GITGUD",
    themeColor: "#FFFFFF",
    msTileColor: "#000000",
    appleMobileWebAppStatusBarStyle: "white",
    manifestPath: "manifest.json",
    manifestOptions: {
      name: "GITGUD",
      shotName: "GITGUD",
      icons: [
        {
          src: "./img/icons/apple-touch-icon-120x120.png",
          sizes: "120x120",
          type: "image/png"
        },
        {
          src: "./img/icons/apple-touch-icon-180x180.png",
          sizes: "180x180",
          type: "image/png"
        },
        {
          src: "./img/icons/android-chrome-192x192.png",
          sizes: "192x192",
          type: "image/png"
        },
        {
          src: "./img/icons/android-chrome-512x512.png",
          sizes: "512x512",
          type: "image/png"
        }
      ]
    },
    iconPaths: {
      appleTouchIcon: "img/icons/apple-touch-180x180.png"
    },
    workboxPluginMode: "InjectManifest",
    workboxOptions: {
      swSrc: "public/service-worker.js"
    }
  },
  transpileDependencies: ["vuetify"]
};
