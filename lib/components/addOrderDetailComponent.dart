import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:simple_ios_app/components/orderForm.dart';

class AddOrderDetailComponent extends StatelessWidget {
  final FacebookLogin facebookLogin = FacebookLogin();

  final dynamic profile;

  AddOrderDetailComponent(this.profile);

  Future<void> _logout() async {
    await facebookLogin.logOut();
    print("Logged out");
    // redirect to the main screen
  }

  Widget _renderProfileImage() {
    return Center(
      child: Container(
        alignment: Alignment.center,
        height: 40.0,
        width: 40.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(
              this.profile['picture']['data']['url'],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Detail Entry"),
        leading: Builder(
          builder: (BuildContext context) => this._renderProfileImage(),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () => facebookLogin.isLoggedIn
                .then((isLoggedIn) => isLoggedIn ? _logout() : {}),
          ),
        ],
      ),
      body: Container(
        child: Center(
          child: OrderFormComponent(),
        ),
      ),
    );
  }
}
