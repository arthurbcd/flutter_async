# Changelog

This project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 0.15.0 - Oct 15, 2025

- Added `AsyncSnackBar.showSuccess`.
- Added `AsyncSnackBar.showError`.
- Changed `BuildContext.visit` to stop when `false`.
- Improve `Async.context` assert/log messages.
- Adds `debounceTime` and `throttleTime` extensions for future functions.
- Add `'package:flutter_async/async_notifier.dart'` export.
- Bump `async_notifier` to 0.6.0.

## 0.14.1 - Jul 24, 2025

- Changed `AsyncKey.value` to be optional.

## 0.14.0 - Jun 27, 2025

- Bump sdk to `>=3.7.0 <4.0.0`.
- Added `Async.buttonLogger` for logging button events.
- Added `AsyncButton.tag` for logging.
- Added `AsyncButtonIcon.onHover` and `AsyncButtonIcon.onLongPress`.
- Added `AsyncTextButton.isSemanticButton`.
- Added `AsyncIndicator` constraints, padding, strokeWidth and trackGap.
- Added `AsyncKey`, a `GlobalKey` to access the current `AsyncButton` or `AsyncBuilder` state.
- Added `Async.navigatorKey` for a predictable `Async.context`.
- Changed `AsyncButton.press/longPress` returns it's `Future`.
- Ensure `Future.showLoading` is called after build.
- Breaking: `AsyncBuilder` now requires a function, as it's the default/proposed behavior. For a single future/stream value, use `AsyncBuilder.value`.

## 0.13.0 - Mar 04, 2025

- Added [AsyncSnackBar] future extension & static customizations.
- Changed `Async.context` to consistently return root `NavigatorState.context`.
- Removed `async_notifier` export.
- Updated `README.md`.

## 0.12.1 - Feb 10, 2025

- Prevent multiple calls to any `AsyncButton` while loading.

## 0.12.0 - Jan 27, 2025

- Bump `async_notifier` to 0.5.0.
- Fix `AsyncButton` to correctly reset its state after success/error.

## 0.11.1 - Dec 02, 2024

- Added `async_notifier` export.

## 0.11.0 - Dec 02, 2024

- Bump `async_notifier` to 0.4.0.
- Added `AsyncBuilder.snapshot` property.
- Added `AsyncSnapshot.errorMessage` property.

## 0.10.2 - Oct 08, 2024

- Added `AsyncFutureExtension.showSnackBar`.
- Added `AsyncFutureExtension.showLoading`.

## 0.10.1 - Jul 23, 2024

- Added `Async.errorLogger`, by default logs any error on debug mode. Overridable.

## 0.10.0 - Jul 22, 2024

- Added `AsyncBuilder.paged` constructor.
- Added `scrollLoadingBuilder` to `AsyncConfig`.
- Updated example and README.
- Deprecated `AsyncThemer` in favor of `AsyncTheme`. All methods and parameters renamed accordingly.
- Removed `animated_value` dependency from `pubspec.yaml`.

## 0.9.2 - Jun 19, 2024

- Make internal extensions exportable.

## 0.9.1 - Jun 07, 2024

- Added `Async.translator`. This overrides the default error message of any `Async.errorBuilder`.

You can also call it manually with `Async.message` static function.

## 0.9.0 - Jun 01, 2024

- Added async `IconButton` and all its possible variations:
  - `AsyncIconButton`;
  - `AsyncIconButton.small`;
  - `AsyncIconButton.large`;
  - `AsyncIconButton.extended`.
  - Or simply the `IconButton` variant with `.asAsync` extension.

- Refactor and minor fixes.

## 0.8.1 - May 14, 2024

- Fix nullable `ButtonStyleButton.clipBehavior` behavior update in Flutter 3.22.

## 0.8.0 - Apr 30, 2024

- Bumped to Dart 3.0.0.
- Added `Exception.message` extension.
- Added `Async.message`, which extracts the message from an `Object` or `Exception`.
- Now `Async.errorBuilder` uses `Async.message` by default and handles `ParallelWaitError` messages gracefully.

## 0.7.1 - Feb 13, 2024

- Fix missing dispose on `AsyncButtonBuilder`.

## 0.7.0 - Feb 10, 2024

- Added `AsyncButtonBuilder`. Create your own async button by just wrapping your widget with `AsyncButtonBuilder`. This is now also the base for all async buttons.

- Added async `FloatingActionButton` and all its possible variations:
  - `AsyncFloatingActionButton`;
  - `AsyncFloatingActionButton.filled`;
  - `AsyncFloatingActionButton.filledTonal`;
  - `AsyncFloatingActionButton.outlined`.
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

- Added `AsyncThemeGetter`, so you can easily theme all async buttons states.
  - `AsyncButtonConfig.errorTheme`;
  - `AsyncButtonConfig.loadingTheme`;
  - `AsyncButtonConfig.successTheme`;

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
