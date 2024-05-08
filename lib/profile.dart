import 'package:blog_club/article.dart';
import 'package:blog_club/gen/assets.gen.dart';
import 'package:blog_club/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: themeData.colorScheme.background.withOpacity(0),
          title: const Text('Profile'),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.ellipsis,
                color: themeData.colorScheme.onBackground,
              ),
            ),
            const SizedBox(width: 16)
          ],
        ),
        // start body
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(32),
                      margin: const EdgeInsets.fromLTRB(32, 32, 32, 64),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: themeData.colorScheme.surface,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 15,
                                color: themeData.colorScheme.onBackground
                                    .withOpacity(0.1))
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: themeData.colorScheme.surface,
                                      borderRadius: BorderRadius.circular(28),
                                      border: Border.all(
                                        color: Colors.blue,
                                        width: 3.2,
                                      )),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(22),
                                    child: Assets.img.stories.story5
                                        .image(width: 84, height: 84),
                                  )),
                              const SizedBox(
                                width: 32,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    '@joviedan',
                                    style: themeData.textTheme.displaySmall,
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    'Jovi Daniel',
                                    style: themeData.textTheme.bodyLarge,
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Text('UX Designer',
                                      style: themeData.textTheme.displaySmall!
                                          .copyWith(
                                              color:
                                                  themeData.colorScheme.primary,
                                              fontWeight: FontWeight.w300))
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'About me',
                            style: themeData.textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Madison Blackstone is a director of user experience design, with experience managing global teams.',
                            style: themeData.textTheme.titleMedium,
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                    Positioned(
                        bottom: 6,
                        left: 96,
                        right: 96,
                        child: Container(
                          height: 34,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              blurRadius: 20,
                              color: themeData.colorScheme.onBackground
                                  .withOpacity(0.4),
                            )
                          ]),
                        )),
                    Positioned(
                        bottom: 32,
                        left: 64,
                        right: 64,
                        child: Container(
                          decoration: BoxDecoration(
                              color: themeData.colorScheme.primary,
                              borderRadius: BorderRadius.circular(12)),
                          height: 68,
                          child: Row(
                            children: [
                              Info(
                                themeData: themeData,
                                active: true,
                                text1: '52',
                                text2: 'Post',
                              ),
                              Info(
                                themeData: themeData,
                                active: false,
                                text1: '250',
                                text2: 'Following',
                              ),
                              Info(
                                themeData: themeData,
                                active: false,
                                text1: '4.6K',
                                text2: 'Followers',
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
                _MyPost(themeData: themeData),
              ],
            ),
          ),
        ));
  }
}

class _MyPost extends StatelessWidget {
  const _MyPost({
    required this.themeData,
  });

  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 32),
          decoration: BoxDecoration(
              color: themeData.colorScheme.surface,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(28), topRight: Radius.circular(28))),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 16, 16, 16),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      'My Posts',
                      style: themeData.textTheme.displayMedium,
                    )),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          CupertinoIcons.square_grid_2x2,
                          color: themeData.colorScheme.primary,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          CupertinoIcons.ellipsis_vertical,
                          color: themeData.colorScheme.primary,
                        )),
                  ],
                ),
              ),
              const PostList(),
            ],
          ),
        ),
        const OverlayBottom(),
      ],
    );
  }
}

class Info extends StatelessWidget {
  Info({
    super.key,
    required this.active,
    required this.themeData,
    required this.text1,
    required this.text2,
  });
  bool active;
  final ThemeData themeData;
  final String text1;
  final String text2;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
            color: active
                ? const Color(0xff2151CD)
                : themeData.colorScheme.primary,
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text1,
              style: themeData.textTheme.titleLarge!
                  .apply(color: themeData.colorScheme.onPrimary),
            ),
            Text(
              text2,
              style: themeData.textTheme.displaySmall!
                  .apply(color: themeData.colorScheme.onPrimary),
            ),
          ],
        ),
      ),
    );
  }
}
