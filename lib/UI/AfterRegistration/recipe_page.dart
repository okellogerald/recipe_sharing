import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:recipes_sharing/UI/AfterRegistration/start_cooking_page.dart';
import 'package:recipes_sharing/source.dart';

class RecipePage extends StatefulWidget {
  RecipePage({Key key}) : super(key: key);

  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final currentTheme = context.watch<Themes>();
    final colors = ThemesData(currentTheme.theme);
    final recipe = valuesKeeper.recipeData;
    return SafeArea(
      child: Scaffold(
        backgroundColor: colors.scaffoldColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildRecipeTopView(colors: colors, recipe: recipe),
              _buildAboutTheRecipe(colors: colors, recipe: recipe),
              _buildRecipeIngredients(colors, size, recipe),
              _buildRecipeSteps(size, recipe, colors, currentTheme)
            ],
          ),
        ),
      ),
    );
  }

  _buildRecipeTopView({ThemesData colors, RecipesData recipe}) {
    return AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
                color: colors.backgroundColor2,
                image: DecorationImage(
                    image: NetworkImage(recipe.recipeImage),
                    fit: BoxFit.cover)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                    onPressed: () {},
                    color: Colors.grey.withOpacity(.7),
                    padding: EdgeInsets.all(5),
                    shape: CircleBorder(),
                    child: Icon(EvaIcons.arrowBack, color: colors.iconColor)),
                MaterialButton(
                    onPressed: () {},
                    color: Colors.grey.withOpacity(.7),
                    padding: EdgeInsets.all(5),
                    shape: CircleBorder(),
                    child:
                        Icon(EvaIcons.moreHorizotnal, color: colors.iconColor)),
              ],
            )));
  }

  _buildMeasuringContainer(
      {ThemesData colors,
      int length,
      String activity,
      double percentValue,
      RecipesData recipe}) {
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 90.0,
          lineWidth: 2.0,
          percent: percentValue,
          center: Text("${length.toString()}\nmin",
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                  fontFamily: 'Regular',
                  fontSize: 16,
                  color: colors.textColor1)),
          progressColor: colors.buttonColor2,
        ),
        SizedBox(height: 15),
        Text(activity,
            style: TextStyle(
                fontFamily: 'Regular', fontSize: 16, color: colors.textColor1))
      ],
    );
  }

  _buildAboutTheRecipe({ThemesData colors, RecipesData recipe}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          Text(recipe.title,
              style: TextStyle(
                  fontFamily: 'Gambetta-Semibold',
                  fontSize: 30,
                  color: colors.textColor1)),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: colors.buttonColor1)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(EvaIcons.heartOutline, color: colors.iconColor),
                    SizedBox(width: 20),
                    Text('12k',
                        style: TextStyle(
                            fontFamily: 'Regular',
                            fontSize: 16,
                            color: colors.textColor1)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(EvaIcons.bookmarkOutline, color: colors.iconColor),
                    SizedBox(width: 20),
                    Text('save',
                        style: TextStyle(
                            fontFamily: 'Regular',
                            fontSize: 16,
                            color: colors.textColor1)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(EvaIcons.shareOutline, color: colors.iconColor),
                    SizedBox(width: 20),
                    Text('share',
                        style: TextStyle(
                            fontFamily: 'Regular',
                            fontSize: 16,
                            color: colors.textColor1)),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(recipe.authorImage),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    height: 50,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(recipe.authorName,
                              style: TextStyle(
                                  fontFamily: 'Regular',
                                  fontSize: 16,
                                  color: colors.textColor1)),
                          Text('100k followers',
                              style: TextStyle(
                                  fontFamily: 'Regular',
                                  fontSize: 14,
                                  color: colors.textColor1.withOpacity(.7))),
                        ]),
                  ),
                ],
              ),
              MaterialButton(
                onPressed: () {},
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                color: colors.buttonColor2,
                child: Text('Follow',
                    style: TextStyle(
                        fontFamily: 'Medium',
                        fontSize: 18,
                        color: colors.textColor1)),
              )
            ],
          ),
          SizedBox(height: 20),
          Text(recipe.recipeDescription,
              style: TextStyle(
                  fontFamily: 'Regular',
                  fontSize: 16,
                  color: colors.textColor1)),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(width: 1, color: colors.buttonColor1),
                    bottom: BorderSide(width: 1, color: colors.buttonColor1))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Text('Servings',
                        style: TextStyle(
                            fontFamily: 'Medium',
                            fontSize: 16,
                            color: colors.textColor1.withOpacity(.7))),
                    SizedBox(width: 20),
                    Text('${recipe.servings} pp',
                        style: TextStyle(
                            fontFamily: 'Regular',
                            fontSize: 16,
                            color: colors.textColor1)),
                  ],
                ),
                Row(
                  children: [
                    Text('Difficulty',
                        style: TextStyle(
                            fontFamily: 'Medium',
                            fontSize: 16,
                            color: colors.textColor1.withOpacity(.7))),
                    SizedBox(width: 20),
                    Text(recipe.difficulty,
                        style: TextStyle(
                            fontFamily: 'Regular',
                            fontSize: 16,
                            color: colors.textColor1)),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMeasuringContainer(
                  recipe: recipe,
                  colors: colors,
                  percentValue: recipe.length / 60 > 1 ? 1 : recipe.length / 60,
                  activity: 'Cooking',
                  length: recipe.length),
              _buildMeasuringContainer(
                  activity: 'Baking',
                  recipe: recipe,
                  colors: colors,
                  percentValue: recipe.baking / 60 > 1 ? 1 : recipe.baking / 60,
                  length: recipe.baking),
              _buildMeasuringContainer(
                  activity: 'Chilling',
                  recipe: recipe,
                  colors: colors,
                  percentValue:
                      recipe.chilling / 60 > 1 ? 1 : recipe.chilling / 60,
                  length: recipe.chilling),
            ],
          ),
          SizedBox(height: 30),
          Container(height: 1, color: colors.buttonColor1)
        ],
      ),
    );
  }

  _buildRecipeIngredients(ThemesData colors, Size size, RecipesData recipe) {
    return Container(
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text('Ingredients',
              style: TextStyle(
                  fontFamily: 'Gambetta-Medium',
                  fontSize: 30,
                  color: colors.textColor1)),
          SizedBox(height: 10),
          SizedBox(
            width: size.width,
            child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemCount: recipe.ingredients.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, _index) {
                  return Text.rich(TextSpan(
                      style: TextStyle(
                          fontFamily: 'Medium',
                          fontSize: 16,
                          color: colors.textColor1),
                      children: [
                        TextSpan(
                            text: recipe.ingredients[_index]['quantity']
                                .toString()),
                        TextSpan(
                            text: ' ' + recipe.ingredients[_index]['measure']),
                        TextSpan(
                            text:
                                ' ' + recipe.ingredients[_index]['ingredient'])
                      ]));
                }),
          ),
          SizedBox(height: 30),
          Center(
            child: MaterialButton(
              onPressed: () {},
              minWidth: 300,
              height: 45,
              color: colors.buttonColor1,
              child: Text(
                'Add to Shopping List',
                style: TextStyle(
                    fontFamily: 'Medium',
                    fontSize: 18,
                    color: colors.textColor2),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  _buildRecipeSteps(
      Size size, RecipesData recipe, ThemesData colors, Themes currentTheme) {
    return Container(
      color: Colors.grey.withOpacity(.3),
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Text(
            'Directions',
            style: TextStyle(
                fontFamily: 'Gambetta-Medium',
                fontSize: 30,
                color: colors.textColor1),
          ),
          SizedBox(height: 10),
          SizedBox(
              height: 400,
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(width: 20),
                itemCount: recipe.steps.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 200,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    recipe.steps[index]['image']))),
                      ),
                      Text(
                        'Step ${index + 1}',
                        style: TextStyle(
                            fontFamily: 'Medium',
                            fontSize: 22,
                            color: colors.textColor1),
                      ),
                      SizedBox(
                        width: 300,
                        height: 100,
                        child: Text(
                          recipe.steps[index]['step'],
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                          style: TextStyle(
                              fontFamily: 'Regular',
                              fontSize: 18,
                              color: colors.textColor1),
                        ),
                      ),
                    ],
                  );
                },
              )),
          SizedBox(height: 20),
          Center(
            child: MaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider.value(
                            value: currentTheme, child: StartCookingPage(recipe))));
              },
              minWidth: 320,
              height: 45,
              color: colors.buttonColor2,
              child: Text(
                'Start Cooking',
                style: TextStyle(
                    fontFamily: 'Medium',
                    fontSize: 18,
                    color: colors.textColor1),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
