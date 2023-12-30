import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  final String? imageUrl;
  final String? title;
  final String? subtitle;
  final Function onTap;

  ListTileWidget({
    required this.imageUrl,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  Widget _getSubtitle() {
    if (subtitle != null) {
      return Column(
        children: [
          SizedBox(height: 8),
          Text(
            subtitle!,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
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
    return GestureDetector(
      onTap: onTap as void Function(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            SizedBox(
              height: 52,
              width: 52,
              child: CircleAvatar(
                backgroundImage: NetworkImage(imageUrl!),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  _getSubtitle(),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Center(
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
