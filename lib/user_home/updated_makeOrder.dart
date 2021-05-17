import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';


class OrderForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OrderFormState();
  }
}

class _OrderFormState extends State<OrderForm> {
  Future<void> _actCopy(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('REQUEST SENT',style: TextStyle(fontSize: 22),),
//          content: const Text('Your request has been sent for approval!'),
          content: Text(displayResult),

          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                _reset();
              },
            ),
          ],
        );
      },
    );
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  String enterYourAdd='Please enter your address';
  var _formKey = GlobalKey<FormState>();

  var _currencies = ['Mutton', 'Chicken', 'Beef'];
  final double _minimumPadding = 5.0;

  var _currentItemSelected = '';

  @override
  void initState() {
    super.initState();
    _currentItemSelected = _currencies[0];
    initUser();
  }

  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }

  TextEditingController addressController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  var displayResult = '';
  bool requestStatus= false;
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      resizeToAvoidBottomPadding: false,

      body: Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.all(_minimumPadding),
            child: ListView(
              children: <Widget>[
                getImageAsset(),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding,
                        bottom: _minimumPadding
                    ),
                    child: TextFormField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(128),
                      ],
                      keyboardType: TextInputType.text,
                      controller: addressController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return enterYourAdd;
                        }
//                        else
//                          return '';
                      },

                      decoration: InputDecoration(
                          labelStyle: textStyle,
                          labelText: 'Address',
                          hintText: 'Enter your address',
                          errorStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0))),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding,
                        bottom: _minimumPadding
                    ),
                    child: TextFormField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(11),
                      ],
                      keyboardType: TextInputType.phone,
                      controller: mobileController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter your mobile number';
                        }
//                        else
//                          return '';
                      },
                      decoration: InputDecoration(
                          labelText: 'Mobile',
                          hintText: '(03#########)',
                          labelStyle: textStyle,
                          errorStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0))),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                      top: _minimumPadding,
                      bottom: _minimumPadding,
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(2),
                              ],
                              keyboardType: TextInputType.number,
                              controller: quantityController,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Please enter quantity';
                                }
//                                else
//                                  return '';
                              },
                              decoration: InputDecoration(
                                labelText: 'Quantity',
                                hintText: 'Quantity in kg',
                                labelStyle: textStyle,
                                errorStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.0
                                ),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),

                              ),
                            )),
                        Container(
                          width: _minimumPadding,
                        ),
                        Expanded(
                            child: DropdownButton<String>(
                              items: _currencies.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              value: _currentItemSelected,
                              onChanged: (String newValueSelected) {
                                // Your code to execute, when a menu item is selected from dropdown
                                _onDropDownItemSelected(newValueSelected);
                              },
                            ),
                        )
                      ],
                    ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        bottom: _minimumPadding,
                        top: _minimumPadding
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            color: Colors.black,
                            child: Text(
                              'Submit',
                              textScaleFactor: 1.5,
                            ),
                            shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                            textColor: Colors.white,
                            onPressed: () {
                              setState(() {
                                if (_formKey.currentState.validate()) {
                                  this.displayResult = displayMessageOnPopUp();
                                  Firestore.instance
                                      .collection('order_tbl')
                                      .document(_formKey.toString())
                                      .setData({
                                    "mobile": mobileController.text,
                                    "address": addressController.text,
                                    "animal": _currentItemSelected,
                                    "timestamp": FieldValue.serverTimestamp(),
                                    "quantity": quantityController.text,
                                    "user": user.email,
                                    "approve":requestStatus,

                                  });
                                  _actCopy(context);
                                }
                              });
                            },
                          ),
                        ),
//                        Expanded(
//                          child: RaisedButton(
//                            color: Theme.of(context).primaryColorDark,
//                            textColor: Theme.of(context).primaryColorLight,
//                            child: Text(
//                              'Clear',
//                              textScaleFactor: 1.5,
//                            ),
//                            shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
//                            onPressed: () {
//                              setState(() {
//                                _reset();
//                              });
//                            },
//                          ),
//                        ),
                      ],
                    )),
//                Padding(
//                  padding: EdgeInsets.all(_minimumPadding * 2),
//                  child: Text(
//                    this.displayResult,
//                    style: textStyle,
//                  ),
//                )
              ],
            )),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('assets/images/a.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );

    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  String displayMessageOnPopUp() {

    double quantity = double.parse(quantityController.text);
//    double bill= double.parse(rates[_currentItemSelected]);
    String result =
        'Your request for $quantity kg $_currentItemSelected has been submitted for approval. Price $quantity';
    return result;
  }

  void _reset() {
    addressController.text = '';
    mobileController.text = '';
    quantityController.text = '';
    displayResult = '';
    _currentItemSelected = _currencies[0];
  }
}