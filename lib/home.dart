import 'package:blog_club/article.dart';
import 'package:blog_club/data.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'carusel/carousel_slider.dart';
import 'gen/assets.gen.dart';
import 'main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<StoryData> dataStory = AppDatabase.stories;
    return MainItem(dataStory: dataStory);
  }
}

class MainItem extends StatelessWidget {
  const MainItem({
    super.key,
    required this.dataStory,
  });

  final List<StoryData> dataStory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // scafold  ==  ریشه ی  تمام  ویجت  ها
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 16, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hi , im jorjina!',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Assets.img.icons.notification
                          .image(width: 32, height: 32),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 8, 0, 0),
                  child: Text(
                    'Explore today’s',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 15, 0, 15),
                  child: _StoryList(dataStory: dataStory),
                ),
                _CategoryList(),
                Padding(
                  padding: const EdgeInsets.only(left: 32, right: 16, top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Latest News',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('More'),
                      )
                    ],
                  ),
                ),
                const PostList(),
                const SizedBox(
                  height: 65,
                ),
              ]),
        ),
      ),
    );
  }
}

class _StoryList extends StatelessWidget {
  const _StoryList({
    required this.dataStory,
  });

  final List<StoryData> dataStory;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: dataStory.length,
          itemBuilder: (BuildContext context, int index) {
            final StoryData dataStory = AppDatabase.stories[index];
            return _StoryWidgets(storyData: dataStory);
          },
        ));
  }
}

class _StoryWidgets extends StatelessWidget {
  const _StoryWidgets({
    required this.storyData,
  });

  final StoryData storyData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 2, 8, 0),
      child: Column(children: [
        SingleChildScrollView(
          child: Stack(
            children: [
              storyData.isViewed ? _profileViewwed() : _profileNormal(),
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  'assets/img/icons/${storyData.iconFileName}',
                  width: 20,
                  height: 20,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(storyData.name),
      ]),
    );
  }

  Widget _profileNormal() {
    return Container(
      height: 68,
      width: 68,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(begin: Alignment.topLeft, colors: [
            Color(0xff376AED),
            Color(0xff49B0E2),
            Color(0xff9CECFB),
          ])),
      child: Padding(
        padding: const EdgeInsets.all(2.5),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(22)),
          child: Padding(
            padding: const EdgeInsets.all(4.5),
            child: _storyImage(),
          ),
        ),
      ),
    );
  }

  Widget _profileViewwed() {
    return SizedBox(
      width: 68,
      height: 68,
      child: DottedBorder(
        borderType: BorderType.RRect,
        color: const Color(0xff7B8BB2),
        strokeWidth: 2,
        radius: const Radius.circular(24),
        // 1-dashWide 2-space
        dashPattern: const [5.5, 2.5],
        padding: const EdgeInsets.all(7),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
          ),
          child: _storyImage(),
        ),
      ),
    );
  }

  Widget _storyImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Image.asset(
        'assets/img/stories/${storyData.imageFileName}',
        fit: BoxFit.cover,
      ),
    );
  }
}

class _CategoryList extends StatelessWidget {
  _CategoryList();
  final List<Category> categories = AppDatabase.categories;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index, int realIndex) {
        final Category category = categories[index];
        return _CategoryItem(
            category: category,
            left: realIndex == 0 ? 32 : 8,
            right: realIndex == categories.length - 1 ? 32 : 8);
      },
      options: CarouselOptions(
        height: 350,
        scrollDirection: Axis.horizontal,
        viewportFraction: 0.8,
        initialPage: 0,
        autoPlay: true,
        disableCenter: true,
        enableInfiniteScroll: false,
        enlargeStrategy: CenterPageEnlargeStrategy.height,
        enlargeCenterPage: true,
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  const _CategoryItem({
    required this.category,
    required this.left,
    required this.right,
  });

  final Category category;
  final double left;
  final double right;

  @override
  Widget build(BuildContext context) {
    return Container(
      //  width: 300,
      margin: EdgeInsets.only(left: left, right: right),
      child: Stack(
        children: [
          Positioned.fill(
            top: 90,
            right: 65,
            left: 65,
            bottom: 30,
            child: Container(
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(blurRadius: 32, color: Color(0xff0D253C))
              ]),
            ),
          ),
          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 30),
              foregroundDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  gradient: const LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                      colors: [Color(0xff0D253C), Colors.transparent])),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Image.asset(
                    fit: BoxFit.cover,
                    width: 300,
                    'assets/img/posts/large/${category.imageFileName}'),
              ),
            ),
          ),
          Positioned(
              bottom: 60,
              left: 32,
              child: Text(
                category.title,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .apply(color: Colors.white),
              )),
        ],
      ),
    );
  }
}

class PostList extends StatelessWidget {
  const PostList({super.key});
  @override
  Widget build(BuildContext context) {
    final List<PostData> posts = AppDatabase.posts;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 32, right: 29),
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: posts.length,
              // سایز هر آیتم
              itemExtent: 141,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                final PostData post = posts[index];
                return _PostItem(post: post);
              }),
        )
      ],
    );
  }
}

class _PostItem extends StatelessWidget {
  const _PostItem({
    required this.post,
  });

  final PostData post;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return InkWell(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const Article())),
      child: Container(
        margin: const EdgeInsets.only(top: 8, bottom: 8),
        decoration: BoxDecoration(
          color: themeData.colorScheme.surface,
          boxShadow: [
            BoxShadow(
                color: themeData.colorScheme.onBackground.withOpacity(0.2),
                blurRadius: 10)
          ],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/img/posts/small/${post.imageFileName}',
                fit: BoxFit.cover,
              )),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.caption,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff376AED),
                        fontFamily: MyApp.defaultFontFamily,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    post.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.hand_thumbsup,
                        size: 20,
                        color: Theme.of(context).textTheme.titleSmall!.color,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        post.likes,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontSize: 12),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Icon(
                        CupertinoIcons.clock,
                        size: 20,
                        color: Theme.of(context).textTheme.titleSmall!.color,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Expanded(
                        child: Text(
                          post.time,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontSize: 12),
                        ),
                      ),
                      Icon(
                        post.isBookmarked
                            ? CupertinoIcons.bookmark_fill
                            : CupertinoIcons.bookmark,
                        size: 20,
                        color: Theme.of(context).textTheme.titleSmall!.color,
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}

class _BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
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
                children: const [
                  _BottomNavigationItem(
                      iconFileName: 'Home.png',
                      title: 'Home',
                      isSelected: true),
                  _BottomNavigationItem(
                      iconFileName: 'Articles.png',
                      title: 'Articles',
                      isSelected: false),
                  SizedBox(width: 6),
                  _BottomNavigationItem(
                      iconFileName: 'Search.png',
                      title: 'Search',
                      isSelected: false),
                  _BottomNavigationItem(
                      iconFileName: 'Menu.png',
                      title: 'Menu',
                      isSelected: true),
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
    );
  }
}

class _BottomNavigationItem extends StatelessWidget {
  final String iconFileName;
  final String title;
  final bool isSelected;

  const _BottomNavigationItem(
      {required this.iconFileName,
      required this.title,
      required this.isSelected});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/img/icons/$iconFileName'),
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
