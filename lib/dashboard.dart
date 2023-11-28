
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:interactive_cares_new/video_tutorial.dart';

import 'login_screen.dart';
import 'model/course_model.dart';


class HomeScreen extends StatefulWidget {
  final User user;

  HomeScreen({required this.user});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late User _currentUser;

   List<CourseModel> list=[

     CourseModel(id: 1, title: "Course 1", content: "Content for the first item."),
     CourseModel(id: 2, title: "Course 2", content: "Content for the second item."),
     CourseModel(id: 3, title: "Course 3", content: "Content for the third item."),
     CourseModel(id: 4, title: "Course 4", content: "Content for the third item."),
     CourseModel(id: 5, title: "Course 5", content: "Content for the third item."),
     CourseModel(id: 5, title: "Course 6", content: "Content for the third item."),
     CourseModel(id: 5, title: "Course 7", content: "Content for the third item."),
   ];

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xfff5f2f2),
          body: WillPopScope(
            onWillPop: () async {
              final logout = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: new Text('Are you sure?'),
                    content: new Text('Do you want to logout from this App'),
                    actionsAlignment: MainAxisAlignment.spaceBetween,
                    actions: [
                      TextButton(
                        onPressed: () {
                          Logout();
                        },
                        child: const Text('Yes'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: const Text('No'),
                      ),
                    ],
                  );
                },
              );
              return logout!;
            },
            child: Center(
              child: Column(
                children: [
                  Container(
                    height: 100.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/appbar_bg3.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Padding(
                      padding:  EdgeInsets.only(left: 10.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image(
                            height: 80.h,
                            width: 50.w,
                            image: AssetImage('assets/images/profile_icon.png'),
                          ),
                          SizedBox(width: 10.w,),
                          Container(
                            height: 50.h,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Name: ${_currentUser.displayName}',style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w600,color: Colors.white),),
                                Text('Email: ${_currentUser.email}',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w400,color: Colors.white60),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Expanded(
                    child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 5.h,horizontal: 10.w),

                            child: Card(
                              child: Container(
                                height: 150.h,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ListTile(
                                      title: Text(list[index].title.toString(),style: TextStyle(color: Colors.black,fontSize: 20.sp),),
                                      onTap: (){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => VideoTutorial()),);
                                      },
                                      leading: SizedBox(height:80.h,width:80.w,child: Image(image: AssetImage("assets/images/course_icon.png"),fit: BoxFit.cover,)),
                                      subtitle: Text("Interactive Cares"),
                                      trailing: Text("continue",style: TextStyle(fontSize: 18.sp,color: Colors.green),),
                                    ),
                                  ],
                                )
                              ),
                            ),
                          ),
                        );
                      },
                  ),
                  ),
                ],
              ),
            ),
          )

      ),
    );
  }

  Future<dynamic> Logout() async {

    await FirebaseAuth.instance.signOut();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }


  Widget _getListItemTile(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),

      child: ListTile(
        title: Text(list[index].title.toString(),style: TextStyle(color: Colors.black),),
      ),
    );
  }
}