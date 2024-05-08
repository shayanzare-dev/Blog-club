import 'package:blog_club/data.dart';
import 'package:blog_club/gen/assets.gen.dart';
import 'package:blog_club/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  final items = AppDatabase.indicatorItems;

  int page = 0;
  @override
  void initState() {
    // همه این کد ها فقط یک بار اجرا میشه چون درون تابع  اینیتاستیت  هست
    _pageController.addListener(() {
      if (_pageController.page!.round() != page) {
        setState(() {
          page = _pageController.page!.round();
          debugPrint('selected onBoarding page: => $page');
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.colorScheme.background,
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 8),
              child: Assets.img.background.onboarding.image(),
            ),
          ),
          Container(
            width: double.infinity,
            height: 240,
            padding:
                const EdgeInsets.only(left: 32, right: 32, top: 32, bottom: 16),
            decoration: BoxDecoration(
                color: themeData.colorScheme.surface,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black45.withOpacity(0.1), blurRadius: 60),
                ]),
            child: Column(children: [
              Expanded(
                  child: PageView.builder(
                itemCount: items.length,
                controller: _pageController,
                itemBuilder: (BuildContext context, int index) {
                  final Indicator item = items[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.title, style: themeData.textTheme.titleLarge),
                      const SizedBox(
                        height: 18,
                      ),
                      Expanded(
                        child: Text(item.subTitle,
                            style: themeData.textTheme.titleMedium!
                                .apply(color: const Color(0xff2D4379))),
                      ),
                    ],
                  );
                },
              )),
              //  indicator and elevation button
              Container(
                height: 75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SmoothPageIndicator(
                      controller: _pageController,
                      count: items.length,
                      effect: ExpandingDotsEffect(
                          dotWidth: 8,
                          dotHeight: 8,
                          activeDotColor: themeData.colorScheme.primary,
                          dotColor: const Color(0xffDEE7FF)),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _pageController.animateToPage(page - 1,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.decelerate);
                        },
                        child: const Icon(
                          CupertinoIcons.arrow_left,
                          color: Colors.white,
                        )),
                    ElevatedButton(
                        onPressed: () {
                          if (page == items.length - 1) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const MainScreen()));
                          } else {
                            _pageController.animateToPage(page + 1,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.decelerate);
                          }
                        },
                        child: Icon(
                          page == items.length - 1
                              ? CupertinoIcons.check_mark
                              : CupertinoIcons.arrow_right,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
            ]),
          )
        ]),
      ),
    );
  }
}
