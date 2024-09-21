import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icthub_2024_9/features/more/ui/widgets/card_info_user.dart';
import 'package:icthub_2024_9/features/more/ui/widgets/user_tile_widget.dart';
import 'package:icthub_2024_9/features/signup/data/data_source/signup_data_source.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More'),
      ),
      body: FutureBuilder(
        future: SignupDataSource.getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Name',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CardInfoUser(text: snapshot.data!.name),
                const  SizedBox(
                    height: 20,
                  ),
                 const Text(
                    'phone',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CardInfoUser(text: snapshot.data!.phone.toString()),
                  const  SizedBox(
                    height: 20,
                  ),
                 const Text(
                    'email',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CardInfoUser(text: snapshot.data!.email)
                ],
              ),
            );
          } else {
            return Text('can\'t fetch user data');
          }
        },
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(12.0),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       UserTile(
      //         label: 'Email',
      //         content: FirebaseAuth.instance.currentUser?.email ?? 'No email',
      //       ),
      //       UserTile(
      //         label: 'uid',
      //         content: FirebaseAuth.instance.currentUser?.uid ?? 'No email',
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
