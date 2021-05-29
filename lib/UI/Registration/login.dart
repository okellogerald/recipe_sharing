import 'package:recipes_sharing/source.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  static TextEditingController _controller1, _controller2;
  final isPasswordVisible = ValueNotifier<bool>(false);

  @override
  void initState() {
    _controller1 = TextEditingController();
    _controller2 = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = context.watch<Themes>();
    final colors = ThemesData(currentTheme.theme);
    return ChangeNotifierProvider.value(
      value: currentTheme,
      child: Scaffold(
        backgroundColor: colors.scaffoldColor,
        body: Container(
          color: colors.backgroundColor2,
          child: Column(
            children: [
              _buildLogIn(currentTheme.toggleThemes, currentTheme,
                  colors.textColor1, colors.iconColor, colors.textfieldColor),
              _buildDontHaveAccount(colors.textColor1, context, currentTheme)
            ],
          ),
        ),
      ),
    );
  }

  _buildLogIn(Function toggleThemes, Themes currentTheme, Color textColor,
      Color iconColor, Color textFieldColor) {
    return Expanded(
        flex: 9,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Icon(EvaIcons.arrowBackOutline, color: iconColor),
              SizedBox(height: 20),
              Text('Log In',
                  style: TextStyle(
                      fontFamily: 'Gambetta-Medium',
                      fontSize: 32,
                      color: textColor)),
              SizedBox(
                height: 152,
                child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        SizedBox(height: index == 1 ? 0 : 20),
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return ValueListenableBuilder<bool>(
                          valueListenable: isPasswordVisible,
                          builder: (context, _, __) {
                            return Container(
                                height: 50,
                                child: TextField(
                                  controller:
                                      index == 0 ? _controller1 : _controller2,
                                  obscureText: index == 0
                                      ? false
                                      : !isPasswordVisible.value,
                                  textInputAction: index == 0
                                      ? TextInputAction.next
                                      : TextInputAction.done,
                                  autofocus: true,
                                  style: TextStyle(
                                      fontFamily: 'Regular',
                                      fontSize: 18,
                                      color: textColor),
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: textFieldColor,
                                      hintText:
                                          index == 0 ? 'Email' : 'Password',
                                      suffixIcon: index == 0
                                          ? Icon(EvaIcons.eye,
                                              color: Colors.transparent)
                                          : GestureDetector(
                                              onTap: () {
                                                isPasswordVisible.value =
                                                    !isPasswordVisible.value;
                                              },
                                              child: Icon(
                                                  isPasswordVisible.value
                                                      ? EvaIcons.eyeOff
                                                      : EvaIcons.eye,
                                                  color: iconColor),
                                            ),
                                      hintStyle: TextStyle(
                                          fontFamily: 'Regular',
                                          fontSize: 18,
                                          color: textColor.withOpacity(.7))),
                                  onEditingComplete: () {
                                    if (index == 0) {
                                      FocusScope.of(context).nextFocus();
                                    } else {
                                      FocusScope.of(context).unfocus();
                                      userInformation.email =
                                          _controller1.text.trim();
                                      userInformation.password =
                                          _controller2.text.trim();

                                      authBloc.eventSink.add(Events.signIn);
                                    }
                                  },
                                ));
                          });
                    }),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ChangeNotifierProvider.value(
                                      value: currentTheme,
                                      child: HomePage())));
                    },
                    child: Text('Forgot password',
                        style: TextStyle(
                            fontFamily: 'Regular',
                            fontSize: 16,
                            color: textColor.withOpacity(.7))),
                  ),
                ],
              ),
              SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  userInformation.email = _controller1.text.trim();
                  userInformation.password = _controller2.text.trim();

                  authBloc.eventSink.add(Events.signIn);
                },
                child: StreamBuilder<String>(
                    stream: authBloc.authStream,
                    initialData: signingInEvents.initialState,
                    builder: (context, snapshot) {
                      String state = snapshot.data;
                      if (state == signingInEvents.initialState) {
                        return _buildChangingStateContainer(
                            textColor, 'Log in', true);
                      } else if (state == signingInEvents.signingInStarted) {
                        return _buildLoadingContainer(textColor);
                      } else if (state == signingInEvents.signedIn) {
                        Future.delayed(Duration(milliseconds: 400)).then(
                            (value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ChangeNotifierProvider.value(
                                            value: currentTheme,
                                            child: HomePage()))));
                      } else if (state == signingInEvents.signingInFailed) {
                        auth.displaySnackBar(
                            context, signingInEvents.signingInErrorMessage);
                        authBloc.authSink.add(signingInEvents.initialState);
                      }
                      return _buildChangingStateContainer(
                          textColor, 'Done', false);
                    }),
              )
            ],
          ),
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
                        value: currentTheme, child: SignUpPage())));
          },
          child: Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(
              bottom: 10,
            ),
            child: Text.rich(TextSpan(
              text: 'Don\'t have an account? ',
              style: TextStyle(
                  fontFamily: 'Regular', fontSize: 16, color: textColor),
              children: [
                TextSpan(
                  text: 'Sign Up',
                  style: TextStyle(
                      fontFamily: 'Medium', fontSize: 16, color: textColor),
                ),
              ],
            )),
          ),
        ));
  }
}
