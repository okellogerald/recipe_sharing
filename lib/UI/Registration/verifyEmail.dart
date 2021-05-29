import 'package:recipes_sharing/source.dart';

class VerifyEmail extends StatefulWidget {
  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

TextEditingController controller1 = TextEditingController(),
    controller2 = TextEditingController(),
    controller3 = TextEditingController(),
    controller4 = TextEditingController(),
    controller5 = TextEditingController(),
    controller6 = TextEditingController();

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  void initState() {
    userInformation.verifyEmailOtp = '';
    authBloc.varifyEmailSink.add(0);
    super.initState();
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
          await auth.changeAuthBlocStream('SignUpPage');
            Navigator.pop(context);
          return true;
        },
        child: Scaffold(
          backgroundColor: colors.scaffoldColor,
          body: Container(
              color: colors.backgroundColor2,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Expanded(
                      flex: 9,
                      child: _buildVerifyEmail(colors.iconColor,
                          colors.textColor1, colors.textfieldColor,currentTheme)),
                  Expanded(
                      child: _buildResendCode(
                          colors.textColor1, context, currentTheme))
                ],
              )),
        ),
      ),
    );
  }

  _buildVerifyEmail(Color iconColor, Color textColor, Color textFieldColor,Themes currentTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 50),
        Icon(EvaIcons.arrowBackOutline, color: iconColor),
        SizedBox(height: 20),
        Text('Verify',
            style: TextStyle(
                fontFamily: 'Gambetta-Medium', fontSize: 32, color: textColor)),
        SizedBox(height: 10),
        Text(
            'A code was sent to the Email Address you provided. Please check and fill it below.',
            style: TextStyle(
                fontFamily: 'Regular', fontSize: 18, color: textColor)),
        SizedBox(height: 20),
        Container(
          alignment: Alignment.center,
          height: 70,
          child: SizedBox(
            width: 320,
            child: ListView.separated(
                separatorBuilder: (context, index) =>
                    SizedBox(width: index == 5 ? 0 : 8),
                itemCount: 6,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  //seems like maximum textfields height is 50, below was just a work around to get a bigger textfield.
                  return Container(
                      height: 45,
                      width: 45,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: textFieldColor),
                      child: SizedBox(
                        height: 45,
                        width: 45,
                        child: TextField(
                          autofocus: true,
                          controller: index == 0
                              ? controller1
                              : index == 1
                                  ? controller2
                                  : index == 2
                                      ? controller3
                                      : index == 3
                                          ? controller4
                                          : index == 4
                                              ? controller5
                                              : controller6,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Regular',
                              fontSize: 18,
                              color: textColor),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Colors.transparent,
                              hintText: '#',
                              contentPadding: EdgeInsets.all(0),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40.0)),
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40.0)),
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              hintStyle: TextStyle(
                                  fontFamily: 'Regular',
                                  fontSize: 18,
                                  color: textColor.withOpacity(.7))),
                          onChanged: (value) {
                            if (value.length == 1) {
                              userInformation.verifyEmailOtp =
                                  userInformation.verifyEmailOtp + value;

                              authBloc.varifyEmailSink
                                  .add(userInformation.verifyEmailOtp.length);

                              if (index != 5) {
                                FocusScope.of(context).nextFocus();
                              } else {
                                FocusScope.of(context).unfocus();
                                authBloc.eventSink.add(Events.verifyEmail);
                              }
                            }
                          },
                        ),
                      ));
                }),
          ),
        ),
        SizedBox(height: 40),
        GestureDetector(
          onTap: () {},
          child: StreamBuilder<String>(
              stream: authBloc.authStream,
              builder: (context, verificationSnapshot) {
                return StreamBuilder<int>(
                    stream: authBloc.verifyEmailStream,
                    initialData: 0,
                    builder: (context, verificationCounterSnapshot) {
                      if (verificationCounterSnapshot.data == 0) {
                        return _buildChangingStateContainer(
                            textColor, 'Verify', true);
                      } else if (verificationCounterSnapshot.data < 6 &&
                          verificationCounterSnapshot.data != 0) {
                        return _buildChangingStateContainer(
                            textColor,
                            '${6 - verificationCounterSnapshot.data} to go',
                            true);
                      } else if (verificationCounterSnapshot.data == 6) {
                        if (verificationSnapshot.data ==
                            verificationEvents.verified) {
                          authBloc.eventSink.add(Events.signUp);
                        } else if (verificationSnapshot.data ==
                            verificationEvents.verificationFailed) {
                          auth.invalidCode(context);
                          authBloc.varifyEmailSink.add(0);
                          auth.displaySnackBar(context, 'Invalid OTP Code');
                        } else if (verificationSnapshot.data ==
                            signingUpEvents.signingUpStarted) {
                          return _buildLoadingContainer(textColor);
                        } else if (verificationSnapshot.data ==
                            signingUpEvents.signedUp) {
                          Future.delayed(Duration(milliseconds: 400)).then(
                              (value) => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ChangeNotifierProvider.value(
                                              value: currentTheme,
                                              child: HomePage()))));
                        } else if (verificationSnapshot.data ==
                            signingUpEvents.signingUpFailed) {
                          authBloc.varifyEmailSink.add(0);
                          auth.displaySnackBar(
                              context, signingUpEvents.signingUpErrorMessage);
                        }
                      }
                      return _buildChangingStateContainer(
                          textColor, 'Done', false);
                    });
              }),
        )
      ],
    );
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

  _buildResendCode(Color textColor, BuildContext context, Themes currentTheme) {
    return GestureDetector(
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
        child: Text(
          'Resend Code',
          style:
              TextStyle(fontFamily: 'Regular', fontSize: 18, color: textColor),
        ),
      ),
    );
  }
}
