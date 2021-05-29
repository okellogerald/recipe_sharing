import 'package:recipes_sharing/UI/BeforeRegistration/registrationScreen.dart';
import 'package:recipes_sharing/source.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage>
    with SingleTickerProviderStateMixin {
  int _index = 0;
  final _pageController = PageController();
  final _imageList = [
    'assets/first-image-1.png',
    'assets/first-image-2.png',
    'assets/first-image-3.png',
    'assets/first-image-4.png',
  ];

  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1000))
          ..forward();
    _animation = Tween<double>(begin: 0.2, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn))
      ..addListener(() {
        //listeners are added so to hear when a certain value between the tween begin and end is reached upon which a
        // specific action is done
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = context.watch<Themes>();
    final colors = ThemesData(currentTheme.theme);
    return Scaffold(
      body: Container(
          color: colors.backgroundColor1,
          child: Column(
            children: [
              _buildPageView(currentTheme.toggleThemes, colors, currentTheme),
              _buildPageIndicator(colors, currentTheme)
            ],
          )),
    );
  }

  _buildPageView(
      Function toggleThemes, ThemesData colors, Themes currentTheme) {
    return Expanded(
        flex: 9,
        child: PageView.builder(
            controller: _pageController,
            itemCount: 3,
            
            onPageChanged: (value) {
             /*  if (value == 2) {
                _pageController.animateToPage(0,
                    duration: Duration(milliseconds: 400),
                    curve: Curves.bounceIn);
              } */
              setState(() {
                _index = value;
                _animationController..reset();
                _animationController..forward();
              });
            },
            itemBuilder: (context, snapshot) {
              return Column(
                children: [
                  Expanded(
                      flex: 7,
                      child: AnimatedBuilder(
                          animation: _animation,
                          builder: (context, snapshot) {
                            return Opacity(
                              opacity: _animation.value,
                              child: Image.asset(_imageList[_index],
                                  fit: BoxFit.contain),
                            );
                          })),
                  Expanded(
                    flex: 2,
                    child: AnimatedBuilder(
                        animation: _animation,
                        builder: (context, snapshot) {
                          return Opacity(
                            opacity: _animation.value,
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                  _index == 0
                                      ? 'Step-by-step recipe cooking videos'
                                      : _index == 1
                                          ? 'Discover tasty new recipes everyday'
                                          : _index == 2
                                              ? 'Publish your own recipes'
                                              : '',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Gambetta-Semibold',
                                      fontSize: 32,
                                      color: colors.textColor1)),
                            ),
                          );
                        }),
                  ),
                ],
              );
            }));
  }

  _buildPageIndicator(ThemesData colors, Themes currentTheme) {
    return Expanded(
      flex: 1,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                height: 10,
                width: 70,
                child: ListView.builder(
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index == _index
                              ? colors.iconColor
                              : colors.iconColor.withOpacity(.7)),
                      width: index == _index ? 10 : 8,
                      height: index == _index ? 10 : 8,
                    );
                  },
                )),
            TextButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider.value(
                            value: currentTheme, child: RegistrationScreen()))),
                style: TextButton.styleFrom(
                    backgroundColor: colors.buttonColor2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5)),
                child: Text('Skip',
                    style: TextStyle(
                        fontFamily: 'Regular',
                        color: colors.textColor1,
                        fontSize: 16)))
          ],
        ),
      ),
    );
  }
}
