import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:interactive_cares_new/signup_screen.dart';
import 'package:interactive_cares_new/validation.dart';
import 'dashboard.dart';
import 'firebase_auth.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  late Future<FirebaseApp> futureBuilder;

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _passVisible=false;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    futureBuilder = _initializeFirebase();
  }

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            user: user,
          ),
        ),
      );
    }

    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: FutureBuilder(
            future: futureBuilder,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Padding(
                  padding:  EdgeInsets.all(20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                       width: 600.w,
                       height: 400.h,
                       image: AssetImage("assets/images/login_template.png")
                      ),
                      Column(
                        children: [
                          Text(
                              'Interactive Cares',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 35.sp,
                                  fontWeight: FontWeight.w700,
                              )
                          ),
                          SizedBox(height: 5.h,),
                          Text(
                              'Interactive Cares is Country’s first-ever cloud & AI-Based Platform for giving education, health, mental health & legal service to customers through real-time communication.',
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w200,
                              ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h,),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
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
                                    borderSide: BorderSide(width: 1.w,color: Colors.orange),
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1.w,color: Colors.orange),
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
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
                            SizedBox(height: 25.h),
                            _isProcessing
                                ? CircularProgressIndicator()
                                : SizedBox(
                                  height: 60.h,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      _focusEmail.unfocus();
                                      _focusPassword.unfocus();

                                      if (_formKey.currentState!
                                          .validate()) {
                                        setState(() {
                                          _isProcessing = true;
                                        });

                                        User? user = await FirebaseAuthHelper
                                            .signInUsingEmailPassword(
                                          email: _emailTextController.text,
                                          password:
                                          _passwordTextController.text,
                                        );

                                        setState(() {
                                          _isProcessing = false;
                                        });

                                        if (user != null) {
                                          Navigator.of(context)
                                              .pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen(user: user),
                                            ),
                                          );
                                        }
                                      }
                                    },
                                    child: Text(
                                      'Sign In',
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
                                Text("Don't have an account?",style: TextStyle(fontSize: 13,color: Colors.grey),),
                                InkWell(
                                    onTap: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => SignUpScreen()),);
                                    },
                                    child: Text("Register",style: TextStyle(fontSize: 13,color: Colors.orange,fontWeight: FontWeight.bold),)
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}