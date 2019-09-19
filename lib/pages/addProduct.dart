import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:simple_ios_app/components/camera.dart';

class AddProductPage extends StatelessWidget {

  final List<CameraDescription> cameras;

  AddProductPage(this.cameras);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Products"),
      ),
      body: Center(
        child: FlatButton(
          color: Colors.blue,
          textColor: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CameraComponent(cameras: this.cameras),
              ),
            );
          },
          child: Text("Add Product"),
        )
      ),
    );
  }
}