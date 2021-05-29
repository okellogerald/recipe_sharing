import 'package:recipes_sharing/source.dart';

class PostRecipePhoto extends StatelessWidget {
  const PostRecipePhoto({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentTheme = context.watch<Themes>();
    final colors = ThemesData(currentTheme.theme);
    return Scaffold(
      backgroundColor: colors.backgroundColor1,
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Well Done!',
                style: TextStyle(
                    fontFamily: 'Medium',
                    fontSize: 20,
                    color: colors.textColor1)),
            SizedBox(height: 20),
            Text('Let\'s share your masterpiece to everyone',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Regular',
                    fontSize: 20,
                    color: colors.textColor1.withOpacity(.8))),
            SizedBox(height: 30),
            MaterialButton(
                onPressed: () {},
                minWidth: 100,
                height: 100,
                color: colors.buttonColor2,
                shape: CircleBorder(),
                child: Icon(EvaIcons.camera, color: colors.iconColor, size: 60))
          ],
        ),
      ),
    );
  }
}
