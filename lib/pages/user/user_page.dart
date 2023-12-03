import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:hub_finder/pages/organization/organization_page.dart';
import 'package:hub_finder/pages/repo/repo_page.dart';
import 'package:hub_finder/pages/user/user_controller.dart';
import 'package:hub_finder/shared/core/app_ad.dart';
import 'package:hub_finder/shared/core/app_colors.dart';
import 'package:hub_finder/shared/core/app_config.dart';
import 'package:hub_finder/shared/models/load_state.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hub_finder/shared/widgets/header_widget.dart';
import 'package:hub_finder/shared/widgets/info_widget.dart';
import 'package:hub_finder/shared/widgets/listtile_widget.dart';
import 'package:hub_finder/shared/widgets/repo_listtile_widget.dart';
import 'package:share_plus/share_plus.dart';

class UserPage extends StatelessWidget {
  final String? username;

  UserPage(this.username) {
    FirebaseAnalytics.instance.logSelectContent(
      contentType: 'user',
      itemId: '${username}',
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = UserController(username);

    return Scaffold(
      appBar: AppBar(
        title: Image.asset('asset/images/logo_light.png', height: 32),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              await Share.share(
                'Download Hub Finder and explore all of the Github on your hands!\n\n${AppConfig.storeUrl}',
              );

              FirebaseAnalytics.instance.logShare(
                contentType: 'user',
                itemId: '${username}',
                method: 'unknown',
              );
            },
            icon: Icon(Icons.share),
          ),
        ],
      ),
      body: Observer(
        builder: (context) {
          switch (controller.load) {
            case LoadState.loaded:
              return Body(controller);

            case LoadState.loading:
              return Center(child: CircularProgressIndicator());

            case LoadState.error:
              return Center(child: Text('User not found'));

            default:
              return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class Body extends StatelessWidget {
  final UserController controller;

  Body(this.controller);

  Widget _getBio() {
    if (controller.user!.bio != null) {
      return Text(
        controller.user!.bio!,
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getOrganizations() {
    if (controller.organizations.length > 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 53),
          Text(
            'Organizations',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(height: 24),
          ListView.builder(
            shrinkWrap: true,
            itemCount: controller.organizations.length,
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              final organization = controller.organizations[index];

              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: ListTileWidget(
                  imageUrl: organization.avatarUrl,
                  title: '@${organization.login}',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            OrganizationPage(organization.login),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget _getPublicRepositories() {
    if (controller.repositories.length > 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 48),
          Text(
            'Public repositories',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(height: 24),
          ListView.builder(
            itemCount: controller.repositories.length,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              final repositories = controller.repositories[index];

              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: RepoListTileWidget(
                  title: repositories.name,
                  subtitle: repositories.language,
                  color: language_colors[repositories.language],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RepoPage(repositories.fullName),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.fromLTRB(24, 48, 24, 0),
            children: [
              HeaderWidget(
                imageUrl: controller.user!.avatarUrl,
                title: controller.user!.name,
                subtitle: controller.user!.location,
              ),
              SizedBox(height: 20),
              _getBio(),
              SizedBox(height: 32),
              Row(
                children: [
                  InfoWidget(
                    title: controller.user!.followers.toString(),
                    subtitle: 'Followers',
                  ),
                  SizedBox(width: 34),
                  InfoWidget(
                    title: controller.user!.following.toString(),
                    subtitle: 'Following',
                  ),
                ],
              ),
              _getOrganizations(),
              _getPublicRepositories(),
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
          }),
      ],
    );
  }
}
