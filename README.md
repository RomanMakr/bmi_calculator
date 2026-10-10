# BMI Calculator

A Flutter app for calculating Body Mass Index (BMI) from height and weight. It
shows the BMI value, category, and a short description, and supports weight
entry in kilograms or pounds.

## Features

- Select Male or Female for the screen accent color.
- Set height from 100 cm to 220 cm using the slider.
- Enter weight in kilograms or pounds.
- Enter age as a whole number from 1 to 120.
- View a BMI result and category.
- Recalculate to clear the previous weight and age and reset height to 100 cm.

BMI is calculated as:

```text
BMI = weight in kilograms / (height in meters * height in meters)
```

Age and gender are collected by the form but do not affect the BMI formula.

## Requirements

- Flutter SDK compatible with the constraint in `pubspec.yaml` (Dart `^3.9.2`)
- A configured Flutter target device or emulator
- GNU Make, if using the shortcuts in the Makefile

## Getting started

Fetch dependencies and start the app:

```sh
flutter pub get
flutter run
```

Or use the Makefile:

```sh
make get
make run
```

To select a device or target explicitly, use Flutter directly:

```sh
flutter run -d <device-id>
```

List available device IDs with `flutter devices`.

## Development commands

| Command | Description |
| --- | --- |
| `make get` | Fetch package dependencies |
| `make run` | Run the app on Flutter's selected device |
| `make test` | Run the test suite |
| `make analyze` | Analyze the project |
| `make format` | Format Dart files |
| `make clean` | Remove Flutter build output and generated package state |

The equivalent Flutter commands are `flutter pub get`, `flutter run`,
`flutter test`, `flutter analyze`, `dart format .`, and `flutter clean`.

## Architecture

The app follows a feature-first Clean Architecture structure. BMI-specific
code lives under `lib/features/bmi`, while reusable app infrastructure is in
`lib/core`.

### Layers

- **Domain** (`features/bmi/domain`) contains the `BmiResult` entity and
  `CalculateBmi` use case. It owns the BMI formula, input checks, and category
  descriptions, and does not depend on Flutter UI code.
- **Presentation** (`features/bmi/presentation`) contains the screens, widgets,
  `BmiCubit`, and `BmiState`. Widgets send user input to the Cubit; the Cubit
  validates form values, invokes the domain use case, and exposes state for the
  UI to render.
- **Core** (`core`) contains shared app concerns: GetIt dependency registration
  in `di` and colors/theme definitions in `theme`.

### Data and control flow

This app currently has no remote service or local database, so it does not need
a separate data/repository layer. The presentation Cubit depends on the domain
use case, and `core/di` registers the use case with GetIt. `main.dart` sets up
dependencies and provides the Cubit to the calculator screen.

For a calculation, the form sends height and weight to `BmiCubit`. The Cubit
calls `CalculateBmi`, receives a `BmiResult`, and emits it as state. The
calculator screen listens for that result and navigates to the result screen.
Recalculate resets the Cubit state and returns to the form.

### Architecture structure

```text
lib/
  core/
    di/       Dependency registration
    theme/    App colors and theme
  features/
    bmi/
      domain/
        entities/   BMI result
        usecases/   BMI calculation and category selection
      presentation/
        cubit/      Form state and calculation coordination
        screens/    Calculator and result screens
        widgets/    Input controls and reusable UI
test/               Domain and widget tests
```

## Tests

Run all tests with:

```sh
flutter test
```

Tests cover BMI category calculations and the calculator form, including input
validation, unit selection, result navigation, and resetting the form.
