import 'package:recipes_sharing/UI/AfterRegistration/post_recipe_phot.dart';
import 'package:recipes_sharing/source.dart';

class StartCookingPage extends StatefulWidget {
  final RecipesData recipe;
  const StartCookingPage(this.recipe, {Key key}) : super(key: key);

  @override
  _StartCookingPageState createState() => _StartCookingPageState();
}

class _StartCookingPageState extends State<StartCookingPage> {
  ValueNotifier<int> _index;

  @override
  void initState() {
    _index = ValueNotifier<int>(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final currentTheme = context.watch<Themes>();
    final colors = ThemesData(currentTheme.theme);
    return SafeArea(
      child: Scaffold(
        backgroundColor: colors.backgroundColor1,
        body: ValueListenableBuilder(
          valueListenable: _index,
          builder: (context, snapshot, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: 300,
                    width: size.width,
                    child: Image.network(
                        widget.recipe.steps[_index.value]['image'],
                        fit: BoxFit.cover)),
                SizedBox(height: 20),
                widget.recipe.steps[_index.value]['step-ingredients'].length ==
                        0
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text('Ingredients',
                            style: TextStyle(
                                fontFamily: 'Gambetta-Medium',
                                fontSize: 30,
                                color: colors.textColor1)),
                      ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 20),
                  child: SizedBox(
                    width: size.width,
                    child: widget.recipe.steps.length == 0
                        ? Container()
                        : ListView.separated(
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 10),
                            itemCount: widget.recipe
                                .steps[_index.value]['step-ingredients'].length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Icon(EvaIcons.checkmark,
                                      color: colors.iconColor),
                                  SizedBox(width: 10),
                                  Text(
                                    widget.recipe.steps[_index.value]
                                        ['step-ingredients'][index],
                                    style: TextStyle(
                                        fontFamily: 'Medium',
                                        fontSize: 16,
                                        color: colors.textColor1),
                                  ),
                                ],
                              );
                            }),
                  ),
                ),
            
                widget.recipe.steps[_index.value]['step-ingredients'].length ==
                        0
                    ? Container()
                    : Container(
                        height: 2,
                        margin: EdgeInsets.only(left: 20,right:20,top:20),
                        color: colors.buttonColor1),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Text(
                      'STEP ' + '${_index.value + 1}',
                      style: TextStyle(
                          fontFamily: 'Medium',
                          fontSize: 16,
                          color: colors.textColor1.withOpacity(.7)),
                    )),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      widget.recipe.steps[_index.value]['step'],
                      style: TextStyle(
                          fontFamily: 'Regular',
                          fontSize: 16,
                          color: colors.textColor1),
                    )),
                Expanded(
                    child: Container(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                height: 40,
                                width: 250,
                                margin: EdgeInsets.only(bottom: 20),
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: widget.recipe.steps.length,
                                    itemBuilder: (context, index) =>
                                        MaterialButton(
                                          minWidth: 48,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: index == 0
                                                  ? BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(20),
                                                      bottomLeft:
                                                          Radius.circular(20))
                                                  : index ==
                                                          widget.recipe.steps
                                                                  .length -
                                                              1
                                                      ? BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  20),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  20))
                                                      : BorderRadius.all(
                                                          Radius.circular(0))),
                                          onPressed: () => _index.value = index,
                                          color: index == _index.value
                                              ? colors.buttonColor1
                                              : colors.buttonColor1
                                                  .withOpacity(.5),
                                          child: Text('${index + 1}',
                                              style: TextStyle(
                                                  fontFamily: 'Medium',
                                                  color: colors.textColor2
                                                      .withOpacity(.5),
                                                  fontSize: 18)),
                                        ))),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: TextButton(
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ChangeNotifierProvider.value(
                                                  value: currentTheme,
                                                  child: PostRecipePhoto()))),
                                  style: TextButton.styleFrom(
                                      backgroundColor: colors.buttonColor2,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5)),
                                  child: Text('Done',
                                      style: TextStyle(
                                          fontFamily: 'Regular',
                                          color: colors.textColor1,
                                          fontSize: 16))),
                            )
                          ],
                        )))
              ],
            );
          },
        ),
      ),
    );
  }
}
