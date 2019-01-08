import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  String _email;
  String _password;
  bool _acceptTerms = false;

  Widget _buildEmailTextField(){
    return   TextField(
      decoration: InputDecoration(
          labelText: 'Email',
          filled: true,
          fillColor: Colors.blue),
      keyboardType: TextInputType.emailAddress,
      onChanged: (String value) {
        setState(() {
          _email = value;
        });
      },
    );
  }
  Widget _buildPasswordTextField(){
    return TextField(
      decoration: InputDecoration(
          labelText: 'Password',
          filled: true,
          fillColor: Colors.blue),
      obscureText: true,
      onChanged: (String value) {
        setState(() {
          _password = value;
        });
      },
    );
  }
  Widget _buildSwitchTile(){
    return  SwitchListTile(
        value: _acceptTerms,
        title: Text("Accept Terms"),
        onChanged: (bool value) {
          setState(() {
            _acceptTerms = value;
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
              child: Column(
                children: <Widget>[
                  _buildEmailTextField(),
                  SizedBox(height: 10.0,),
                  _buildPasswordTextField(),
                  _buildSwitchTile(),
                  Center(
                    child: RaisedButton(
                      color: Colors.orange,
                      child: Text("LOGIN"),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
