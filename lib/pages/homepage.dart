import 'package:auto_route/auto_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testone/router/auto_route.gr.dart';
import 'package:testone/services/local_notification.dart';

import '../widget/textbutton.dart';
import 'department.dart';
import 'designation.dart';
import 'employee.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crud Api"),
        actions: [
          TextButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.remove('token');
                context.router.push(CubitLinkStatusRoute());
              },
              child: const Text(
                'Log Out',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Container(
        color: Color.fromARGB(255, 224, 218, 218),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        //color: Colors.blueGrey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EmployeePage(),
                      ));
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      const Icon(
                        Icons.person,
                        size: 22,
                        color: Colors.blueGrey,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      TextButtonWidget(
                        onpressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EmployeePage(),
                              ));
                        },
                        text: 'Employees',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: GestureDetector(
                onTap: () {
                  // EasyLoading.show(
                  //     // indicator: ,
                  //     //maskType: EasyLoadingMaskType.black,
                  //     dismissOnTap: true,
                  //     status: 'loading.....');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DepartmentPage(),
                      ));
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      const Icon(
                        Icons.apartment_rounded,
                        size: 22,
                        color: Colors.blueGrey,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      TextButtonWidget(
                        onpressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DepartmentPage(),
                              ));
                        },
                        text: 'Department',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: () {
                // EasyLoading.showToast('Please wait',
                //     dismissOnTap: true,
                //     duration: Duration(seconds: 1),
                //     toastPosition: EasyLoadingToastPosition.center);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DesignationPage(),
                    ));
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    const Icon(
                      Icons.computer_sharp,
                      size: 22,
                      color: Colors.blueGrey,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextButtonWidget(
                      onpressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DepartmentPage(),
                            ));
                      },
                      text: 'Designation',
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
