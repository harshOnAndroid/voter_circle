import 'beans/User.dart';

class LoggedInUser {
  static final LoggedInUser _singleton = LoggedInUser._internal();

  User user;

  factory LoggedInUser() {
    return _singleton;
  }

  LoggedInUser._internal();
}