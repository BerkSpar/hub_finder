import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:github_finder/pages/repo/repo_controller.dart';
import 'package:github_finder/shared/models/load_state.dart';
import 'package:github_finder/utils/colors.dart';
import 'package:github_finder/widgets/header_widget.dart';
import 'package:github_finder/widgets/info_widget.dart';
import 'package:github_finder/widgets/language_badge_widget.dart';
import 'package:github_finder/widgets/listtile_widget.dart';

class RepoPage extends StatelessWidget {
  final String fullName;

  RepoPage(this.fullName);

  @override
  Widget build(BuildContext context) {
    final controller = RepoController(fullName);

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
              return Center(child: CircularProgressIndicator());
              break;
          }
        },
      ),
    );
  }
}

class Body extends StatelessWidget {
  final RepoController controller;

  Body(this.controller);

  Widget _getSubtitle() {
    if (controller.repository.description != null) {
      return Column(
        children: [
          SizedBox(height: 20),
          Text(
            controller.repository.description,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(24, 48, 24, 0),
      children: [
        HeaderWidget(
          imageUrl:
              'https://avatars3.githubusercontent.com/u/47111228?s=460&u=2d077bf84376e754ef2ae90d879521f6d5a453ba&v=4',
          title: controller.repository.name,
          subtitle: 'Felipe Passos',
        ),
        _getSubtitle(),
        SizedBox(height: 16),
        LanguageBadgeWidget(
          color: language_colors[controller.repository.language],
          title: controller.repository.language,
        ),
        SizedBox(height: 32),
        Row(
          children: [
            InfoWidget(
              title: controller.repository.stars.toString(),
              subtitle: 'Stars',
            ),
            SizedBox(width: 34),
            InfoWidget(
              title: controller.repository.forks.toString(),
              subtitle: 'Forks',
            ),
            SizedBox(width: 34),
            InfoWidget(
              title: controller.repository.openIssues.toString(),
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
                onTap: () {},
              ),
            );
          },
        ),
      ],
    );
  }
}
