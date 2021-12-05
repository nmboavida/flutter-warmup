import 'package:flutter/material.dart';

import 'package:fireship_app/services/models.dart';
import 'package:fireship_app/services/firestore.dart';
import 'package:fireship_app/shared/bottom_nav.dart';
import 'package:fireship_app/shared/loading.dart';
import 'package:fireship_app/shared/error.dart';

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Topic>>(
      future: FirestoreService().getTopics(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return Center(
            child: ErrorMessage(message: snapshot.error.toString()),
          );
        } else if (snapshot.hasData) {
          var topics = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepPurple,
              title: const Text('Topics'),
            ),
            body: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20.0),
              crossAxisSpacing: 10.0,
              crossAxisCount: 2,
              children: topics.map((t) => Text(t.title)).toList(),
            ),
            bottomNavigationBar: const BottomNavBar(),
          );

        } else {
          return const Text('No topics found in FireStore. Check DB.');
        }
        
      }
    );
  }
}
