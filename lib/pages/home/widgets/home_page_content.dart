import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hub_finder/pages/home/home_controller.dart';
import 'package:hub_finder/pages/repo/repo_page.dart';
import 'package:hub_finder/pages/user/user_page.dart';
import 'package:hub_finder/shared/core/app_ad.dart';
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            controller: widget.scrollController,
            shrinkWrap: true,
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
              SizedBox(height: 8),
              Observer(builder: (context) {
                if (widget.controller.myRewardedAd == null) {
                  return Container();
                }

                return ElevatedButton(
                  onPressed: () {
                    widget.controller.myRewardedAd!.show(
                      onUserEarnedReward: (ad, item) async {
                        await widget.controller.onUserEarnedReward(ad, item);
                        this.setState(() {});
                      },
                    );
                  },
                  child: Text('Remove ads'),
                );
              }),
              SizedBox(height: 32),
              Observer(builder: (context) {
                if (widget.controller.trendingUsers.isEmpty) {
                  return Container();
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Treding users',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 16),
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
                            });
                      },
                    ),
                  ],
                );
              }),
              SizedBox(height: 16),
              Observer(builder: (context) {
                if (widget.controller.trendingRepositories.isEmpty) {
                  return Container();
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Treding repositories',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 16),
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

                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: RepoListTileWidget(
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
                          ),
                        );
                      },
                      separatorBuilder: (_, __) {
                        return SizedBox(height: 5);
                      },
                    )
                  ],
                );
              }),
              SizedBox(height: 16),
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
                    SizedBox(height: 16),
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
                        return SizedBox(height: 5);
                      },
                    )
                  ],
                );
              }),
            ],
          ),
        ),
        if (AppAd.showAd)
          Observer(builder: (context) {
            return Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: widget.controller.showBannerAd ? 50 : 0,
              child: widget.controller.showBannerAd
                  ? widget.controller.adWidget
                  : null,
            );
          })
      ],
    );
  }
}
