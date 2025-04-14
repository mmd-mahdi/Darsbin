import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final Function(String) onChanged;

  const SearchBarWidget({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          onChanged: onChanged,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            hintText: 'جستجو...',
            hintStyle: const TextStyle(
              fontFamily: 'Vazir',
              color: Colors.grey,
            ),
            prefixIcon: Container(
              margin: const EdgeInsets.only(right: 8.0),
              decoration: const BoxDecoration(
                color: Colors.lightBlue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          ),
          style: const TextStyle(
            fontFamily: 'Vazir',
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}