import 'package:flutter/material.dart';
import 'package:github_finder/pages/home/home_controller.dart';
import 'package:github_finder/pages/user/user_page.dart';
import 'package:github_finder/widgets/search_widget.dart';
import 'package:github_finder/widgets/listtile_widget.dart';

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
      body: ListView(
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
          SizedBox(height: 64),
          Text(
            'Searched users',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 24),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 1,
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: ListTileWidget(
                  imageUrl:
                      'https://avatars3.githubusercontent.com/u/47111228?s=460&u=2d077bf84376e754ef2ae90d879521f6d5a453ba&v=4',
                  title: 'Felipe Passos',
                  subtitle: 'Santo Antônio de Jesus, BA',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserPage('berkspar'),
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
