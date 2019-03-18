# app

A Flutter application project for TechCon.

### Flutter Launcher Icons

1. Setup the config file (flutter_launcher_icons.yaml)
```
dev_dependencies:
  flutter_launcher_icons: "^0.7.0"

flutter_icons:
  android: true
  ios: true
  image_path_ios: "assets/images/app_icon_ios.png"
  image_path_android: "assets/images/app_icon_android.png"
  adaptive_icon_background: "#ffffff"
  adaptive_icon_foreground: "assets/images/ic_launcher.png"
```

2. Update launcher base icon files
```
  assets/images/App_Icon.png
  assets/images/ic_launcher.png
```

3. Run the package on command line
```
flutter packages get
flutter packages pub run flutter_launcher_icons:main
```
