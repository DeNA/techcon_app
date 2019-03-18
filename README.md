TechCon App
================

# Introduction

We will release the source code by modifying a part of DeNA TechCon App.

### screenshots
![screenshots](https://user-images.githubusercontent.com/291993/54334442-64e8ce80-4669-11e9-8572-663d8242396f.png)

# Technology and Architecture

- Flutter is Build beautiful native apps on iOS and Android from a single codebase
- Build UI with Material Design
- Use Firebase services
  - Messaging
  - Crashlytics
  - Analytics *Disabled by default as we have not implemented the consent process
- Use Google Map *Android only
- Programing with Redux framework and modularized

# Modules (File and Directory)

```
root
  ├── app --- Main application module
  ├── architecture --- Redux architecture layer module
  ├── commons --- Utils module
  ├── repository --- Repository definition (Interface and Entity) module
  ├── repository_local --- Static data repository module
  ├── repository_cache --- Cacheable remote repository module
  │
  ├── plugins --- The latest Flutter plugins directory. To use the latest version of Google Map Plugin not yet published to Dart Pub.
  │
  └── hosting --- Directory of Web hosting resouce and json schema settings to vscode
```

# Get started

1. Get this application from git
 
    `git clone https://github.com/DeNA/techcon_app.git`

2. Get plugins with git submodule

    `git submodule add https://github.com/flutter/plugins.git`

   *To use the latest version of Google Map Plugin not yet published to Dart Pub.

3. [Add Firebase to your Flutter app  \|  Firebase](https://firebase.google.com/docs/flutter/setup)

    - Step 1: Set up your environment
    - Step 2: Create a Firebase project
    - Step 3: Configure your app to use Firebase
    - Step 4: Add FlutterFire plugins

4. Set up [google\_maps\_flutter \| Flutter Package](https://pub.dartlang.org/packages/google_maps_flutter)

# CAUTION

**"app/assets/", "app/android/app/res/", "app/ios/Runner/Assets.xcassets/" and "screenshots" folders contains works that each owner provides under the respective license.**
