import 'package:flutter/material.dart';
import 'package:github_finder/pages/organization/organization_page.dart';
import 'package:github_finder/pages/repo/repo_page.dart';
import 'package:github_finder/pages/user/user_controller.dart';
import 'package:github_finder/shared/models/load_state.dart';
import 'package:github_finder/utils/colors.dart';
import 'package:github_finder/widgets/info_widget.dart';
import 'package:github_finder/widgets/listtile_widget.dart';
import 'package:github_finder/widgets/repo_listtile_widget.dart';
import 'package:github_finder/widgets/header_widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class UserPage extends StatelessWidget {
  final String username;

  UserPage(this.username);

  @override
  Widget build(BuildContext context) {
    final controller = UserController(username);

    return Scaffold(
      appBar: AppBar(
        title: Image.asset('asset/images/logo_light.png'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Observer(
        builder: (context) {
          switch (controller.load) {
            case LoadState.loaded:
              return Body(controller);
              break;
            case LoadState.loading:
              return Center(child: CircularProgressIndicator());
              break;
            case LoadState.error:
              return Center(child: Text('User not found'));
              break;
            default:
              return Center(child: CircularProgressIndicator());
              break;
          }
        },
      ),
    );
  }
}

class Body extends StatelessWidget {
  final UserController controller;

  Body(this.controller);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(24, 48, 24, 0),
      children: [
        HeaderWidget(
          imageUrl: controller.user.avatarUrl,
          title: controller.user.name,
          subtitle: controller.user.location,
        ),
        SizedBox(height: 20),
        Text(
          controller.user.bio,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 32),
        Row(
          children: [
            InfoWidget(
              title: controller.user.followers.toString(),
              subtitle: 'Followers',
            ),
            SizedBox(width: 34),
            InfoWidget(
              title: controller.user.following.toString(),
              subtitle: 'Following',
            ),
          ],
        ),
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
                title: organization.login,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrganizationPage(),
                    ),
                  );
                },
              ),
            );
          },
        ),
        SizedBox(height: 48),
        Text(
          'Public repositories',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
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
                      builder: (context) => RepoPage(),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
