import 'package:flutter/material.dart';
import 'package:fireship_app/login/login.dart';
import 'package:fireship_app/topics/topics.dart';
import 'package:fireship_app/services/auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading'); // to add method here
        } else if (snapshot.hasError) {
          return const Center (
            child: Text('Error'), // to add method here
          );
        } else if (snapshot.hasData) {
          return const TopicsScreen();
        } else {
          return const LoginScreen();
        }
      }
    );
  }
}
