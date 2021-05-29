import 'package:recipes_sharing/source.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentTheme = context.watch<Themes>();
    final colors = ThemesData(currentTheme.theme);
    return Scaffold(
      backgroundColor: colors.scaffoldColor,
      body: Container(
        child: _buildSignInPage(
            context, currentTheme.toggleThemes, colors, currentTheme),
      ),
    );
  }

  _buildSignInPage(BuildContext context, Function toggleThemes,
      ThemesData colors, Themes currentTheme) {
    return Column(
      children: [
        SizedBox(height: 40),
        Expanded(
          flex: 4,
          child: Container(
            child: Image.asset('assets/first-image-4.png', fit: BoxFit.contain),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text('Best-Ever Recipes App',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 45,
                    fontFamily: 'Gambetta-Semibold',
                    color: colors.textColor1)),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider.value(
                              value: currentTheme, child: LogInPage())));
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: 50,
                  decoration: BoxDecoration(
                      color: colors.buttonColor1,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Text('Sign in with Email',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Medium',
                          fontSize: 20,
                          color: colors.textColor2)),
                ),
              ),
            ],
          ),
        ),
        _buildSocialMediaLogin(colors)
      ],
    );
  }

  _buildSocialMediaLogin(ThemesData colors) {
    return Expanded(
      flex: 3,
      child: Column(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(child: Container(height: 2, color: Colors.grey)),
                    Padding(
                      padding:
                          const EdgeInsets.only(bottom: 6, left: 6, right: 6),
                      child: Text('or sign in with',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Regular',
                              fontSize: 18,
                              color: colors.textColor1.withOpacity(.7))),
                    ),
                    Expanded(child: Container(height: 2, color: Colors.grey))
                  ],
                ),
              )),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MaterialButton(
                  padding: EdgeInsets.all(15),
                  onPressed: () {},
                  color: Color(0xff4867AA),
                  shape: CircleBorder(),
                  child: Icon(EvaIcons.facebook, color: colors.iconColor),
                ),
                MaterialButton(
                  padding: EdgeInsets.all(15),
                  onPressed: () {},
                  color: Color(0xffFABB05),
                  shape: CircleBorder(),
                  child: Icon(EvaIcons.google, color: colors.iconColor),
                ),
                MaterialButton(
                  padding: EdgeInsets.all(15),
                  onPressed: () {},
                  color: Color(0xff55ADED),
                  shape: CircleBorder(),
                  child: Icon(EvaIcons.twitter, color: colors.iconColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
