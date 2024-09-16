import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icthub_2024_9/features/more/ui/widgets/user_tile_widget.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            UserTile(
              label: 'Email',
              content: FirebaseAuth.instance.currentUser?.email ?? 'No email',
            ),
            UserTile(
              label: 'uid',
              content: FirebaseAuth.instance.currentUser?.uid ?? 'No email',
            ),
          ],
        ),
      ),
    );
  }
}
