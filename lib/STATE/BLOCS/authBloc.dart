import 'dart:async';
import 'package:recipes_sharing/source.dart';


abstract class AuthState {
  void dispose();
}

enum Events { sendOTP, signIn, verifyEmail, signUp }

class VerificationEvents {
  String verified = 'VerifiedSuccessfully';
  String verificationFailed = 'VerificationFailed';
}

class SigningUpEvents {
  String signedUp = 'SignedUpSuccessfully';
  String signingUpStarted = 'SigningUpStarted';
  String signingUpFailed = 'SigningInFailed';
  String signingUpErrorMessage;
}

class SigningInEvents {
  String signedIn = 'SignedInSuccessfully';
  String signingInStarted = 'SigningInStarted';
  String initialState = 'SigningInInitialState';
  String signingInFailed = 'SigningInFailed';
  String signingInErrorMessage;
}

class SendingOtpEvents {
  String sentOtp = 'SuccessfullySentOtp';
  String initialState = 'SendingOtpInitialState';
  String sendingOtpStarted = 'SendingOtpStarted';
  String sendingOtpFailed = 'SendingOtpFailed';
}

class UserInformation {
  String email, password, username, verifyEmailOtp = '';
  UserCredential userCredential;
}

final userInformation = UserInformation();
final auth = AuthenticatingFunctions();
final verificationEvents = VerificationEvents();
final signingUpEvents = SigningUpEvents();
final signingInEvents = SigningInEvents();
final sendingOtpEvents = SendingOtpEvents();

class AuthBloc extends AuthState {
  StreamController<Events> _eventStreamController =
      StreamController.broadcast();
  Stream<Events> get _eventStream => _eventStreamController.stream;
  StreamSink<Events> get eventSink => _eventStreamController.sink;

  StreamController<String> _authStreamController = StreamController.broadcast();
  Stream<String> get authStream => _authStreamController.stream;
  StreamSink<String> get authSink => _authStreamController.sink;

  StreamController<int> _verifyEmailStreamController =
      StreamController.broadcast();
  Stream<int> get verifyEmailStream => _verifyEmailStreamController.stream;
  StreamSink<int> get varifyEmailSink => _verifyEmailStreamController.sink;

  @override
  void dispose() {
    _eventStreamController.close();
    _authStreamController.close();
    _verifyEmailStreamController.close();
  }

  AuthBloc() {
    _eventStream.listen((event) async {
      if (event == Events.sendOTP) {
        authSink.add(sendingOtpEvents.sendingOtpStarted);
        bool _isSentOTp = await auth.sendOtp(userInformation.email);
        String _state = _isSentOTp
            ? sendingOtpEvents.sentOtp
            : sendingOtpEvents.sendingOtpFailed;
        authSink.add(_state);
      }
      if (event == Events.verifyEmail) {
        bool isVerified;
        if (userInformation.verifyEmailOtp.length == 6) {
          isVerified =
              auth.verifyUser(userInformation.email, userInformation.verifyEmailOtp);
          String _state = isVerified
              ? verificationEvents.verified
              : verificationEvents.verificationFailed;
          authSink.add(_state);
        }
      }
      if (event == Events.signUp) {
        authSink.add(signingUpEvents.signingUpStarted);
        bool _success;
        _success = await auth.signUpUserWithFirebase(
            userInformation.email, userInformation.password);
        String _state = _success
            ? signingUpEvents.signedUp
            : signingUpEvents.signingUpFailed;
        authSink.add(_state);
      }
      if (event == Events.signIn) {
        authSink.add(signingInEvents.signingInStarted);
        bool isSignedIn;
        isSignedIn = await auth.signInUserWithFirebase(
            userInformation.email, userInformation.password);
        String _state = isSignedIn
            ? signingInEvents.signedIn
            : signingInEvents.signingInFailed;
        authSink.add(_state);
      }
    });
  }
}
