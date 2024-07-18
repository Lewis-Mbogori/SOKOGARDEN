import 'package:flutter/material.dart';

import 'auth/login.dart';
import 'auth/register.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  // listener
  bool isLogin = true;
  void toggle() => setState(() {
        isLogin = !isLogin;
      });
  @override
  Widget build(BuildContext context) {
    return isLogin
        ? Login(
            onClickedSignup: toggle,
          )
        : Register(
            onClickedSignIn: toggle,
          );
  }
}