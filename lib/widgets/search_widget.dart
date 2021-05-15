import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final Function onTapSearch;
  final TextEditingController? searchController;
  final String? hintText;

  SearchWidget({
    required this.onTapSearch,
    this.searchController,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: searchController,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              decoration: TextDecoration.none,
            ),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ),
        SizedBox(width: 16),
        GestureDetector(
          onTap: onTapSearch as void Function()?,
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.black,
            ),
            child: Center(
              child: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
