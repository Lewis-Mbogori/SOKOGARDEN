// Shared preferences
import 'package:shared_preferences/shared_preferences.dart';

// we need to initialize the shared preferences class to be able to access saving and retrieval metods

Future savedlogin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // SAVE Data
  // bool
  prefs.setBool('isVendor', false);
  // number
  prefs.setInt('user_id', 1);
  prefs.setDouble('font_size', 23.0);
  //string
  prefs.setString('fname', 'John');
  prefs.setString('lname', 'doe');
  //list
  prefs.setStringList('cart', ['item1', 'item2']);
}

// RETRIEVING DATA
Future fetchLogin() async {
  // Initialize
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.getBool('isVendor'); // return a boolean (null)
  prefs.getInt('user_id'); // return an integer (null)
  prefs.getDouble('font_size'); // return a double (null)
  prefs.getString('fname');
  prefs.getString('lname');
  prefs.getStringList('cart');
}

// NOTE
// update they - overides
// clearing all
Future deleteEntry() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('key');
}

// DELETEE ALL
Future clearEntries() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}

class PrefsNaming {
  static const String isVendor = 'isVendor';
  static const String userid = 'user_id';
  static const String fontsize = 'font_size';
  static const String fname = 'fname';
  static const String lname = 'lname';
  static const String phone = 'phone';
  static const String username = 'username';
}