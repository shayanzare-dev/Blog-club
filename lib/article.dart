import 'package:blog_club/gen/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Article extends StatefulWidget {
  const Article({super.key});

  @override
  State<Article> createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  int likes = 0;
  void addLikes() {
    setState(() {
      likes = likes + 1;
    });
  }

  void showSnackBar({required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 500),
      content: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    const EdgeInsetsGeometry topPadding = EdgeInsets.fromLTRB(32, 16, 32, 16);
    return Scaffold(
      // چون ک خود اسکفلد بر اساس اصل متریال ساخته شده فیلدی مثل فلتوتینگ اکشن باتن هم داره
      floatingActionButton: Container(
        width: 111,
        height: 48,
        decoration: BoxDecoration(
            color: themeData.colorScheme.primary,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: themeData.colorScheme.primary.withOpacity(0.8),
                blurRadius: 18,
              )
            ]),
        child: InkWell(
          onTap: () {
            addLikes();
            showSnackBar(message: 'like article');
          },
          onDoubleTap: () {
            addLikes();
            showSnackBar(message: 'like article');
          },
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              CupertinoIcons.hand_thumbsup,
              color: themeData.colorScheme.onPrimary,
            ),
            const SizedBox(width: 8),
            Text(
              likes == 0 ? '' : '$likes',
              style: TextStyle(
                  color: themeData.colorScheme.onPrimary, fontSize: 16),
            ),
          ]),
        ),
      ),
      backgroundColor: themeData.colorScheme.surface,
      body: Stack(children: [
        Positioned.fill(
            child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                Color(0xffFFFFFF),
                Color(0xffF4F7FF),
              ])),
        )),
        CustomScrollView(slivers: [
          SliverAppBar(
            // pinned: true,
            // floating: true,
            title: const Text(
              'article',
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    CupertinoIcons.ellipsis,
                    size: 32,
                  )),
              const SizedBox(width: 32),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed([
              Padding(
                  padding: topPadding,
                  child: Text(
                    'Four Things Every Woman Needs To Know',
                    style: themeData.textTheme.titleLarge,
                  )),
              Padding(
                padding: topPadding,
                child: Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Assets.img.stories.story10
                            .image(width: 48, height: 48, fit: BoxFit.cover)),
                    const SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Richard Gervain',
                            style: themeData.textTheme.bodyMedium!
                                .copyWith(fontSize: 14),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            '2m ago',
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          showSnackBar(message: 'share click');
                        },
                        icon: Icon(CupertinoIcons.paperplane,
                            color: themeData.colorScheme.primary)),
                    const SizedBox(
                      width: 16,
                    ),
                    IconButton(
                        onPressed: () {
                          showSnackBar(message: 'bookmark click');
                        },
                        icon: Icon(CupertinoIcons.bookmark,
                            color: themeData.colorScheme.primary)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28)),
                  child: Assets.img.background.singlePost.image(
                      height: 220, width: double.maxFinite, fit: BoxFit.cover)),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
                child: Text(
                  'A man’s sexuality is never your mind responsibility.',
                  style: themeData.textTheme.displayMedium,
                ),
              ),
              Padding(
                padding: topPadding,
                child: Text(
                  '''This one got an incredible amount of backlash the last time I said it, so I’m going to say it again: a man’s sexuality is never, ever your responsibility, under any circumstances. Whether it’s the fifth date or your twentieth year of marriage, the correct determining factor for whether or not you have sex with your partner isn’t whether you ought to “take care of him” or “put out” because it’s been a while or he’s really horny — the correct determining factor for whether or not you have sex is whether or not you want to have sex.
        This one got an incredible amount of backlash the last time I said it, so I’m going to say it again: a man’s sexuality is never, ever your responsibility, under any circumstances. Whether it’s the fifth date or your twentieth year of marriage, the correct determining factor for whether or not you have sex with your partner isn’t whether you ought to “take care of him” or “put out” because it’s been a while or he’s really horny — the correct determining factor for whether or not you have sex is whether or not you want to have sex.
        This one got an incredible amount of backlash the last time I said it, so I’m going to say it again: a man’s sexuality is never, ever your responsibility, under any circumstances. Whether it’s the fifth date or your twentieth year of marriage, the correct determining factor for whether or not you have sex with your partner isn’t whether you ought to “take care of him” or “put out” because it’s been a while or he’s really horny — the correct determining factor for whether or not you have sex is whether or not you want to have sex.
               ''',
                  style: themeData.textTheme.displaySmall,
                ),
              ),
            ]),
          ),
        ]),
        const OverlayBottom()
      ]),
    );
  }
}

class OverlayBottom extends StatelessWidget {
  const OverlayBottom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 116,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
              const Color(0xffF9FAFF),
              const Color(0xffF9FAFF).withOpacity(0),
            ])),
      ),
    );
  }
}
