# Changelog

This project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 0.7.1 - Feb 13, 2024

- Fix missing dispose on `AsyncButtonBuilder`.

## 0.7.0 - Feb 10, 2024

- Added `AsyncButtonBuilder`. Create your own async button by just wrapping your widget with `AsyncButtonBuilder`. This is now also the base for all async buttons.

- Added async `FloatingActionButton` and all its possible variations:
  - `AsyncFloatingActionButton`;
  - `AsyncFloatingActionButton.small`;
  - `AsyncFloatingActionButton.large`;
  - `AsyncFloatingActionButton.extended`.
  - Or simply the variant with `.asAsync` extension.

- Updated all possible async variations for all `ButtonStyleButton`:
  - `AsyncElevatedButton` and `AsyncElevatedButton.icon`;
  - `AsyncOutlinedButton` and `AsyncOutlinedButton.icon`;
  - `AsyncTextButton` and `AsyncTextButton.icon`;
  - `AsyncFilledButton` and `AsyncFilledButton.icon`;
  - `AsyncFilledButton.tonal` and `AsyncFilledButton.tonalIcon`.
  - Or simply the variant with `.asAsync` extension.

- Updated `AsyncIndicator` to automatically calculate the size based on the parent widget, following the Material Design guidelines.
  - Added `AsyncIndicator.sizeRatio` to manually adjust the ratio.
  - `AsyncIndicator.minDimension` and `AsyncIndicator.maxDimension` to set the bounds.

- Added `AsyncButtonConfig.successBuilder`. An optional builder to customize the success state (for buttons).

- Added `AsyncThemer`, so you can easily theme all async buttons states.
  - `AsyncButtonConfig.errorThemer`;
  - `AsyncButtonConfig.loadingThemer`;
  - `AsyncButtonConfig.successThemer`;

- Added `AsyncButtonConfig.icon` shorthand constructor to set icon widgets or seeded colors when the builders aren't needed.

- Added shortcuts to all `.asAsync` extensions.

Some breaking changes were made to improve the library and make it simpler, more consistent and predictable.

- Removed Async.at and AsyncButton.maybeAt static methods.
- Removed Async.wrapper and AsyncBuilder.wrapper parameters.
- `Async.errorBuilder` now will try to extract `Exception.message` by default only on `Exception` instances.
- `Async.errorBuilder` will collapse to '!' and the error will appear as a tooltip when there is no space.

## 0.6.5 - Feb 06, 2024

- Added Future extensions: `orFalse`, `orNull` and `thenOrNull`.
- Bump `async_notifier` to 0.3.1.

## 0.6.3 - Jan 09, 2023

- Fix _InputPadding sizing conflicts with AsyncButton.

## 0.6.2 - Nov 07, 2023

- Changes default clipBehavior to hardEdge to AsyncButton as it's neeed to avoid out of bounds animations.
- Updated README
- Updated example

## 0.6.1 - Nov 03, 2023

- Adds `AsyncIndicator`, an smart `CircularProgressIndicator` that automatically chooses betweens primary, onPrimary and fallback theme colors based on the color below it. Additionally never distorts when sized, can be overlayed on other widgets and linear interpolates stroke width when scaled down.
- Updates default loadingBuilder and reloadingBuilder to use `AsyncIndicator`.

## 0.6.0 - Oct 10, 2023

- Adds `AsyncNotifier` as new core:

  [async_notifier](https://pub.dev/packages/async_notifier) is now a standalone package. Note: This library is not exported by `flutter_async`.

- **BREAKING CHANGE**
The library was restructured to envision better maintenability and focus on displaying async states only.
  - Changes `AsyncConfig` inheritance.
  - Changes all builders to the `stateBuilder` name convention.
  - Chnages `.async()` extensions. Use `.asAsync()` instead.
  - Removes `AsyncObserver`. To be reused by `async_notifier`. Wip.
  - Removes lifecycle utilities for leaner widgets.
  - Removes `AsyncController`. Use the specific `AsyncState` through `GlobalKey` or context.
  - Adds `AsyncWidget.at` static callback. Same signature as `.of` but visits the state at the current context, removing the need for controllers and global keys. The `.at` additionally can receive `T extends StatefulWidget` and `key` to easily identify async widgets at the current context.

- Updates in code were made to better follow Effective Dart style and also improve developer experience:
  - Adds `all_lint_rules.yaml`.
  - Updates `analysis_options` for stricter lints.
  - Updates CHANGELOG style.

## 0.5.2 - Sep 27, 2023

- **BREAKING CHANGE**
  - `AsyncBuilder` base constructor for simple future/stream objects.
  - `AsyncBuilder.function` for managed getFuture/getStream objects.
- Adds `init` and `dispose` callbacks to `AsyncBuilder`.

## 0.4.2 - Sep 19, 2023

- Adds late final initialization on `AsyncButtonState`.

## 0.4.1 - Sep 7, 2023

- Adds AsyncObserver for analytics with all possible states within all `AsyncWidget` actions in this package.
  - AsyncObserver.onActionInit
  - AsyncObserver.onActionStart
  - AsyncObserver.onActionInsist
  - AsyncObserver.onActionSuccess
  - AsyncObserver.onActionError

- Adds `AsyncConfig.buttonLoader` that applies to all `AsyncButton` if `AsyncButtonConfig` is not set.
- Adds `AsyncConfig.buttonError` that applies to all `AsyncButton` if `AsyncButtonConfig` is not set.

## 0.3.1 - Aug 17, 2023

- Fixes duplicate keys on AsyncButton super.key.

## 0.3.0 - Aug 16, 2023

- **BREAKING CHANGE**: `AsyncButtonConfig` will no longer be set with static methods. Use `AsyncConfig` instead, through `Async` widget inheritance.
- **BREAKING CHANGE**: WidgetBuilder is used on all state builders widgets for consistency.
- Adds AsyncConfig.of(context);
- Adds AsyncConfig.maybeOf(context);

## 0.2.0 - Aug 15, 2023

- **BREAKING CHANGE**: AsyncBuilder now has one single constructor.
- AsyncBuilder.future is now deprecated. Renamed to -> AsyncBuilder.getFuture.
- AsyncBuilder.stream is now deprecated. Renamed to -> AsyncBuilder.getStream.
- Adds `Async` widget for void async tasks, utilities and inheritance (you can provide custom loader and error).

## 0.1.0 - Jul 10, 2023

- Updates minimum support to Dart SDK 2.17 <4.0 (flutter 3.0)

## 0.0.1 - Jul 9, 2023

- Initial pre-release.
