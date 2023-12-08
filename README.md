# CS Messenger App

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
- [Git-chglog](https://github.com/git-chglog/git-chglog)
- [Firebase](https://console.firebase.google.com/u/0/project/flutterskeleton-c0812/overview)
- [Setup Flavor](hhttps://medium.com/@animeshjain/build-flavors-in-flutter-android-and-ios-with-different-firebase-projects-per-flavor-27c5c5dac10b)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### Note

    Ios doesn't register bundle_id on Apple Developer so FirebaseApp config not complete.

### Android

    - Target Version: SDK 33
    - Min Version: SDK 23

### IOS

    - Target Version: ...
    - Min Version: ...

### Env Config

    - Dev
    - Prod

### Clean Architecture Pattern

    - App Module
    - Data Module
    - Domain Module

### Dependency Injection

    - GetIt + Injectable

#### UI Layer

    - BloC
    - Localization: vi, en
    - Theme: Light, Dark
    - Material Design 3

#### Components

    - UIKit (App/Components/Main)

#### Data Layer

    - Network - Dio: Authentication, RefreshToken, Error Exception
    - Database: Hive
    - Local storage: EncryptedSharePreference

#### Packages

- [Flutter BloC](https://pub.dev/packages/flutter_bloc)

## Guideline Run project

### MacOs

- One time: `make denied` (Mac OS)
-

PreBuild: `make pre-bootstrap`, `make pub-get`, `make build-init flavor=dev`, `make build-init flavor=prod`, `make build-runner`

- Get Command for run: `make run flavor=dev/staging/prod` -> After running
  finished, copy command
- Run Project: `cd app`, paste copied command to run with `fvm` in front.
  E.g: `fvm <copied-command>`

### Windows

- Install Flutter 3.13.9 or latest version
- Install **Melos** latest version (Optional)
- Install **fvm** latest version (Optional)

_If you can not install Melos, Fvm on Windows. You need to follow step by step
to ready run source code_

- **scripts package**
    - cd scripts
    - sh pre-bootstrap.sh
- flutter pub get
- **utilities package**:
    - cd utilities
    - flutter pub get
- **resources package**:
    - cd resources
    - flutter pub get
    - flutter packages pub run build_runner build --delete-conflicting-outputs
    - flutter pub run flutter_launcher_icons
    - flutter pub run flutter_native_splash:create --flavor dev
    - flutter pub run flutter_native_splash:create --flavor staging
    - flutter pub run flutter_native_splash:create --flavor prod
    - flutter pub run intl_utils:generate
- **domain package**
    - cd domain
    - flutter pub get
    - flutter packages pub run build_runner build --delete-conflicting-outputs
- **data package**
    - cd data
    - flutter pub get
    - flutter packages pub run build_runner build --delete-conflicting-outputs
- **config package**
    - cd configs
    - flutter pub get
- **app package**
    - cd app
    - flutter pub get
- Run source
    - cd configs
    - dart run lib/src/env.json.dart [dev|staging|prod]
    - cd ..
    - dart run scripts/build.dart [dev|staging|prod] -> Run complete and copy
      command on console
    - cd app
    - parse command and run
