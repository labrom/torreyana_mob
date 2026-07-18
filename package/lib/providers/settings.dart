import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' show User;
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

/// Creates preference storage scoped to an authenticated user.
typedef UserPreferencesHandlerFactory =
    UserPreferencesHandler Function(User user);

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

/// Creates the preference storage for the current authenticated user.
@riverpod
UserPreferencesHandlerFactory userPreferencesHandlerFactory(Ref ref) =>
    (user) => FirestoreUserPreferencesHandler(userId: user.uid);

/// The preference storage for the current authenticated user.
///
/// Watching the authentication stream makes the handler, its subscriptions,
/// and any handler-local caches change ownership when the user changes.
@riverpod
Future<UserPreferencesHandler> userPreferencesHandler(Ref ref) async {
  final authState = ref.watch(authStateChangesProvider);
  final user = await authState.when(
    data: Future.value,
    error: Future.error,
    loading: () => ref.watch(authStateChangesProvider.future),
  );
  if (user == null) {
    throw StateError('User preferences require an authenticated user');
  }
  return ref.watch(userPreferencesHandlerFactoryProvider)(user);
}

/// Provides reactive access to the current user's preferences.
@riverpod
class UserPreferencesRepository extends _$UserPreferencesRepository {
  @override
  Stream<Map<String, dynamic>> build() async* {
    final handler = await ref.watch(userPreferencesHandlerProvider.future);
    yield* handler.watchPreferences();
  }

  Future<void> write(String field, dynamic value) async {
    final handler = await ref.read(userPreferencesHandlerProvider.future);
    await handler.writePreference(field, value);
  }
}

/// Use [UserPreferencesRepository] instead.
@Deprecated('Use UserPreferencesRepository instead.')
typedef FirestoreUserSettingsRepository = UserPreferencesRepository;

/// Use [userPreferencesRepositoryProvider] instead.
@Deprecated('Use userPreferencesRepositoryProvider instead.')
final UserPreferencesRepositoryProvider firestoreUserSettingsRepositoryProvider =
    userPreferencesRepositoryProvider;
