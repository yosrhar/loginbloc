import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:loginbloc/Authentification/repositories/database/base_database_repository.dart';
import 'package:loginbloc/Authentification/repositories/storage/storage_repository.dart';
import 'package:loginbloc/user_model.dart';

class DatabaseRepository extends BaseDatabaseRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Stream<User> getUser(String userId) {
    print('Getting user images from DB');
    return _firebaseFirestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snap) => User.fromSnap(snap));
  }

  @override
  Stream<List<User>> getUsers(
    String userId,
    String gender,
  ) {
    return _firebaseFirestore
        .collection('users')
        .where('gender', isNotEqualTo: gender)
        .snapshots()
        .map((snap) {
      return snap.docs.map((doc) => User.fromSnap(doc)).toList();
    });
  }

  @override
  Future<void> createUser(User user) async {
    await _firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .set(user.toMap());
  }

  @override
  Future<void> updateUser(User user) async {
    return _firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .update(user.toMap())
        .then(
          (value) => print('User document updated.'),
        );
  }

  @override
  Future<void> updateUserPictures(User user, String imageName) async {
    String downloadUrl =
        await StorageRepository().getDownloadURL(user, imageName);
    print('Updating user photoUrl in the db');
    print(downloadUrl);
    return _firebaseFirestore.collection('users').doc(user.uid).update({
      'photoUrl': downloadUrl,
    });
  }
}
