import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class LoginPage extends StatelessWidget {
  final FacebookLogin facebookLogin = FacebookLogin();

  void initiateFacebookLogin(BuildContext context) async {
    FacebookLoginResult facebookLoginResult =
        await facebookLogin.logInWithReadPermissions(['email']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        print(facebookLoginResult.errorMessage);
        // show error
        // onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        // show cancel message
        // onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
        Response graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${facebookLoginResult.accessToken.token}');

        dynamic profile = json.decode(graphResponse.body);
        print(profile.toString());

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => null,
          ),
        );

        // onLoginStatusChanged(true, profileData: profile);
        break;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        child: Center(
          child: RaisedButton(
            child: Text("Login with Facebook"),
            onPressed: () => initiateFacebookLogin(context),
          ),
        ),
      ),
    );
  }
}
