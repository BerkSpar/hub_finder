import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hub_finder/pages/home/home_controller.dart';
import 'package:hub_finder/pages/home/widgets/circular_streak.dart';
import 'package:hub_finder/pages/repo/repo_page.dart';
import 'package:hub_finder/pages/user/user_page.dart';
import 'package:hub_finder/shared/core/app_colors.dart';
import 'package:hub_finder/shared/widgets/listtile_widget.dart';
import 'package:hub_finder/shared/widgets/repo_listtile_widget.dart';
import 'package:hub_finder/shared/widgets/search_widget.dart';
import 'package:hub_finder/shared/widgets/user_card.dart';

class HomePageContent extends StatefulWidget {
  final ScrollController scrollController;
  final HomeController controller;

  const HomePageContent({
    super.key,
    required this.scrollController,
    required this.controller,
  });

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  List<Widget> circularStreaks = [];

  @override
  void initState() {
    super.initState();
    getCircularStreak();
  }

  void getCircularStreak() async {
    final today = DateTime.now();

    final days = List.generate(7, (index) {
      return today.add(Duration(days: index - today.weekday + 1));
    });

    for (final day in days) {
      final isActive = await widget.controller.hasHistoryPoint(day);

      circularStreaks.add(
        CircularStreak(
          date: day,
          isActive: isActive,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            controller: widget.scrollController,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
            children: [
              Text(
                'Find users in GitHub',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24),
              SearchWidget(
                onTapSearch: () async {
                  if (widget.controller.searchController.text.isEmpty) {
                    return;
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          UserPage(widget.controller.searchController.text),
                    ),
                  );

                  FirebaseAnalytics.instance.logSearch(
                    searchTerm: widget.controller.searchController.text,
                  );
                },
                searchController: widget.controller.searchController,
                hintText: 'Type the user name',
              ),
              SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Week streak',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: circularStreaks,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Icon(
                              Icons.whatshot,
                              color: Color(0xFFFB7338),
                            ),
                            const SizedBox(width: 8),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'My current streak is ',
                                  ),
                                  TextSpan(
                                    text: "${widget.controller.streak}",
                                    style: TextStyle(
                                      color: Color(0xFFFB7338),
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        ' day${widget.controller.streak != 1 ? 's' : ''}',
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Observer(builder: (context) {
                if (widget.controller.trendingUsers.isEmpty) {
                  return Container();
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Trending users',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 8),
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 16 / 12,
                      ),
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: widget.controller.trendingUsers.length >= 4
                          ? 4
                          : widget.controller.trendingUsers.length,
                      itemBuilder: (_, index) {
                        final user = widget.controller.trendingUsers[index];

                        return UserCard(
                          user: user,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserPage(user.login),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                );
              }),
              // SizedBox(height: 24),
              Observer(builder: (context) {
                if (widget.controller.trendingRepositories.isEmpty) {
                  return Container();
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Trending repositories',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 8),
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount:
                          widget.controller.trendingRepositories.length >= 5
                              ? 5
                              : widget.controller.trendingRepositories.length,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        final repository =
                            widget.controller.trendingRepositories[index];

                        return RepoListTileWidget(
                          title: repository.name,
                          subtitle: repository.language,
                          color: language_colors[repository.language],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    RepoPage(repository.fullName),
                              ),
                            );
                          },
                        );
                      },
                      separatorBuilder: (_, __) {
                        return SizedBox(height: 16);
                      },
                    )
                  ],
                );
              }),
              //SizedBox(height: 16),
              Observer(builder: (context) {
                if (widget.controller.cachedUsers.isEmpty) {
                  return Container();
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Searched users',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 8),
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: widget.controller.cachedUsers.length,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        final cachedUser = widget.controller.cachedUsers[index];

                        return ListTileWidget(
                          imageUrl: cachedUser.imageUrl,
                          title: cachedUser.title,
                          subtitle: cachedUser.subtitle,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    UserPage(cachedUser.username),
                              ),
                            );
                          },
                        );
                      },
                      separatorBuilder: (_, __) {
                        return SizedBox(height: 16);
                      },
                    )
                  ],
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
