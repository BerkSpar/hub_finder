import 'package:flutter/material.dart';

class UserHeaderWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;

  UserHeaderWidget({
    @required this.imageUrl,
    @required this.subtitle,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 80,
          width: 80,
          child: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
        ),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Felipe Passos',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Santo Antonio de Jesus, BA',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
