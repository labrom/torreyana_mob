import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tourbillauth/auth.dart';

part 'settings.g.dart';

@riverpod
class FirestoreUserSettingsRepository
    extends _$FirestoreUserSettingsRepository {
  @override
  Stream<Map<String, dynamic>> build() => FirebaseFirestore.instance
      .collection('user-settings')
      // TODO Replace 'anon' with anonymous Firebase sign-in
      .doc(ref.read(firebaseAuthProvider).currentUser?.uid ?? 'anon')
      .snapshots()
      .map((snapshot) => snapshot.data() ?? {});

  Future<void> write(String field, dynamic value) async {
    FirebaseFirestore.instance
        .collection('user-settings')
        // TODO Replace 'anon' with anonymous Firebase sign-in
        .doc(ref.read(firebaseAuthProvider).currentUser?.uid ?? 'anon')
        .set({field: value}, SetOptions(merge: true));
  }
}
