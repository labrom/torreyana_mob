import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tourbillauth/auth.dart';

part 'settings.g.dart';

/// Stores and observes preferences for the current user.
///
/// Applications can implement this interface to use storage other than the
/// default Firestore-backed implementation.
abstract interface class UserPreferencesHandler {
  /// Emits the complete set of preferences whenever it changes.
  Stream<Map<String, dynamic>> watchPreferences();

  /// Records a single preference.
  Future<void> writePreference(String field, dynamic value);
}

/// Stores user preferences in a Firestore document.
class FirestoreUserPreferencesHandler implements UserPreferencesHandler {
  FirestoreUserPreferencesHandler({
    required String userId,
    FirebaseFirestore? firestore,
  }) : _document = (firestore ?? FirebaseFirestore.instance)
           .collection('user-settings')
           .doc(userId);

  final DocumentReference<Map<String, dynamic>> _document;

  @override
  Stream<Map<String, dynamic>> watchPreferences() =>
      _document.snapshots().map((snapshot) => snapshot.data() ?? {});

  @override
  Future<void> writePreference(String field, dynamic value) =>
      _document.set({field: value}, SetOptions(merge: true));
}

/// The user preference storage configured for this application.
@riverpod
UserPreferencesHandler userPreferencesHandler(Ref ref) =>
    FirestoreUserPreferencesHandler(
      // TODO Replace 'anon' with anonymous Firebase sign-in.
      userId: ref.watch(firebaseAuthProvider).currentUser?.uid ?? 'anon',
    );

/// Provides reactive access to the current user's preferences.
@riverpod
class UserPreferencesRepository extends _$UserPreferencesRepository {
  @override
  Stream<Map<String, dynamic>> build() =>
      ref.watch(userPreferencesHandlerProvider).watchPreferences();

  Future<void> write(String field, dynamic value) =>
      ref.read(userPreferencesHandlerProvider).writePreference(field, value);
}

/// Use [UserPreferencesRepository] instead.
@Deprecated('Use UserPreferencesRepository instead.')
typedef FirestoreUserSettingsRepository = UserPreferencesRepository;

/// Use [userPreferencesRepositoryProvider] instead.
@Deprecated('Use userPreferencesRepositoryProvider instead.')
final firestoreUserSettingsRepositoryProvider =
    userPreferencesRepositoryProvider;
