import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String label;
  final String content;
  const UserTile({super.key, required this.label, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        tileColor: Colors.grey.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Text(label),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        subtitle: Text(content),
        subtitleTextStyle: const TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
