import 'dart:developer';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testone/model/designationmodel.dart';

import 'package:testone/pages/apiservice.dart';

class DesignationPage extends StatefulWidget {
  const DesignationPage({super.key});

  @override
  State<DesignationPage> createState() => _DesignationPageState();
}

class _DesignationPageState extends State<DesignationPage> {
  List<DesignationModel> newdesignlist = [];

  TextEditingController namecontroller = TextEditingController();
  // controller for date picker textfield
  TextEditingController dateinput = TextEditingController();
  String? dropdwndesignid;
  String tokenn = '';

  @override
  void initState() {
    super.initState();
    // getdata is a new function which defined at bottom
    getdata();

    dateinput.text = ''; //set the initial value of datepicker textfield
  }

  getdata() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    final designdatafinal = await ApiService().getDesignationModel(token);
    setState(() {
      newdesignlist = designdatafinal;
      tokenn = token;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Add new Desination"),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Cancel",
                              style: TextStyle(fontSize: 17),
                            )),
                        ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 22, 177, 27)),
                            ),
                            onPressed: () {
                              setState(() {
                                ApiService()
                                    .postDesignationModel(
                                        designid: dropdwndesignid.toString(),
                                        designname: namecontroller.text,
                                        token: tokenn)
                                    .whenComplete(() => getdata());
                              });
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Add",
                              style: TextStyle(fontSize: 17),
                            )),
                      ],
                    )
                  ],
                  content: Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: namecontroller,
                          decoration: const InputDecoration(
                              hintText: "Enter designation name"),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text("Designation List"),
      ),
      body: newdesignlist.isEmpty
          ? Center(
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Column(
                    children: const [
                      Text('Please wait', style: TextStyle(color: Colors.blue)),
                      SizedBox(
                        height: 10,
                      ),
                      CircularProgressIndicator(),
                    ],
                  )))
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Color.fromARGB(255, 230, 240, 245),
              child: ListView.builder(
                itemCount: newdesignlist.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white),
                      child: ListTile(
                        title: Text(newdesignlist[index].name.toString()),
                        trailing: PopupMenuButton(
                          itemBuilder: (context) => [
                            const PopupMenuItem<int>(
                                value: 1,
                                child: Text(
                                  "Delete",
                                  style: TextStyle(fontSize: 20),
                                )),
                            const PopupMenuItem(
                                value: 2,
                                child: Text(
                                  "Update",
                                  style: TextStyle(fontSize: 20),
                                )),
                          ],
                          onSelected: (value) {
                            if (value == 1) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      "Confirm",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: Text("Are you sure to delete"),
                                    actions: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.red)),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("Cancel")),
                                          ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.green)),
                                              onPressed: () {
                                                ApiService()
                                                    .deleteDesignationModel(
                                                        id: newdesignlist[index]
                                                            .id
                                                            .toString(),
                                                        token: tokenn)
                                                    .whenComplete(
                                                        () => getdata());
                                                Navigator.pop(context);
                                              },
                                              child: Text("Ok"))
                                        ],
                                      )
                                    ],
                                  );
                                },
                              );
                            } else {
                              setState(() {
                                namecontroller.text =
                                    newdesignlist[index].name.toString();
                              });
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Update Department"),
                                      actions: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.red),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  "Cancel",
                                                  style:
                                                      TextStyle(fontSize: 17),
                                                )),
                                            ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          const Color.fromARGB(
                                                              255,
                                                              22,
                                                              177,
                                                              27)),
                                                ),
                                                onPressed: () {
                                                  log(namecontroller.text);
                                                  ApiService()
                                                      .updateDesignationModel(
                                                        id: newdesignlist[index]
                                                            .id
                                                            .toString(),
                                                        name:
                                                            namecontroller.text,
                                                        token: tokenn,
                                                      )
                                                      .whenComplete(
                                                          () => getdata());
                                                  setState(() {
                                                    namecontroller.text;
                                                  });
                                                  log(namecontroller.text);

                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  "Add",
                                                  style:
                                                      TextStyle(fontSize: 17),
                                                )),
                                          ],
                                        )
                                      ],
                                      content: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              controller: namecontroller,
                                              decoration: const InputDecoration(
                                                  hintText:
                                                      "Enter department name"),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            }
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
