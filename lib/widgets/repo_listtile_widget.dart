import 'package:flutter/material.dart';
import 'package:github_finder/widgets/language_badge_widget.dart';

class RepoListTileWidget extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Color? color;
  final Function onTap;

  RepoListTileWidget({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  Widget _getSubtitle() {
    if (subtitle != null) {
      return Column(
        children: [
          SizedBox(height: 8),
          LanguageBadgeWidget(
            color: color,
            title: subtitle,
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title!,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  _getSubtitle(),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
