import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hub_finder/pages/home/home_controller.dart';
import 'package:hub_finder/pages/user/user_page.dart';
import 'package:hub_finder/shared/core/app_ad.dart';
import 'package:hub_finder/shared/widgets/listtile_widget.dart';
import 'package:hub_finder/shared/widgets/search_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('asset/images/logo_light.png', height: 32),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(24, 48, 24, 0),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            UserPage(controller.searchController.text),
                      ),
                    );
                  },
                  searchController: controller.searchController,
                  hintText: 'Type the user name',
                ),
                SizedBox(height: 8),
                Observer(builder: (context) {
                  if (controller.myRewardedAd == null) {
                    return Container();
                  }

                  return ElevatedButton(
                    onPressed: () {
                      controller.myRewardedAd!.show(
                        onUserEarnedReward: (ad, item) async {
                          await controller.onUserEarnedReward(ad, item);
                          this.setState(() {});
                        },
                      );
                    },
                    child: Text('Remove ads'),
                  );
                }),
                SizedBox(height: 32),
                Observer(builder: (context) {
                  if (controller.cachedUsers.isEmpty) {
                    return Container();
                  }

                  return Text(
                    'Searched users',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  );
                }),
                SizedBox(height: 16),
                Observer(builder: (_) {
                  if (controller.cachedUsers.isEmpty) {
                    return Container();
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: controller.cachedUsers.length,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                      final cachedUser = controller.cachedUsers[index];

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
                  );
                }),
              ],
            ),
          ),
          if (AppAd.showAd)
            Observer(builder: (context) {
              return Container(
                alignment: Alignment.center,
                child: controller.showBannerAd ? controller.adWidget : null,
                width: MediaQuery.of(context).size.width,
                height: 50,
              );
            })
        ],
      ),
    );
  }
}
