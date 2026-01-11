# 4.1.0

- Feat: Added `isNullOrEmpty` getter to String extensions.

# 4.0.1

- Minor: `Map.tryGetDateTime` now is optimized to not try to convert empty strings into DateTime objects.

# 4.0.0

- BREAKING: `DateTime.fromEuropean` is now called "fromDDMMYYYY".
- Fixed linting problem when importing `TimeUnit`.

# 3.1.0

- Feat: Added `isToday` getter to DateTime extensions to check if a DateTime represents the current date.

# 3.0.1

- Fix: `String.toSimple` now correctly normalizes and removes accent marks from characters such as "â" and "î".

## 3.0.0

- BREAKING: `Iterable.sum` is now a getter instead of a method.
- Feat: `Iterable.avg` getter.

## 2.9.0

- Feat: `Iterable.pickNRandom`.
- Feat: `Iterable.pickRandom` now has "exclude" and "excludeItems" options.

## 2.8.1

- Fix: `Duration.toReadable` now has adjancy check for time units. Meaning strings like "2d 26s" won't be generated anymore.

## 2.8.0

- Feat: `Duration.toReadable` now has "maxUnits" and "unitNames".

## 2.7.1

- Fix: `String.toSimple` now replaced "e" variations.

## 2.7.0

- Added `count` to Iterable extensions.

## 2.6.1

- Fixed `addMonths`.

## 2.6.0

- Added `addMonths` to DateTime extensions.
- Added `sum` to Iterable of num.

## 2.5.0

- Added `count` in String extensions.

## 2.4.0

- Added `fromEuropean` in DateTime extensions.

## 2.3.0

- Added `sortByNumericString` in List extensions.

## 2.2.0

- Added `sortByDate`, `sortByNum` and `sortByString` in List extensions.

## 2.1.0

- Added `toSimple` in String extensions.

## 2.0.0

- BREAKING: `getMaybeDateTime` was renamed to `tryGetDateTime` in Map extensions.
- Added `getDouble` and `tryGetDouble` in Map extensions.
- Added `getList` in Map extensions.

## 1.8.1

- Removed non-existent method on README.

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
