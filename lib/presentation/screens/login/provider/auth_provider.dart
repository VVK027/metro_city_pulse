import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authProvider).authStateChanges();
});

final loginStatusProvider = StateProvider<String?>((ref) => null);

Future<void> loginWithEmailAndPassword(WidgetRef ref, String email, String password) async {
  final auth = ref.read(authProvider);
  final loginStatus = ref.read(loginStatusProvider.notifier);

  try {
    await auth.signInWithEmailAndPassword(email: email, password: password);
    loginStatus.state = "success";
  } on FirebaseAuthException catch (e) {
    loginStatus.state = e.message ?? "Login failed";
  } catch (e) {
    loginStatus.state = "Unknown error occurred";
  }
}

Future<String?> signInWithGoogle(WidgetRef ref) async {
  try {
    // final googleUser = await GoogleSignIn.signIn();
    // if (googleUser == null) return "Cancelled";
    //
    // final googleAuth = await googleUser.authentication;
    // final credential = GoogleAuthProvider.credential(
    //   accessToken: googleAuth.accessToken,
    //   idToken: googleAuth.idToken,
    // );
    //
    // await ref.read(authProvider).signInWithCredential(credential);
    return null;
  } catch (e) {
    return "Google sign-in failed";
  }
}