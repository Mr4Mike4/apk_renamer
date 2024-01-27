# ApkRenamer for command-line

The application for renaming apk files according to a template (command-line edition).

Example:

```bash
apk_renamer_cli.exe --template="${apk.applicationLabel}-${apk.versionName}" --file="%project%\app\build\outputs\apk\prod\release\app.apk" --out="g:\apks"
```

![ApkRenamer cli screenshot](../img/apk_renamer_cli.jpg)

## Build instructions

- Install the [Flutter SDK](https://docs.flutter.dev/get-started/install)

- Run code generation:

```bash
flutter pub get
```

```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

- Start the application build:

```bash
# for windows
dart compile exe --target-os=windows bin/apk_renamer_cli.dart --output bin/apk_renamer_cli.exe
```

```bash
# for macos
dart compile exe --target-os=macos bin/apk_renamer_cli.dart --output bin/apk_renamer_cli
```

```bash
# for linux
dart compile exe --target-os=linux bin/apk_renamer_cli.dart --output bin/apk_renamer_cli
```
