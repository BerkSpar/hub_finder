import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hub_finder/pages/organization/organization_controller.dart';
import 'package:hub_finder/pages/user/user_page.dart';
import 'package:hub_finder/shared/models/load_state.dart';
import 'package:hub_finder/shared/widgets/header_widget.dart';
import 'package:hub_finder/shared/widgets/listtile_widget.dart';

class OrganizationPage extends StatelessWidget {
  final String? name;

  OrganizationPage(this.name);

  @override
  Widget build(BuildContext context) {
    final controller = OrganizationController(name);

    return Scaffold(
      appBar: AppBar(
        title: Image.asset('asset/images/logo_light.png', height: 32),
        centerTitle: true,
        elevation: 0,
      ),
      body: Observer(
        builder: (context) {
          switch (controller.load) {
            case LoadState.loaded:
              return Body(controller);

            case LoadState.loading:
              return Center(child: CircularProgressIndicator());

            case LoadState.error:
              return Center(child: Text('Ocurr an error'));

            default:
              return CircularProgressIndicator();
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
          controller.organization.description!,
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
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.fromLTRB(24, 48, 24, 0),
            children: [
              HeaderWidget(
                imageUrl: controller.organization.avatarUrl,
                title: controller.organization.name,
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
                itemCount: controller.members.length,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  final member = controller.members[index];

                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: ListTileWidget(
                      imageUrl: member.avatarUrl,
                      title: member.login,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserPage(member.login),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Observer(builder: (context) {
          if (!controller.showAd) return Container();

          return Container(
            alignment: Alignment.center,
            child: controller.adWidget,
            width: MediaQuery.of(context).size.width,
            height: 50,
          );
        }),
      ],
    );
  }
}
