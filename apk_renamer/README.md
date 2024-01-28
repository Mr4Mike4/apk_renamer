# ApkRenamer

The application for renaming apk files according to a template.

Template example:

```text
${apk.applicationLabel}-${apk.versionName}
```

![ApkRenamer light screenshot](img/apk_renamer_light.jpg)

![ApkRenamer dark screenshot](img/apk_renamer_dark.jpg)

## Portable mode

To enable the portable mode in the application, you need to create an empty file named `portable`.

## Build instructions

- Install the [Flutter SDK](https://docs.flutter.dev/get-started/install)

- [Run code generation for renamer_lib.](../renamer_lib/README.md)
- Run code generation:

```bash
flutter pub get
```

```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

- Run the code generation of text resources:

```bash
flutter gen-l10n
```

- Start the application build:

```bash
# for windows
flutter build windows --release
```

```bash
# for macos
flutter build macos --release
```

```bash
# for linux
flutter build linux --release
```
