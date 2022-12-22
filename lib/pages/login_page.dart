import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testone/pages/apiservice.dart';
import 'package:testone/pages/authflow.dart';
import 'package:testone/pages/employee.dart';
import 'package:testone/pages/homepage.dart';
import 'package:testone/pages/signup_page.dart';
import 'package:testone/router/auto_route.gr.dart';
import 'package:testone/widget/pwdtxtfieldwidget.dart';
import 'package:testone/widget/textfield.dart';

class LogInPage extends StatefulWidget {
  LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  int statuscode = 0;
  bool _obscured = true;
  final textFieldFocusNode = FocusNode();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  void getstatuscode() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      statuscode = prefs.getInt('response')!;
    });
  }

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) {
        return;
      } // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const Center(
                child: SizedBox(
                  height: 150,
                  width: 200,
                  child: Image(
                    image: AssetImage('assets/images/logoo.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Sign In",
                        //textAlign: TextAlign.start,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Color.fromARGB(255, 8, 140, 144)),
                      ),
                      const Text(
                        "Start Using !",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color.fromARGB(255, 8, 140, 144)),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Email",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color.fromARGB(255, 8, 140, 144)),
                          ),
                          TextFormField(
                            controller: _username,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                                hintText: "Email",
                                //border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.email,
                                    size: 20,
                                    color: Color.fromARGB(255, 8, 140, 144))),
                            // validator: (value) {
                            //   if (value!.isEmpty ||
                            //       !RegExp(r'^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$')
                            //           .hasMatch(value)) {
                            //     return "Enter valid name";
                            //   } else {
                            //     return null;
                            //   }
                            //},
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Password",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color.fromARGB(255, 8, 140, 144)),
                          ),
                          Container(
                            height: 60,
                            child: TextFormField(
                              controller: _password,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: _obscured,
                              focusNode: textFieldFocusNode,
                              decoration: InputDecoration(
                                  // focusedBorder: const OutlineInputBorder(
                                  //     borderSide: BorderSide(
                                  //         width: 2,
                                  //         color: Color.fromARGB(
                                  //             255, 8, 140, 144))),
                                  // enabledBorder: const OutlineInputBorder(
                                  //     borderSide: BorderSide(
                                  //         width: 2,
                                  //         color: Color.fromARGB(
                                  //             255, 8, 140, 144))),
                                  hintText: "Password.",
                                  prefixIcon: const Icon(
                                      Icons.lock_clock_outlined,
                                      size: 20,
                                      color: Color.fromARGB(255, 8, 140, 144)),
                                  suffixIcon: GestureDetector(
                                    onTap: _toggleObscured,
                                    child: Icon(
                                      _obscured
                                          ? Icons.visibility_off_rounded
                                          : Icons.visibility_rounded,
                                      size: 24,
                                      color: Color.fromARGB(255, 8, 140, 144),
                                    ),
                                  )),
                              // validator: (value) {
                              //   if (value!.isEmpty ||
                              //       !RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$")
                              //           .hasMatch(value)) {
                              //     return "Incorrect Password";
                              //   } else {
                              //     return null;
                              //   }
                              // },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Forgot password?',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 8, 140, 144)),
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 35),
                        child: GestureDetector(
                          onTap: () {
                            EasyLoading.show(status: "Please wait...");
                            ApiService()
                                .postLogInModel(
                                    username: _username.text,
                                    password: _password.text)
                                .whenComplete(() {
                              EasyLoading.dismiss()
                                  .whenComplete(() => statusalert());

                              return context.router
                                  .push(const CubitLinkStatusRoute());
                            });
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height / 15,
                            width: MediaQuery.of(context).size.width / 1.5,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color.fromARGB(255, 8, 140, 144)),
                            child: const Center(
                              child: Text(
                                "Log in",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void statusalert() async {
  final prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('token')) {
    EasyLoading.showToast("Log in Success", duration: Duration(seconds: 1));
  } else {
    EasyLoading.showError("Invalid user");
  }
}
