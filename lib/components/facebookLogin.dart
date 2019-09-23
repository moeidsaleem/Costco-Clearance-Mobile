import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:simple_ios_app/components/addOrderDetailComponent.dart';

class FacebookLoginComponent extends StatelessWidget {
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
            builder: (context) => AddOrderDetailComponent(profile),
          ),
        );

        // onLoginStatusChanged(true, profileData: profile);
        break;
    }
    Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AddOrderDetailComponent({}),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Facebook Login"),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(
        //       Icons.exit_to_app,
        //       color: Colors.white,
        //     ),
        //     onPressed: () => facebookLogin.isLoggedIn
        //         .then((isLoggedIn) => isLoggedIn ? _logout() : {}),
        //   ),
        // ],
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

// class FacebookLoginComponent extends StatefulWidget {
//   @override
//   _FacebookLoginComponentState createState() => _FacebookLoginComponentState();
// }

// class _FacebookLoginComponentState extends State<FacebookLoginComponent> {
//   bool isLoggedIn = false;
//   var profileData;

//   var facebookLogin = FacebookLogin();

//   void onLoginStatusChanged(bool isLoggedIn, {profileData}) {
//     setState(() {
//       this.isLoggedIn = isLoggedIn;
//       this.profileData = profileData;
//     });
//   }

//   void initiateFacebookLogin(BuildContext context) async {
//     var facebookLoginResult =
//         await facebookLogin.logInWithReadPermissions(['email']);

//     switch (facebookLoginResult.status) {
//       case FacebookLoginStatus.error:
//         onLoginStatusChanged(false);
//         break;
//       case FacebookLoginStatus.cancelledByUser:
//         onLoginStatusChanged(false);
//         break;
//       case FacebookLoginStatus.loggedIn:
//         var graphResponse = await http.get(
//             'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${facebookLoginResult.accessToken.token}');

//         var profile = json.decode(graphResponse.body);
//         print(profile.toString());

//         // Navigator.push(
//         //   context,
//         //   MaterialPageRoute(
//         //     builder: (context) => AddOrderDetailComponent(profile),
//         //   ),
//         // );

//         onLoginStatusChanged(true, profileData: profile);
//         break;
//     }
//   }

//   Widget _displayUserData(profileData) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         Container(
//           height: 200.0,
//           width: 200.0,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             image: DecorationImage(
//               fit: BoxFit.fill,
//               image: NetworkImage(
//                 profileData['picture']['data']['url'],
//               ),
//             ),
//           ),
//         ),
//         SizedBox(height: 28.0),
//         Text(
//           "Logged in as: ${profileData['name']}",
//           style: TextStyle(
//             fontSize: 20.0,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _displayLoginButton(BuildContext context) {
//     return RaisedButton(
//       child: Text("Login with Facebook"),
//       onPressed: () => initiateFacebookLogin(context),
//     );
//   }

//   _logout() async {
//     await facebookLogin.logOut();
//     onLoginStatusChanged(false);
//     print("Logged out");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Facebook Login"),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(
//               Icons.exit_to_app,
//               color: Colors.white,
//             ),
//             onPressed: () => facebookLogin.isLoggedIn
//                 .then((isLoggedIn) => isLoggedIn ? _logout() : {}),
//           ),
//         ],
//       ),
//       body: Container(
//         child: Center(
//           child: isLoggedIn
//               ? _displayUserData(profileData)
//               : _displayLoginButton(),
//         ),
//       ),
//     );
//   }
// }
