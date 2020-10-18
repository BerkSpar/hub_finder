import 'package:flutter/material.dart';
import 'package:github_finder/pages/user/user_page.dart';
import 'package:github_finder/widgets/header_widget.dart';
import 'package:github_finder/widgets/listtile_widget.dart';

class OrganizationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('asset/images/logo_light.png'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(24, 48, 24, 0),
        children: [
          HeaderWidget(
            imageUrl:
                'https://avatars1.githubusercontent.com/u/68427875?s=200&v=4',
            title: 'G10 Sistemas',
            subtitle: 'Organization',
          ),
          SizedBox(height: 20),
          Text(
            'Mais que um software, um conceito',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
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
      ),
    );
  }
}
