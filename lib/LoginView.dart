import 'package:flutter/material.dart';

import 'AppTheme.dart';

class LoginView extends StatefulWidget {
  static final String route = "login";

  final onLoginSuccessful;

  LoginView(this.onLoginSuccessful);

  @override
  State createState() => LoginViewState();
}

class LoginViewState extends State<LoginView>
    with SingleTickerProviderStateMixin {
  String _username = "";
  String _password = "";
  bool _isCredInvalid = false;
  AnimationController controller;
  Animation<double> scaleAnimation;

  bool isReverse = false;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addStatusListener((AnimationStatus state) {
      if (state == AnimationStatus.dismissed) {
        Navigator.pop(context);
        if (_username == "user123" && _password == 'pass123')
          widget.onLoginSuccessful();
      }
    });
    controller.forward();
  }

  LoginViewState() {
    print("constructoe");
  }

  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnimation,
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Center(
                  child: Form(
                    child: Theme(
                      data: ThemeData(
                        primarySwatch: AppTheme.colorPrimary,
                        inputDecorationTheme: InputDecorationTheme(
                          labelStyle:
                              TextStyle(color: Colors.blueGrey, fontSize: 20.0),
                          contentPadding: EdgeInsets.symmetric(vertical: 0),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextField(
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 0),
                                  labelText: 'Username',
                                  labelStyle: TextStyle(
                                      color: Color(0xff919191),
                                      fontSize: 20.0,
                                      fontStyle: FontStyle.italic)),
                              style: TextStyle(
                                  color: AppTheme.colorPrimary, fontSize: 20.0),
                              keyboardType: TextInputType.text,
                              onChanged: (value) => _onUsernameChanged(value),
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0)),
                            TextField(
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 0),
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                      color: Color(0xff919191),
                                      fontSize: 20.0,
                                      fontStyle: FontStyle.italic)),
                              style: TextStyle(
                                  color: AppTheme.colorPrimary, fontSize: 20.0),
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              onChanged: (value) => _onPasswordChanged(value),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 40.0),
                            ),
                            AnimatedContainer(
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: _isCredInvalid
                                    ? Colors.deepOrange
                                    : AppTheme.colorPrimary,
                              ),
                              curve: Curves.easeInOutBack,
                              padding: EdgeInsets.all(0),
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side:
                                        BorderSide(color: Colors.transparent)),
                                height: 40,
                                minWidth: double.infinity,
                                textColor: Colors.white,
                                child: Text(
                                  _isCredInvalid ? 'Retry!' : 'Login',
                                  style: TextStyle(fontSize: 18),
                                ),
                                onPressed: () => _onLoginPressed(),
                                splashColor: Colors.black12,
                              ),
                              duration: Duration(milliseconds: 1000),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 5,
                top: 5,
                child: GestureDetector(
                  onTap: () {
                    controller.reverse();
                  },
                  child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              offset: Offset(-1, 1),
                            )
                          ]),
                      child: Icon(Icons.close)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _onUsernameChanged(String newtext) {
    _username = newtext;
  }

  _onPasswordChanged(String newtext) {
    _password = newtext;
  }

  _onLoginPressed() {
      if (_username == "user123" && _password == 'pass123') {
      controller.reverse();
    } else {
      setState(() {
        _isCredInvalid = true;
      });
    }
  }
}
