import 'package:recipes_sharing/source.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  static TextEditingController _controller1;
  static TextEditingController _controller2;
  static TextEditingController _controller3;
  static final _formKey = GlobalKey<FormState>();
  static final ValueNotifier isPasswordVisible = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _controller1 = TextEditingController();
    _controller2 = TextEditingController();
    _controller3 = TextEditingController();
    authBloc.authSink.add(sendingOtpEvents.initialState);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = context.watch<Themes>();
    final colors = ThemesData(currentTheme.theme);
    return ChangeNotifierProvider.value(
      value: currentTheme,
      child: WillPopScope(
        onWillPop: () async {
        await  auth.changeAuthBlocStream('LoginPage');
          Navigator.pop(context);
          return true;
        },
        child: Scaffold(
          backgroundColor: colors.scaffoldColor,
          body: Container(
            color: colors.backgroundColor2,
            child: Column(
              children: [
                _buildSignUp(currentTheme, colors.textColor1, colors.iconColor,
                    colors.textfieldColor),
                _buildDontHaveAccount(colors.textColor1, context, currentTheme)
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildSignUp(Themes currentTheme, Color textColor, Color iconColor,
      Color textFieldColor) {
    return Expanded(
        flex: 9,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          shrinkWrap: true,
          children: [
            SizedBox(height: 50),
            Row(
              children: [
                Icon(EvaIcons.arrowBackOutline, color: iconColor),
              ],
            ),
            SizedBox(height: 20),
            Text('Sign Up',
                style: TextStyle(
                    fontFamily: 'Gambetta-Medium',
                    fontSize: 32,
                    color: textColor)),
            SizedBox(height: 20),
            Form(
                key: _formKey,
                child: ValueListenableBuilder(
                    valueListenable: isPasswordVisible,
                    builder: (context, _, __) {
                      return Column(
                        children: [
                          _buildUsernameTextField(
                              textColor, textFieldColor, iconColor),
                          _buildEmailTextField(
                              textColor, textFieldColor, iconColor),
                          _buildPasswordTextField(
                              textColor, textFieldColor, iconColor),
                        ],
                      );
                    })),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text.rich(TextSpan(
                  text: 'By Signing in you agree to the ',
                  style: TextStyle(
                      fontFamily: 'Regular',
                      fontSize: 16,
                      color: textColor.withOpacity(.7)),
                  children: [
                    TextSpan(
                        text: 'Terms & Conditions',
                        style: TextStyle(
                            fontFamily: 'Regular',
                            decoration: TextDecoration.underline,
                            fontSize: 16,
                            color: textColor.withOpacity(.7))),
                    TextSpan(
                        text: ' . You also read and agreed to our',
                        style: TextStyle(
                            fontFamily: 'Regular',
                            fontSize: 16,
                            color: textColor.withOpacity(.7))),
                    TextSpan(
                        text: ' Privacy Policy',
                        style: TextStyle(
                            fontFamily: 'Regular',
                            decoration: TextDecoration.underline,
                            fontSize: 16,
                            color: textColor.withOpacity(.7))),
                    TextSpan(
                        text: ' .',
                        style: TextStyle(
                            fontFamily: 'Regular',
                            fontSize: 16,
                            color: textColor.withOpacity(.7)))
                  ])),
            ),
            SizedBox(height: 40),
            GestureDetector(
              onTap: () async {
                if (_formKey.currentState.validate()) {
                  userInformation.email = _controller2.text;
                  userInformation.password = _controller3.text;
                  userInformation.username = _controller1.text;
                  authBloc.eventSink.add(Events.sendOTP);
                }
              },
              child: StreamBuilder<String>(
                  stream: authBloc.authStream,
                  initialData: sendingOtpEvents.initialState,
                  builder: (context, snapshot) {
                    if (snapshot.data == sendingOtpEvents.sentOtp) {
                      Future.delayed(Duration(milliseconds: 400)).then(
                          (value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ChangeNotifierProvider.value(
                                          value: currentTheme,
                                          child: VerifyEmail()))));
                    }
                    if (snapshot.data == sendingOtpEvents.sendingOtpFailed) {
                      authBloc.authSink.add(sendingOtpEvents.initialState);
                      auth.displaySnackBar(context,
                          'Failed to send OTP Code to verify your email.');
                    }
                    if (snapshot.data == sendingOtpEvents.sendingOtpStarted) {
                      return _buildLoadingContainer(textColor);
                    }
                    if (snapshot.data == sendingOtpEvents.initialState) {
                      return _buildChangingStateContainer(
                          textColor, 'Sign up', true);
                    } else
                      return _buildChangingStateContainer(
                          textColor, 'Done', false);
                  }),
            )
          ],
        ));
  }

  _buildLoadingContainer(Color textColor) {
    return Container(
        height: 45,
        color: Color(0xffF94701),
        alignment: Alignment.center,
        child: SizedBox(
          height: 20,
          child: LoadingIndicator(
              color: textColor, indicatorType: Indicator.lineScale),
        ));
  }

  _buildChangingStateContainer(Color textColor, String state, bool isActive) {
    return Container(
        height: 45,
        color: isActive ? Color(0xffF94701) : Color(0xffF94701).withOpacity(.7),
        alignment: Alignment.center,
        child: Text(state,
            style: TextStyle(
                fontFamily: 'Medium',
                fontSize: 18.0,
                color: isActive ? textColor : textColor.withOpacity(.7))));
  }

  _buildDontHaveAccount(
      Color textColor, BuildContext context, Themes currentTheme) {
    return Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider.value(
                        value: currentTheme, child: LogInPage())));
          },
          child: Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 10, right: 20),
            child: Text.rich(TextSpan(
              text: 'Already have an account? ',
              style: TextStyle(
                  fontFamily: 'Regular', fontSize: 16, color: textColor),
              children: [
                TextSpan(
                  text: 'Log in',
                  style: TextStyle(
                      fontFamily: 'Medium', fontSize: 16, color: textColor),
                ),
              ],
            )),
          ),
        ));
  }

  _buildUsernameTextField(
      Color textColor, Color textFieldColor, Color iconColor) {
    return Container(
        height: 50,
        margin: EdgeInsets.only(bottom: 20),
        child: TextFormField(
          controller: _controller1,
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          obscureText: false,
          style:
              TextStyle(fontFamily: 'Regular', fontSize: 18, color: textColor),
          decoration: InputDecoration(
              filled: true,
              fillColor: textFieldColor,
              hintText: 'Username',
              errorStyle: TextStyle(
                  fontFamily: 'Regular', fontSize: 14, color: Colors.red),
              hintStyle: TextStyle(
                  fontFamily: 'Regular',
                  fontSize: 18,
                  color: textColor.withOpacity(.7))),
          onEditingComplete: () {
            FocusScope.of(context).nextFocus();
          },
          validator: (value) {
            String error;
            if (value.isEmpty) {
              error = 'Username can\'t be empty';
            }
            return error;
          },
        ));
  }

  _buildEmailTextField(Color textColor, Color textFieldColor, Color iconColor) {
    return Container(
        height: 50,
        margin: EdgeInsets.only(bottom: 20),
        child: TextFormField(
          controller: _controller2,
          keyboardType: TextInputType.emailAddress,
          textCapitalization: TextCapitalization.none,
          textInputAction: TextInputAction.next,
          obscureText: false,
          style:
              TextStyle(fontFamily: 'Regular', fontSize: 18, color: textColor),
          decoration: InputDecoration(
              filled: true,
              fillColor: textFieldColor,
              hintText: 'Email',
              errorStyle: TextStyle(
                  fontFamily: 'Regular', fontSize: 14, color: Colors.red),
              hintStyle: TextStyle(
                  fontFamily: 'Regular',
                  fontSize: 18,
                  color: textColor.withOpacity(.7))),
          onEditingComplete: () {
            FocusScope.of(context).nextFocus();
          },
          validator: (value) {
            var reg = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
            String error;
            if (!reg.hasMatch(value)) {
              error = 'Invalid  email address';
            }
            return error;
          },
        ));
  }

  _buildPasswordTextField(
      Color textColor, Color textFieldColor, Color iconColor) {
    return Container(
        height: 50,
        margin: EdgeInsets.only(bottom: 20),
        child: TextFormField(
          controller: _controller3,
          keyboardType: TextInputType.visiblePassword,
          textCapitalization: TextCapitalization.none,
          textInputAction: TextInputAction.done,
          obscureText: !isPasswordVisible.value,
          style:
              TextStyle(fontFamily: 'Regular', fontSize: 18, color: textColor),
          decoration: InputDecoration(
              filled: true,
              fillColor: textFieldColor,
              hintText: 'Password',
              suffixIcon: GestureDetector(
                  onTap: () {
                    isPasswordVisible.value = !isPasswordVisible.value;
                  },
                  child: Icon(
                      isPasswordVisible.value ? EvaIcons.eyeOff : EvaIcons.eye,
                      color: iconColor)),
              errorStyle: TextStyle(
                  fontFamily: 'Regular', fontSize: 14, color: Colors.red),
              hintStyle: TextStyle(
                  fontFamily: 'Regular',
                  fontSize: 18,
                  color: textColor.withOpacity(.7))),
          onFieldSubmitted: (value) {
            _formKey.currentState.validate();
            if (_formKey.currentState.validate()) {
              userInformation.email = _controller2.text;
              userInformation.password = _controller3.text;
              userInformation.username = _controller1.text;
              authBloc.eventSink.add(Events.sendOTP);
            }
          },
          validator: (value) {
            String error;
            if (value.isEmpty) {
              error = 'Password can\'t be empty';
            }
            return error;
          },
        ));
  }
}
