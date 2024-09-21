import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:icthub_2024_9/features/more/data/data_model/user_model.dart';

class ProfileDataSource {
  Future<UserModel> getUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    DocumentSnapshot<Map<String, dynamic>> doc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (doc.exists) {
      return UserModel.fromMap(doc.data()!);
    } else {
      throw Exception('user_not_found');
    }
  }

  Future<void> setUserData({
    required String name,
    required String phone,
  }) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final email = FirebaseAuth.instance.currentUser?.email;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    UserModel userModel = UserModel(
      name: name,
      phone: int.parse(phone),
      email: email ?? '',
      password: '',
      uid: uid ?? '',
    );
    await users.doc(uid).set(userModel.toMap());
  }
}
