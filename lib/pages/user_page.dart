import 'package:flutter/material.dart';
import 'package:github_finder/pages/organization_page.dart';
import 'package:github_finder/widgets/info_widget.dart';
import 'package:github_finder/widgets/listtile_widget.dart';
import 'package:github_finder/widgets/repo_listtile_widget.dart';
import 'package:github_finder/widgets/header_widget.dart';

class UserPage extends StatelessWidget {
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
                'https://avatars3.githubusercontent.com/u/47111228?s=460&u=2d077bf84376e754ef2ae90d879521f6d5a453ba&v=4',
            title: 'Felipe Passos',
            subtitle: 'Santo Antônio de Jesus, BA',
          ),
          SizedBox(height: 20),
          Text(
            'Computer program developer at G10 Sistemas and majoring in Systems Analysis and Development at IFBA, I\'m also like to program mobile apps in Flutter.',
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
                title: '5',
                subtitle: 'followers',
              ),
              SizedBox(width: 34),
              InfoWidget(
                title: '11',
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
            itemCount: 1,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: ListTileWidget(
                  imageUrl:
                      'https://avatars1.githubusercontent.com/u/68427875?s=200&v=4',
                  title: 'G10 Sistemas',
                  subtitle: 'Mais que um software, um conceito',
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
            itemCount: 4,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: RepoListTileWidget(
                  title: 'Bunnie',
                  subtitle: 'Dart',
                  color: Colors.blue,
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
