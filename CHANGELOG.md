## 1.8.0

- Added `toTitleCase` on String extensions.
- `hasLengthBetween` now throws a RangeError when an invalid range is given.

## 1.7.2

- Fix `pickRandom` extension method of DateTime generating dates outside the desired range.

## 1.7.1

- Fix `pickRandom` method from DateTime extension limitation on 32 bit int.

## 1.7.0

- Added `pickRandom` on Iterable extensions.
- Added static method `pickRandom` to DateTime extensions.

## 1.6.1

- Fixed README summary.

## 1.6.0

- Added `removeIndices` on Iterable extensions.

## 1.5.1

- Added option in duration's `toReadable` to display millisecond as decimal in seconds unit.

## 1.5.0

- Added `toReadable` in Duration extensions.
- Moved `firstWhereOrNull` from List to Iterable extensions.

## 1.4.0

- Added `hasUpperCase`, `hasLowerCase`, `hasNumber`, `hasSymbol`, and `hasLengthBetween` to String extensions.

## 1.3.0

- **Breaking Change**: Removed BR related extension methods to separate package.
- Removed `intl` dependency.

## 1.2.0

- Added `getInitials` to String extensions.
- Added missing String extensions documentation to README.md

## 1.1.0

- Added `firstWhereOrNull` to List<T> extensions.

## 1.0.1

- Separated "dart:io" extensions to "vit_dart_extensions_io.dart" file.

## 1.0.0

- Initial version.
