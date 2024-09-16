import 'package:firebase_auth/firebase_auth.dart';

class SignupDataSource {
  static String errorMessage = '';
  static bool isLoading = false;

  static Future<bool> signup({
    required String email,
    required String password,
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
}
