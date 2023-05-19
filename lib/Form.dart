import 'package:flutter/material.dart';
import 'package:emergency/ButtonInterface.dart';
import 'ButtonInterface.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  String ph = '';
  String comorb = '';
  String nam = '';
  String ad = '';
  String ph2 = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget buildNam() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Name', prefixIcon: Icon(Icons.person_outline_rounded)),
      maxLength: 50,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Required Field';
        }
        return null;
      },
      onSaved: (String value) {
        nam = value;
      },
    );
  }

  Widget buildad() {
    return TextFormField(
        decoration: InputDecoration(
            labelText: 'Address', prefixIcon: Icon(Icons.house)),
        maxLength: 100,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Required Field';
          }
          return null;
        },
        onSaved: (String value) {
          ad = value;
        });
  }

  Widget buildPh2() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Phone number',
          prefixIcon: Icon(Icons.phone)),
      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Required Field';
        }

        return null;
      },
      onSaved: (String value) {
        ph2 = value;
      },
    );
  }

  Widget buildPh() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Phone number of Vaccination Centre',
          prefixIcon: Icon(Icons.phone)),
      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Required Field';
        }

        return null;
      },
      onSaved: (String value) {
        ph = value;
      },
    );
  }

  Widget buildcomorb() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Comorbidities: Seperate by ,',
          prefixIcon: Icon(Icons.coronavirus_sharp)),
      maxLength: 100000,
      validator: (String value) {
        return null;
      },
      onSaved: (String value) {
        comorb = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency and Co-Morbodity Details:'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildNam(),
                buildPh2(),
                buildad(),
                buildPh(),
                buildcomorb(),
                SizedBox(height: 20),
                RaisedButton(
                  child: Text(
                    'Next >',
                    style: TextStyle(
                      color: Colors.teal[200],
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }

                    _formKey.currentState.save();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MainActivity(
                          passedph: ph,
                          passedmorb: comorb,
                          passedph2: ph2,
                          passednam: nam,
                          passedad: ad,
                        ),
                      ),
                    );

                    //Send to API
                  },
                )
              ],
            ),
          )),
    );
  }
}
