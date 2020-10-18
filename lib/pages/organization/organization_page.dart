import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:github_finder/pages/organization/organization_controller.dart';
import 'package:github_finder/shared/models/load_state.dart';
import 'package:github_finder/widgets/header_widget.dart';
import 'package:github_finder/widgets/listtile_widget.dart';

class OrganizationPage extends StatelessWidget {
  final String name;

  OrganizationPage(this.name);

  @override
  Widget build(BuildContext context) {
    final controller = OrganizationController(name);

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
              return Center(child: Text('Ocurr an error'));
              break;
            default:
              return CircularProgressIndicator();
              break;
          }
        },
      ),
    );
  }
}

class Body extends StatelessWidget {
  final OrganizationController controller;

  Body(this.controller);

  Widget _getBio() {
    return Column(
      children: [
        SizedBox(height: 20),
        Text(
          controller.organization.description,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(24, 48, 24, 0),
      children: [
        HeaderWidget(
          imageUrl: controller.organization.avatarUrl,
          title: controller.organization.login,
          subtitle: 'Organization',
        ),
        _getBio(),
        SizedBox(height: 48),
        Text(
          'Members',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        SizedBox(height: 24),
        ListView.builder(
          itemCount: 8,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: ListTileWidget(
                imageUrl:
                    'https://avatars2.githubusercontent.com/u/53619830?s=460&u=9809495b28fe821a29996d7b65b0091723fe95ad&v=4',
                title: 'Bruno Assis',
                onTap: () {},
              ),
            );
          },
        ),
      ],
    );
  }
}
