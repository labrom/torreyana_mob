import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:torreyana_mob/providers/settings.dart';
import 'package:torreyana_mob/providers/theme.dart';

void main() {
  test('theme mode defaults to the system while preferences load', () {
    final container = ProviderContainer(
      overrides: [
        userPreferencesRepositoryProvider.overrideWith(
          () => _LoadingUserPreferencesRepository(),
        ),
      ],
    );
    addTearDown(container.dispose);

    expect(container.read(appThemeModeProvider), ThemeMode.system);
  });
}

class _LoadingUserPreferencesRepository extends UserPreferencesRepository {
  @override
  Stream<Map<String, dynamic>> build() => const Stream.empty();
}
