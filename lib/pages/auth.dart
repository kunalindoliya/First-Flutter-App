import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  final Map<String,dynamic> _formData={
    'email':null,
    'password':null,
    'acceptTerms':false
  };
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Email', filled: true, fillColor: Colors.blue),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) return 'Enter valid Email';
      },
      onSaved: (String value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Password', filled: true, fillColor: Colors.blue),
      obscureText: true,
      validator: (String value) {
        if(value.isEmpty)
          return 'Password cannot be empty';
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  Widget _buildSwitchTile() {
    return SwitchListTile(
        value: _formData['acceptTerms'],
        title: Text("Accept Terms"),
        onChanged: (bool value) {
          setState(() {
            _formData['acceptTerms'] = value;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My APP'),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                /*colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4), BlendMode.dstATop),*/
                image: AssetImage('assets/background.jpg')),
          ),
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child:Column(
                children: <Widget>[
                  _buildEmailTextField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  _buildPasswordTextField(),
                  _buildSwitchTile(),
                  Center(
                    child: RaisedButton(
                      color: Colors.orange,
                      child: Text("LOGIN"),
                      onPressed: () {
                        if(!_formKey.currentState.validate() || !_formData['acceptTerms'])
                          return;
                        _formKey.currentState.save();
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                    ),
                  ),
                ],
              ),
              ),
            ),
          ),
        ),
    );
  }
}
