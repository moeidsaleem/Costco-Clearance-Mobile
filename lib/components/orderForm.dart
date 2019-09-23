import 'package:flutter/material.dart';
import 'package:simple_ios_app/models/order.dart';

class OrderFormComponent extends StatefulWidget {
  @override
  _OrderFormComponentState createState() => _OrderFormComponentState();
}

class _OrderFormComponentState extends State<OrderFormComponent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Order _order = Order();

  int step = 1;

  void _onSavedField(callback) {
    setState(callback);
  }

  Widget _renderField() {
    if (step == 2) {
      print(_order.productNumber);
      return ProductTitleWidget(this._onSavedField, _order);
    }
    if (step == 3) {
      return ProductPriceWidget(this._onSavedField, _order);
    }
    return ProductItemWidget(this._onSavedField, _order);
  }

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
              this._renderField(),
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16.0),
                    child: RaisedButton(
                      onPressed: () {
                        if (this.step > 1) {
                          setState(() {
                            step--;
                          });
                        }
                      },
                      child: Text('Back'),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16.0),
                    child: RaisedButton(
                      color: Colors.blue,
                      onPressed: () {
                        final form = _formKey.currentState;
                        if (form.validate()) {
                          form.save();
                          if (step == 3) {
                            _order.save();
                            _showDialog(context);
                            return;
                          }
                          setState(() {
                            step++;
                          });
                        }
                      },
                      child: Text(
                        this.step == 3 ? 'Save' : 'Next',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
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

class ProductItemWidget extends StatelessWidget {
  final Function _onSaved;
  final Order _order;

  ProductItemWidget(this._onSaved, this._order);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: _order.productNumber.toString(),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Product Number'),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter your Product Number';
        }
        return null;
      },
      onSaved: (val) =>
          this._onSaved(() => _order.productNumber = int.parse(val)),
    );
  }
}

class ProductTitleWidget extends StatelessWidget {
  final Function _onSaved;
  final Order _order;

  ProductTitleWidget(this._onSaved, this._order);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: _order.productTitle,
      decoration: InputDecoration(labelText: 'Product Title'),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter your Product Title.';
        }
        return null;
      },
      onSaved: (val) => this._onSaved(() => _order.productTitle = val),
    );
  }
}

class ProductPriceWidget extends StatelessWidget {
  final Function _onSaved;
  final Order _order;

  ProductPriceWidget(this._onSaved, this._order);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: _order.productPrice.toString(),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Product Price'),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter your Product Price.';
        }
        return null;
      },
      onSaved: (val) =>
          this._onSaved(() => _order.productPrice = double.parse(val)),
    );
  }
}
