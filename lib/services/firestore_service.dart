import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class FirestoreService {
  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection('users');

  Future<void> saveUserToFirestore(User user, String username) async {
    DocumentSnapshot doc = await usersRef.doc(user.uid).get();

    if (!doc.exists) {
      await usersRef.doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
        'username': username,
        'avatarURL': 'assets/UnivalleLogo.png'
      });
    }
  }

  Future<UserModel> getUserFromFirestore(String uid) async {
    DocumentSnapshot doc = await usersRef.doc(uid).get();
    if (doc.exists) {
      return UserModel.fromDocument(doc);
    }
    throw Exception('El usuario no existe');
  }

  Future<void> updateUser(UserModel user) async {
    await usersRef.doc(user.uid).update(user.toMap());
  }
}
