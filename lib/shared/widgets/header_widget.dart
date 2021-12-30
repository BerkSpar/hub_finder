import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? imageUrl;

  HeaderWidget({
    required this.imageUrl,
    required this.subtitle,
    required this.title,
  });

  Widget _getSubtitle() {
    if (subtitle != null) {
      return Column(
        children: [
          SizedBox(height: 8),
          Text(
            subtitle!,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: Colors.grey,
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
    return Container(
      child: Row(
        children: [
          Container(
            height: 80,
            width: 80,
            child: CircleAvatar(
              backgroundImage: NetworkImage(imageUrl ?? ''),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? '',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                _getSubtitle(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
