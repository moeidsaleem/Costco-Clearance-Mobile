import 'package:flutter/material.dart';
import 'package:simple_ios_app/models/order.dart';

class OrderFormComponent extends StatefulWidget {
  @override
  _OrderFormComponentState createState() => _OrderFormComponentState();
}

class _OrderFormComponentState extends State<OrderFormComponent> {
  final _formKey = GlobalKey<FormState>();
  final _order = Order();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Builder(
        builder: (context) => Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Product Number'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your Product Number';
                  }
                  return null;
                },
                onSaved: (val) =>
                    setState(() => _order.productNumber = int.parse(val)),
              ),
              TextFormField(
                  decoration: InputDecoration(labelText: 'Product Title'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your Product Title.';
                    }
                    return null;
                  },
                  onSaved: (val) => setState(() => _order.productTitle = val)),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Product Price'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your Product Price.';
                  }
                  return null;
                },
                onSaved: (val) => setState(
                  () => _order.productPrice = double.parse(val),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                child: RaisedButton(
                  onPressed: () {
                    final form = _formKey.currentState;
                    if (form.validate()) {
                      form.save();
                      _order.save();
                      _showDialog(context);
                    }
                  },
                  child: Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showDialog(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Submitting form')));
  }
}
