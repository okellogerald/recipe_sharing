import 'package:recipes_sharing/source.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentTheme = context.watch<Themes>();
    final colors = ThemesData(currentTheme.theme);
    return Container(
        alignment: Alignment.bottomRight,
        padding:EdgeInsets.only(bottom:20,right:20),
        child: MaterialButton(
            onPressed: () =>  currentTheme.toggleThemes(),
            color: colors.buttonColor2,
            minWidth: 300,
            height: 50,
            child: Text('Change Theme',
                style: TextStyle(
                    fontFamily: 'Medium',
                    color: colors.textColor1,
                    fontSize: 18))));
  }
}
