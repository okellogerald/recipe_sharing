import 'package:recipes_sharing/UI/AfterRegistration/profile_page.dart';
import 'package:recipes_sharing/UI/AfterRegistration/recipe_page.dart';
import 'package:recipes_sharing/UI/AfterRegistration/videoplayer.dart';
import 'package:recipes_sharing/source.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

final recipesFunctions = RecipesApiFunctions();

class ValuesKeeper {
  int itemIndex = 0;
  RecipesData recipeData;
}

final valuesKeeper = ValuesKeeper();

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final _index = ValueNotifier<int>(0);
  final _recipesBloc = RecipesBloc();
  final _pageViewController = PageController();

  final _recipeCategories = [
    'Main',
    'Breakfast',
    'Desserts',
    'Salads',
    'Dinner',
    'Drinks',
    'Vegetarian',
    'Stir Fry',
    "Soups"
  ];

  final _recipeCategoriesImages = [
    'assets/main.svg',
    'assets/coffee.svg',
    'assets/dessert.svg',
    'assets/salad.svg',
    'assets/dinner.svg',
    'assets/drink.svg'
  ];

  @override
  void initState() {
    super.initState();
    _recipesBloc.featuredRecipesEventsSink.add(RecipesEvents.startFetching);
  }

  @override
  void dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final currentTheme = context.watch<Themes>();
    final colors = ThemesData(currentTheme.theme);
    return ChangeNotifierProvider.value(
      value: currentTheme,
      child: WillPopScope(
        onWillPop: () async {
          await auth.changeAuthBlocStream('LoginPage');
          Navigator.pop(context);
          return true;
        },
        child: ValueListenableBuilder<int>(
            valueListenable: _index,
            builder: (context, child, snapshot) {
              return Scaffold(
                backgroundColor: colors.scaffoldColor,
                body: _index.value == 4
                    ? ProfilePage()
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              color: Colors.grey.withOpacity(.2),
                            ),
                            Container(
                              color: Colors.grey.withOpacity(.2),
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.only(left: 20, bottom: 10),
                              child: Text('FEATURED RECIPES',
                                  style: TextStyle(
                                      fontFamily: 'Regular',
                                      fontSize: 16,
                                      color: colors.textColor1)),
                            ),
                            _buildFeaturedRecipes(colors, size, currentTheme),
                            _buildTodayRecipes(colors),
                            _buildRecipesCategories(colors),
                            _buildPopularRecipes(colors)
                          ],
                        ),
                      ),
                bottomNavigationBar: _buildNavigationBar(colors),
              );
            }),
      ),
    );
  }

  _buildFeaturedRecipes(ThemesData colors, Size size, Themes currentTheme) {
    return StreamBuilder<RecipesEvents>(
        stream: _recipesBloc.featuredRecipesEventsStream,
        initialData: RecipesEvents.startFetching,
        builder: (context, eventsSnapshot) {
          return StreamBuilder<List<RecipesData>>(
              stream: _recipesBloc.featuredRecipesStream,
              builder: (context, recipesSnapshot) {
                if (eventsSnapshot.data == RecipesEvents.doneFetching) {
                  return Container(
                    height: 410,
                    width: size.width,
                    color: Colors.grey.withOpacity(.2),
                    padding: EdgeInsets.only(bottom: 10),
                    child: PageView.builder(
                        controller: _pageViewController,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemCount: recipesSnapshot.data.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, itemIndex) {
                          final recipe = recipesSnapshot.data[itemIndex];
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(children: [
                              GestureDetector(
                                onTap: () {
                                  valuesKeeper.recipeData = recipe;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ChangeNotifierProvider.value(
                                                  value: currentTheme,
                                                  child: RecipePage())));
                                },
                                child: VideoPlayer(
                                    colors: colors,
                                    image: recipe.recipeImage,
                                    videoLink: recipe.videoLink,
                                    index: itemIndex,
                                    placeholder:
                                        _buildLoadingContainer(colors, 250),
                                    size: size),
                              ),
                              _buildBottomColumn(
                                  colors: colors,
                                  index: itemIndex,
                                  time: recipe.length,
                                  size: size,
                                  author: recipe.authorName,
                                  authorImage: recipe.authorImage,
                                  title: recipe.title),
                            ]),
                          );
                        }),
                  );
                } else {
                  return _buildLoadingContainer(colors, 410);
                }
              });
        });
  }

  _buildLoadingContainer(ThemesData colors, double height) {
    return Container(
        height: height,
        color: colors.scaffoldColor,
        alignment: Alignment.center,
        child: SizedBox(
          height: 30,
          child: LoadingIndicator(
              color: colors.textColor1, indicatorType: Indicator.lineScale),
        ));
  }

  _buildBottomColumn(
      {ThemesData colors,
      String title,
      int time,
      int index,
      Size size,
      String author,
      authorImage}) {
    return Container(
      color: Colors.white.withOpacity(.0),
      child: Column(
        children: [
          SizedBox(height: 8),
          Container(
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Container(
                  child: Text(title,
                      style: TextStyle(
                          fontFamily: 'Gambetta-Semibold',
                          fontSize: 24,
                          color: colors.textColor1)),
                ),
                SizedBox(height: 10),
                Container(
                  height: 20,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(EvaIcons.clock, color: colors.iconColor),
                      SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text('${time.toStringAsFixed(2)} mins',
                            style: TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 16,
                                color: colors.textColor1)),
                      ),
                      SizedBox(width: 30),
                      Icon(EvaIcons.heart, color: colors.iconColor),
                      SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text('445',
                            style: TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 16,
                                color: colors.textColor1)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                _buildBottomRow(colors, index, author, authorImage)
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildBottomRow(ThemesData colors, int index, String author, authorImage) {
    return Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(authorImage),
                ),
                SizedBox(width: 20),
                SizedBox(
                  height: 50,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(author,
                            style: TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 16,
                                color: colors.textColor1)),
                        Text('Posted 12 mins ago',
                            style: TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: colors.textColor1.withOpacity(.7))),
                      ]),
                ),
              ],
            ),
          ],
        ));
  }

  _buildTodayRecipes(ThemesData colors) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          margin: EdgeInsets.only(top: 25, bottom: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Today\'s Recipes',
                  style: TextStyle(
                      fontFamily: 'Medium',
                      fontSize: 18,
                      color: colors.textColor1)),
              Text('See all',
                  style: TextStyle(
                      fontFamily: 'Medium',
                      fontSize: 16,
                      color: colors.textColor1.withOpacity(.7))),
            ],
          ),
        ),
        Container(
            height: 362,
            child: ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(width: 20);
                },
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                      width: 200,
                      margin: EdgeInsets.only(
                          left: index == 0 ? 20 : 0,
                          right: index == 3 ? 20 : 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 250,
                            child: Stack(
                              children: [
                                Container(
                                  constraints: BoxConstraints.expand(),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    child: Image.network(
                                        index == 0
                                            ? 'https://images.pexels.com/photos/842571/pexels-photo-842571.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
                                            : index == 1
                                                ? 'https://images.pexels.com/photos/416471/pexels-photo-416471.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
                                                : index == 2
                                                    ? 'https://images.pexels.com/photos/604969/pexels-photo-604969.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
                                                    : 'https://images.pexels.com/photos/3807397/pexels-photo-3807397.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                                        fit: BoxFit.fill),
                                  ),
                                ),
                                Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                          color: colors.backgroundColor1
                                              .withOpacity(.5),
                                          borderRadius: BorderRadius.only(
                                              bottomRight:
                                                  Radius.circular(20))),
                                      child: Text(
                                          '${index == 0 ? 12 : index == 1 ? 7 : index == 2 ? 25 : 8} mins',
                                          style: TextStyle(
                                              fontFamily: 'Regular',
                                              fontSize: 14,
                                              color: colors.textColor1)),
                                    ))
                              ],
                            ),
                          ),
                          Container(
                            width: 200,
                            height: 50,
                            margin: EdgeInsets.symmetric(vertical: 5),
                            alignment: Alignment.topLeft,
                            child: Text(
                                index == 0
                                    ? 'Green leafy vegeatble salad'
                                    : index == 1
                                        ? 'Bacon'
                                        : index == 2
                                            ? 'Home-made Tomato Pizza'
                                            : 'Creepes',
                                style: TextStyle(
                                    fontFamily: 'Gambetta-Medium',
                                    fontSize: 20,
                                    color: colors.textColor1)),
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(index == 0
                                    ? 'https://images.pexels.com/photos/2380794/pexels-photo-2380794.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
                                    : index == 1
                                        ? 'https://images.pexels.com/photos/3370021/pexels-photo-3370021.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
                                        : index == 2
                                            ? 'https://i.pinimg.com/236x/b0/f0/4a/b0f04a7fd40fb508181cd813dc8f7896.jpg'
                                            : 'https://i.pinimg.com/236x/99/9e/2c/999e2c2b20766d5da5193a6d780df5fa.jpg'),
                              ),
                              SizedBox(width: 10),
                              SizedBox(
                                height: 50,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                          index == 0
                                              ? 'Anthony Bourdain'
                                              : index == 1
                                                  ? 'Ferran Adrià'
                                                  : index == 2
                                                      ? 'Nicolas Appert'
                                                      : 'James Beard',
                                          style: TextStyle(
                                              fontFamily: 'Regular',
                                              fontSize: 16,
                                              color: colors.textColor1)),
                                      Text('Posted 12 mins ago',
                                          style: TextStyle(
                                              fontFamily: 'Regular',
                                              fontSize: 14,
                                              color: colors.textColor1
                                                  .withOpacity(.7))),
                                    ]),
                              ),
                            ],
                          ),
                        ],
                      ));
                })),
      ],
    );
  }

  _buildRecipesCategories(ThemesData colors) {
    return Column(
      children: [
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          margin: EdgeInsets.only(top: 25, bottom: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Categories',
                  style: TextStyle(
                      fontFamily: 'Medium',
                      fontSize: 18,
                      color: colors.textColor1)),
              Text('See all',
                  style: TextStyle(
                      fontFamily: 'Medium',
                      fontSize: 16,
                      color: colors.textColor1.withOpacity(.7))),
            ],
          ),
        ),
        Container(
          height: 100,
          margin: EdgeInsets.only(top: 10, bottom: 20),
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              separatorBuilder: (context, index) {
                return SizedBox(width: 20);
              },
              itemBuilder: (context, index) {
                return Container(
                    width: 100,
                    margin: EdgeInsets.only(
                        left: index == 0 ? 20 : 0, right: index == 5 ? 20 : 0),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.5),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: 40,
                            child: SvgPicture.asset(
                                _recipeCategoriesImages[index])),
                        /*   Icon(EvaIcons.npm, size: 25, color: colors.iconColor), */
                        SizedBox(height: 10),
                        Text(_recipeCategories[index],
                            style: TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 16,
                                color: colors.textColor1)),
                      ],
                    ));
              }),
        ),
      ],
    );
  }

  _buildPopularRecipes(ThemesData colors) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          margin: EdgeInsets.only(top: 25, bottom: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Popular Recipes',
                  style: TextStyle(
                      fontFamily: 'Medium',
                      fontSize: 18,
                      color: colors.textColor1)),
              Text('See all',
                  style: TextStyle(
                      fontFamily: 'Medium',
                      fontSize: 16,
                      color: colors.textColor1.withOpacity(.7))),
            ],
          ),
        ),
        SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ListView.separated(
                padding: EdgeInsets.only(top: 10, bottom: 20),
                physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) {
                  return SizedBox(height: 25);
                },
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return _buildPopularRecipesContainer(index, colors);
                }))
      ],
    );
  }

  _buildPopularRecipesContainer(int index, ThemesData colors) {
    /*   final _videosList = [
      'https://v.pinimg.com/videos/720p/54/a2/a7/54a2a76e46edea5b92e86fc852f85eeb.mp4',
      'https://v.pinimg.com/videos/720p/5b/91/d7/5b91d71a388450b727a14219b47f6e2a.mp4',
      'https://v.pinimg.com/videos/720p/0d/38/e6/0d38e620b777d93d1dc29157bf26a171.mp4',
      'https://v.pinimg.com/videos/720p/46/58/2d/46582d7388bc3d4bf58c7f4112cb5569.mp4'
    ]; */
    final _recipeNamesList = [
      'Home-made Bread',
      'French Macarons',
      "Fried rice with Poached eggs",
      'Pepperoni Pizza'
    ];

    final _recipeLengths = [6.0, 8.5, 10.0, 5.5];

    final _recipePicsList = [
      'https://images.pexels.com/photos/1775043/pexels-photo-1775043.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      'https://images.pexels.com/photos/239581/pexels-photo-239581.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      'https://images.pexels.com/photos/1410236/pexels-photo-1410236.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      'https://images.pexels.com/photos/1049626/pexels-photo-1049626.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
    ];

    final _recipeCooksPicsList = [
      'https://images.pexels.com/photos/3671083/pexels-photo-3671083.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      'https://images.pexels.com/photos/1858175/pexels-photo-1858175.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      'https://images.pexels.com/photos/3290236/pexels-photo-3290236.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      'https://images.pexels.com/photos/3142449/pexels-photo-3142449.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
    ];
    final _recipeCookNamesList = ['Olivia', 'Clarke', 'Emma', 'Ava'];
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              height: 260,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.5),
                  image: DecorationImage(
                      image: NetworkImage(_recipePicsList[index]),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Stack(
                children: [
                  Center(
                      child: Icon(EvaIcons.playCircle,
                          color: colors.iconColor, size: 60)),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            color: colors.backgroundColor1.withOpacity(.5),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20))),
                        child: Text('${_recipeLengths[index]} mins',
                            style: TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: colors.textColor1)),
                      ))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.centerLeft,
              child: Text(_recipeNamesList[index],
                  style: TextStyle(
                      fontFamily: 'Gambetta-Medium',
                      fontSize: 20,
                      color: colors.textColor1)),
            ),
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(_recipeCooksPicsList[index]),
                ),
                SizedBox(width: 10),
                SizedBox(
                  height: 50,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(_recipeCookNamesList[index],
                            style: TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 16,
                                color: colors.textColor1)),
                        Text('Posted 12 mins ago',
                            style: TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: colors.textColor1.withOpacity(.7))),
                      ]),
                ),
              ],
            ),
          ],
        ));
  }

  _buildNavigationBar(ThemesData colors) {
    return ValueListenableBuilder(
        valueListenable: _index,
        builder: (context, child, snapshot) {
          return Container(
              height: 60,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          width: 2, color: Colors.grey.withOpacity(.5)))),
              child: Row(children: [
                _buildBottomNavBarIcon(
                    0,
                    colors,
                    _index.value == 0 ? EvaIcons.home : EvaIcons.homeOutline,
                    _index.value == 0 ? 'Home' : 'home'),
                _buildBottomNavBarIcon(
                    1,
                    colors,
                    _index.value == 1
                        ? EvaIcons.search
                        : EvaIcons.searchOutline,
                    _index.value == 1 ? 'Search' : 'search'),
                _buildBottomNavBarIcon(
                    2,
                    colors,
                    _index.value == 2
                        ? EvaIcons.plusCircle
                        : EvaIcons.plusCircleOutline,
                    _index.value == 2 ? "Create" : 'create'),
                _buildBottomNavBarIcon(
                    3,
                    colors,
                    _index.value == 3
                        ? EvaIcons.shoppingBag
                        : EvaIcons.shoppingBagOutline,
                    _index.value == 3 ? 'Shopping' : 'shopping'),
                _buildBottomNavBarIcon(
                    4,
                    colors,
                    _index.value == 4
                        ? EvaIcons.person
                        : EvaIcons.personOutline,
                    _index.value == 4 ? 'Profile' : 'profile'),
              ]));
        });
  }

  _buildBottomNavBarIcon(
      int index, ThemesData colors, IconData icon, String label) {
    return ValueListenableBuilder(
        valueListenable: _index,
        builder: (context, child, snapshot) {
          return Expanded(
              child: GestureDetector(
            onTap: () async {
              _index.value = index;
              if (index == 0) {
                print('adding ');
                _recipesBloc.featuredRecipesEventsSink
                    .add(RecipesEvents.startFetching);
              }
            },
            child: Container(
              color: Colors.white.withOpacity(.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(icon,
                      color: _index.value == index
                          ? colors.iconColor
                          : colors.iconColor.withOpacity(.50)),
                  Text(label,
                      style: TextStyle(
                          fontFamily:
                              _index.value == index ? 'Medium' : 'Regular',
                          fontSize: 14,
                          color: _index.value == index
                              ? colors.textColor1
                              : colors.textColor1.withOpacity(.50)))
                ],
              ),
            ),
          ));
        });
  }
}
