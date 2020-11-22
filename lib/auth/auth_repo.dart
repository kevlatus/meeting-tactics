import 'package:calendar_service/calendar_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire_auth;
import 'package:google_sign_in/google_sign_in.dart';

import 'auth_models.dart';

extension on GoogleSignInAccount {
  Future<User> get toUser async {
    if (this == null) {
      return null;
    }
    final authentication = await this.authentication;
    return User(
      id: id,
      email: email,
      name: displayName,
      photo: photoUrl,
      accessToken: authentication.accessToken,
    );
  }
}

/// Thrown during the sign in with google process if a failure occurs.
class SignInFailure implements Exception {}

/// Thrown during the logout process if a failure occurs.
class SignOutFailure implements Exception {}

class AuthRepository implements AccessTokenProvider {
  final fire_auth.FirebaseAuth _fireAuth;
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    fire_auth.FirebaseAuth firebaseAuth,
    GoogleSignIn googleSignIn,
  })  : _fireAuth = firebaseAuth ?? fire_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard() {
    _googleSignIn.signInSilently();
  }

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [User.empty] if the user is not authenticated.
  Stream<User> get user {
    return _googleSignIn.onCurrentUserChanged.asyncMap((googleUser) async {
      return googleUser == null
          ? User.empty
          : await _googleSignIn.currentUser.toUser;
    });
  }

  Stream<bool> get isSignedIn {
    return user.map((it) => it != null);
  }

  Future<void> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser.authentication;
      final credential = fire_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _fireAuth.signInWithCredential(credential);
    } on Exception catch (e) {
      print(e);
      throw SignInFailure();
    }
  }

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  ///
  /// Throws a [SignOutFailure] if an exception occurs.
  Future<void> signOut() async {
    try {
      await Future.wait([
        _fireAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } on Exception {
      throw SignOutFailure();
    }
  }

  @override
  Future<String> get accessToken async {
    if (_googleSignIn.currentUser == null) {
      return null;
    }

    final auth = await _googleSignIn.currentUser.authentication;
    return auth.accessToken;
  }
}
