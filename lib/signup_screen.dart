import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:interactive_cares_new/validation.dart';
import 'dashboard.dart';
import 'firebase_auth.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _registerFormKey = GlobalKey<FormState>();

  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _passVisible=false;
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusName.unfocus();
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding:  EdgeInsets.all(20.w),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                        width: 550.w,
                        height: 350.h,
                        image: AssetImage("assets/images/login_template.png")
                    ),
                    Form(
                      key: _registerFormKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 60.h,
                            width: double.infinity,
                            child: TextFormField(
                              controller: _nameTextController,
                              focusNode: _focusName,
                              validator: (value) => Validator.validateName(
                                name: value,
                              ),
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person,size: 20.sp,),
                                hintText: 'Name',
                                contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1,color: Colors.orange),
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1,color: Colors.orange),
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 12.0),
                          SizedBox(
                            height: 60.h,
                            width: double.infinity,
                            child: TextFormField(
                              controller: _emailTextController,
                              focusNode: _focusEmail,
                              validator: (value) => Validator.validateEmail(
                                email: value,
                              ),
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email,size: 20.sp,),
                                hintText: 'Email',
                                contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1,color: Colors.orange),
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1,color: Colors.orange),
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 12.0),
                          SizedBox(
                            height: 60.h,
                            width: double.infinity,
                            child: TextFormField(
                              controller: _passwordTextController,
                              focusNode: _focusPassword,
                              obscureText: !_passVisible,
                              validator: (value) => Validator.validatePassword(
                                password: value,
                              ),
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock,size: 20.sp,),
                                hintText: 'Password',
                                contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1.w,color: Colors.orange),
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1.w,color: Colors.orange),
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(_passVisible ? Icons.visibility_off : Icons.visibility),
                                  onPressed: () => setState(() {
                                    _passVisible = !_passVisible;
                                  }),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 32.0),
                          _isProcessing
                              ? CircularProgressIndicator()
                              : SizedBox(
                                height: 60.h,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      _isProcessing = true;
                                    });

                                    if (_registerFormKey.currentState!
                                        .validate()) {
                                      User? user = await FirebaseAuthHelper
                                          .registerUsingEmailPassword(
                                        name: _nameTextController.text,
                                        email: _emailTextController.text,
                                        password:
                                        _passwordTextController.text,
                                      );

                                      setState(() {
                                        _isProcessing = false;
                                      });

                                      if (user != null) {
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                HomeScreen(user: user),
                                          ),
                                          ModalRoute.withName('/'),
                                        );
                                      }
                                    }else{
                                      setState(() {
                                        _isProcessing = false;
                                      });
                                    }
                                  },
                                  child: Text(
                                    'Sign up',
                                    style: TextStyle(color: Colors.white,fontSize: 20.sp),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.orange,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.r)
                                    ),
                                    //side: BorderSide(color: Colors.blueAccent, width: 1,),
                                  ),
                                ),
                              ),
                          SizedBox(height: 100.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have an account?",style: TextStyle(fontSize: 13,color: Colors.grey),),
                              InkWell(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => LoginScreen()),);
                                  },
                                  child: Text("Sign in",style: TextStyle(fontSize: 13,color: Colors.orange,fontWeight: FontWeight.bold),)
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}