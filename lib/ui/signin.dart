import 'package:kudapan/controllers/auth_controllers.dart';
import 'package:kudapan/ui/home.dart';
import 'package:universal_io/io.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kudapan/ui/signup.dart';
import 'package:get/get.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool _obscureText = true;
  IconData _iconVisible = Icons.visibility_off;

  Color _gradientTop = Color.fromARGB(255, 230, 75, 3);
  Color _gradientBottom = Color.fromARGB(255, 189, 62, 3);
  Color _mainColor = Color.fromARGB(255, 189, 62, 3);
  Color _underlineColor = Color(0xFFCCCCCC);

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
      if (_obscureText == true) {
        _iconVisible = Icons.visibility_off;
      } else {
        _iconVisible = Icons.visibility;
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final emailC = TextEditingController();
  final passC = TextEditingController();

  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: Platform.isIOS
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
          child: Stack(
            children: <Widget>[
              // top blue background gradient
              Container(
                height: MediaQuery.of(context).size.height / 3.5,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [_gradientTop, _gradientBottom],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
              ),
              // set your logo here
              Container(
                  margin: EdgeInsets.fromLTRB(
                      0, MediaQuery.of(context).size.height / 20, 0, 0),
                  alignment: Alignment.topCenter,
                  child:
                      Image.asset('assets/images/logo-text.png', height: 120)),
              ListView(
                children: <Widget>[
                  // create form login
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.fromLTRB(32,
                        MediaQuery.of(context).size.height / 3.5 - 72, 32, 0),
                    color: Colors.white,
                    child: Container(
                        margin: EdgeInsets.fromLTRB(24, 0, 24, 20),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 40,
                            ),
                            Center(
                              child: Text(
                                'SIGN IN',
                                style: TextStyle(
                                    color: _mainColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextField(
                              controller: emailC,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey[600]!)),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: _underlineColor),
                                  ),
                                  labelText: 'Email',
                                  labelStyle:
                                      TextStyle(color: Colors.grey[700])),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextField(
                              controller: passC,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey[600]!)),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: _underlineColor),
                                ),
                                labelText: 'Password',
                                labelStyle: TextStyle(color: Colors.grey[700]),
                                suffixIcon: IconButton(
                                    icon: Icon(_iconVisible,
                                        color: Colors.grey[700], size: 20),
                                    onPressed: () {
                                      _toggleObscureText();
                                    }),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  Fluttertoast.showToast(
                                      msg: 'Click forgot password',
                                      toastLength: Toast.LENGTH_SHORT);
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            SizedBox(
                              width: double.maxFinite,
                              child: TextButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) => _mainColor,
                                    ),
                                    overlayColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                  ),
                                  onPressed: () {
                                    authC.login(emailC.text, passC.text);
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => HomePage()));
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      'LOGIN',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  // create sign up link
                  Center(
                    child: Wrap(
                      children: <Widget>[
                        Text('New User? '),
                        GestureDetector(
                          onTap: () {
                            // Fluttertoast.showToast(
                            //     msg: 'Click signup',
                            //     toastLength: Toast.LENGTH_SHORT);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Signup()));
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                color: _mainColor, fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
