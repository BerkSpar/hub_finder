import 'package:flutter/material.dart';
import 'package:github_finder/pages/user/user_page.dart';
import 'package:github_finder/widgets/header_widget.dart';
import 'package:github_finder/widgets/info_widget.dart';
import 'package:github_finder/widgets/language_badge_widget.dart';
import 'package:github_finder/widgets/listtile_widget.dart';

class RepoPage extends StatelessWidget {
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
            title: 'Bunnie',
            subtitle: 'Felipe Passos',
          ),
          SizedBox(height: 20),
          Text(
            'The anime list that saves your time! ',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 16),
          LanguageBadgeWidget(
            color: Colors.blue,
            title: 'Dart',
          ),
          SizedBox(height: 32),
          Row(
            children: [
              InfoWidget(
                title: '155',
                subtitle: 'Stars',
              ),
              SizedBox(width: 34),
              InfoWidget(
                title: '11',
                subtitle: 'Forks',
              ),
              SizedBox(width: 34),
              InfoWidget(
                title: '2',
                subtitle: 'Open Issues',
              ),
            ],
          ),
          SizedBox(height: 48),
          Text(
            'Contributors',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(height: 24),
          ListView.builder(
            itemCount: 6,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: ListTileWidget(
                  imageUrl:
                      'https://avatars2.githubusercontent.com/u/53619830?s=460&u=9809495b28fe821a29996d7b65b0091723fe95ad&v=4',
                  title: 'Bruno Assis',
                  subtitle: '6 contributions',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserPage(),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
