import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:icthub_2024_9/features/more/data/data_model/user_model.dart';

class SignupDataSource {
  static String errorMessage = '';
  static bool isLoading = false;

  static Future<bool> signup({
    required String email,
    required String password,
    required String name,
    required int phone,
  }) async {
    try {
      isLoading = true;
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        isLoading = false;
        setUserData(
          name: name,
          phone: phone,
          email: email,
          password: password,
          uid: credential.user!.uid,
        );
        return true;
      } else {
        throw Exception('User not found');
      }
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      errorMessage = e.message ?? 'An error occurred';
      print(e);
      return false;
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      print(e);
      return false;
    }
  }

  static Future<void> setUserData({
    required String name,
    required int phone,
    required String email,
    required String password,
    required String uid,
  }) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    //! note => this is create default id for user
    // users.add({
    //         'name': name, // John Doe
    //         'phone': phone, // Stokes and Sons
    //         'email': email ,// 42
    //         'password': password // 42
    //       });
    UserModel userModel = UserModel(
      name: name,
      phone: phone,
      email: email,
      password: password,
      uid: uid,
    );
    users.doc(uid).set(userModel.toMap());
  }
}
