import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class TestTokenFirebaseUser {
  TestTokenFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

TestTokenFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<TestTokenFirebaseUser> testTokenFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<TestTokenFirebaseUser>(
      (user) {
        currentUser = TestTokenFirebaseUser(user);
        return currentUser!;
      },
    );
