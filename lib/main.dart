import 'package:blog_club/article.dart';
import 'package:blog_club/home.dart';
import 'package:blog_club/profile.dart';
import 'package:blog_club/gen/fonts.gen.dart';
import 'package:blog_club/splash.dart';
import 'package:flutter/material.dart';
import 'gen/assets.gen.dart';

const int homeIndex = 0;
const int articleIndex = 1;
const int searchIndex = 2;
const int profileIndex = 3;
const double bottmNavigationHeight = 70;
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String defaultFontFamily = FontFamily.avenir;
  @override
  Widget build(BuildContext context) {
    const Color primaryTextColor = Color(0xff0D253C);
    const Color secendaryTextColor = Color(0xff2D4379);
    const Color primaryColor = Color(0xff376AED);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: const ScrollBehavior(),
      title: 'blog-club',
      theme: ThemeData(
          appBarTheme: AppBarTheme(
            titleSpacing: 32,
            elevation: 0,
            backgroundColor: Colors.white.withOpacity(0),
            foregroundColor: secendaryTextColor,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(primaryColor),
                minimumSize: MaterialStateProperty.all(const Size(88, 60)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)))),
          ),
          colorScheme: const ColorScheme.light(
            primary: primaryColor,
            onPrimary: Colors.white,
            background: Color(0xffF8FAFF),
            onBackground: primaryTextColor,
            surface: Colors.white,
            onSurface: primaryTextColor,
          ),
          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                  textStyle: MaterialStateProperty.all(const TextStyle(
                      fontFamily: defaultFontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: primaryColor)))),
          textTheme: const TextTheme(
              displayMedium: TextStyle(
                  fontFamily: defaultFontFamily,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: primaryTextColor),
              displaySmall: TextStyle(
                  fontFamily: defaultFontFamily,
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                  color: secendaryTextColor),
              bodySmall: TextStyle(
                  fontFamily: defaultFontFamily,
                  fontWeight: FontWeight.w700,
                  fontSize: 10,
                  color: Color(0xff7B8BB2)),
              titleLarge: TextStyle(
                  fontFamily: defaultFontFamily,
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  color: primaryTextColor),
              titleSmall: TextStyle(
                  fontFamily: defaultFontFamily,
                  fontWeight: FontWeight.w200,
                  fontSize: 18,
                  color: secendaryTextColor),
              bodyMedium: TextStyle(
                  fontFamily: defaultFontFamily,
                  color: secendaryTextColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w400),
              titleMedium: TextStyle(
                  fontFamily: defaultFontFamily,
                  color: primaryTextColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
              bodyLarge: TextStyle(
                  fontFamily: defaultFontFamily,
                  color: primaryTextColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w700)),
          snackBarTheme: const SnackBarThemeData(
            backgroundColor: secendaryTextColor,
            behavior: SnackBarBehavior.fixed,
            elevation: 1,
          )),
      home: const SplashScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = homeIndex;

  final GlobalKey<NavigatorState> _homeKey = GlobalKey();
  final GlobalKey<NavigatorState> _articleKey = GlobalKey();
  final GlobalKey<NavigatorState> _searchKey = GlobalKey();
  final GlobalKey<NavigatorState> _profileKey = GlobalKey();

  final List<int> _history = [];

  late final Map<int, GlobalKey<NavigatorState>> pageStates = {
    homeIndex: _homeKey,
    articleIndex: _articleKey,
    searchIndex: _searchKey,
    profileIndex: _profileKey
  };

  Future<bool> _onWillpop() async {
    final NavigatorState currentStateSelectedTab =
        pageStates[selectedIndex]!.currentState!;
    if (currentStateSelectedTab.canPop()) {
      _homeKey.currentState!.pop();
      return false;
    } else if (_history.isNotEmpty) {
      selectedIndex = _history.last;
      _history.removeLast();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillpop,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              bottom: bottmNavigationHeight,
              child: IndexedStack(
                index: selectedIndex,
                children: [
                  // هر کدوم از کلاس هارو یک استک داده ایم
                  Navigator(
                    key: _homeKey,
                    onGenerateRoute: (settings) => MaterialPageRoute(
                        builder: (context) => const HomeScreen()),
                  ),
                  Navigator(
                    key: _articleKey,
                    onGenerateRoute: (settings) => MaterialPageRoute(
                        builder: (context) => const Article()),
                  ),
                  Navigator(
                    key: _searchKey,
                    onGenerateRoute: (settings) => MaterialPageRoute(
                        builder: (context) => const SearchScreen()),
                  ),
                  Navigator(
                    key: _profileKey,
                    onGenerateRoute: (settings) => MaterialPageRoute(
                        builder: (context) => const ProfileScreen()),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _BottomNavigation(
                isActiveIndex: selectedIndex,
                onTap: (int index) {
                  _history.remove(selectedIndex);
                  _history.add(selectedIndex);
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'search screen',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'menu screen',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}

class _BottomNavigation extends StatelessWidget {
  const _BottomNavigation({required this.onTap, required this.isActiveIndex});
  final void Function(int index) onTap;
  final int isActiveIndex;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95,
      child: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 70,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(color: const Color(0xff775E62).withOpacity(0.3))
                ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _BottomNavigationItem(
                        iconFileName: 'Home.png',
                        title: 'Home',
                        onTap: () {
                          onTap(homeIndex);
                        },
                        isActive: isActiveIndex == homeIndex),
                    _BottomNavigationItem(
                        iconFileName: 'Articles.png',
                        title: 'Articles',
                        onTap: () {
                          onTap(articleIndex);
                        },
                        isActive: isActiveIndex == articleIndex),
                    const Expanded(child: SizedBox()),
                    _BottomNavigationItem(
                        iconFileName: 'Search.png',
                        title: 'Search',
                        onTap: () {
                          onTap(searchIndex);
                        },
                        isActive: isActiveIndex == searchIndex),
                    _BottomNavigationItem(
                        iconFileName: 'Menu.png',
                        title: 'Menu',
                        onTap: () {
                          onTap(profileIndex);
                        },
                        isActive: isActiveIndex == profileIndex),
                  ],
                ),
              )),
          Center(
            child: Container(
              height: 90,
              alignment: Alignment.topCenter,
              child: Container(
                  height: 65,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.white, width: 5, strokeAlign: 0),
                      color: const Color(0xff376AED),
                      shape: BoxShape.circle),
                  child: Assets.img.icons.plus.image()),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNavigationItem extends StatelessWidget {
  final String iconFileName;
  final String title;
  final bool isActive;
  final Function() onTap;

  const _BottomNavigationItem(
      {required this.iconFileName,
      required this.title,
      required this.isActive,
      required this.onTap});
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img/icons/$iconFileName',
              color: isActive
                  ? themeData.colorScheme.primary
                  : themeData.textTheme.bodySmall!.color,
            ),
            Text(
              title,
              style: isActive
                  ? themeData.textTheme.bodySmall!
                      .apply(color: themeData.colorScheme.primary)
                  : themeData.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
