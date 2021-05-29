import 'package:recipes_sharing/source.dart';

///Function that handles all logic during the authorization phase.
class AuthenticatingFunctions {
  final _auth = FirebaseAuth.instance;

  ///sends OTP to the email signed up with by the user
  Future<bool> sendOtp(String email) async {
    EmailAuth.sessionName = "Best-Ever Recipes App";
    bool result = await EmailAuth.sendOtp(receiverMail: email);
    return result;
  }

  ///verifies the user with the sent OTF in the email signed up with
  bool verifyUser(String email, String otpEnteredByUser) {
    return EmailAuth.validate(receiverMail: email, userOTP: otpEnteredByUser);
  }

  ///after the email is verified, then the user is signed up with FirebaseAuth
  Future<bool> signUpUserWithFirebase(String email, password) async {
    bool _isDone;

    try {
      userInformation.userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      _isDone = true;
    } on FirebaseAuthException catch (e) {
      _isDone = false;
      print(e.code);
      switch (e.code) {
        case 'email-already-in-use':
          signingUpEvents.signingUpErrorMessage =
              'That email address is already registered. Try signing in.';
          break;
        default:
          signingUpEvents.signingUpErrorMessage =
              'Unknown error happened, please try again later';
      }
    }

    return _isDone;
  }

  ///signs in user with FirebaseAuth
  Future<bool> signInUserWithFirebase(String email, password) async {
    bool _isDone;

    try {
      userInformation.userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _isDone = true;
    } on FirebaseAuthException catch (e) {
      _isDone = false;
      switch (e.code) {
        case "invalid-email":
          signingInEvents.signingInErrorMessage =
              "No user found for that email.";
          break;
        case "wrong-password":
          signingInEvents.signingInErrorMessage =
              "Wrong password for that email address";
          break;
        case "user-not-found":
          signingInEvents.signingInErrorMessage =
              "User with this email doesn't exist.";
          break;
        case "ERROR_USER_DISABLED":
          signingInEvents.signingInErrorMessage =
              "User with this email has been disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          signingInEvents.signingInErrorMessage =
              "Too many requests. Try again later.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          signingInEvents.signingInErrorMessage =
              "Signing in with Email and Password is not enabled.";
          break;
        default:
          signingInEvents.signingInErrorMessage =
              "An undefined Error happened. Please try again later";
      }
      print(e.code);
    }

    return _isDone;
  }

  ///Invalid OTP then clear all textfields and restart userInfo.verifyPassword
  invalidCode(BuildContext context) {
    userInformation.verifyEmailOtp = '';
    controller1.clear();
    controller2.clear();
    controller3.clear();
    controller4.clear();
    controller5.clear();
    controller6.clear();
    FocusScope.of(context).nextFocus();
  }

  ///displays snackBar
  displaySnackBar(BuildContext context, String message) {
    Future.delayed(Duration(milliseconds: 400)).then((value) =>
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.black,
            content: Text(message,
                style: TextStyle(
                    fontFamily: 'Regular',
                    fontSize: 14.0,
                    color: Colors.white)))));
  }

  ///makes sure the page navigated to is in its initial state.
  ///this is because init state isn't called when the page is popped to only when the page is navigated to.
  changeAuthBlocStream(String page) {
    switch (page) {
      case 'LoginPage':
        {
          authBloc.authSink.add(signingInEvents.initialState);
        }
        break;
      case 'SignUpPage':
        {
          authBloc.authSink.add(sendingOtpEvents.initialState);
        }
        break;
    
      default:
    }
  }
}
