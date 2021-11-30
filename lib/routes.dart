import 'package:fireship_app/about/about.dart';
import 'package:fireship_app/home/home.dart';
import 'package:fireship_app/login/login.dart';
import 'package:fireship_app/profile/profile.dart';
import 'package:fireship_app/topics/topics.dart';

// Maps string value to widget
var appRoutes = {
  '/': (context) => HomeScreen(),
  '/login': (context) => LoginScreen(),
  '/topics': (context) => TopicsScreen(),
  'profile': (context) => ProfileScreen(),
  '/about': (context) => AboutScreen(),
};
