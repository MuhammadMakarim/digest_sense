import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthController extends GetxController {
  //TODO: Implement FirebaseAuthController
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> signInWithEmailandPassword(
      String email, String password) async {
    try {
    
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return {
        "error": false,
        "message": "Berhasil login.",
      };
    } on FirebaseAuthException catch (e) {
      return {
        "error": true,
        "message": "${e.message}",
      };
    }
  }
}
