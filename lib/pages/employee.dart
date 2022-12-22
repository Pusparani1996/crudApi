import 'dart:developer';
import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:testone/model/department_model.dart';
import 'package:testone/model/designationmodel.dart';

import 'package:testone/model/employeemodel.dart';
import 'package:testone/pages/apiservice.dart';
import 'package:testone/pages/employeedetails.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({super.key});

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  List<EmployeeModel> newemplist = [];
  List<DepartmentModel> newdeptlist = [];
  List<DesignationModel> newdesignlist = [];

  TextEditingController namecontroller = TextEditingController();
  // controller for date picker textfield
  TextEditingController dateinput = TextEditingController();
  String selecteddate = '';
  //variable used for dropdown deparment and designation  id which is used to post data
  String? dropdwndeptid;
  String? dropdwndesignid;
  //variable used for dropdown deparment and designation name which is used to display data by name
  String? dropdwndeptname;
  String? dropdwndesignname;
  //empty list to store enter id
  List<String> alldept_id = [];
  List<String> alldept_name = [];
  List<String> alldesign_id = [];
  List<String> alldesign_name = [];
  final String _selecteddate = '';
  TextEditingController _geolocation_lati = TextEditingController();
  String tokenn = '';
  // image picker
  bool click = false;

  File? _image;
  Future getimage(void Function(void Function()) setState) async {
    // final prefs = await SharedPreferences.getInstance();
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    if (image != null) {
      final tempimage = File(image.path);
      //prefs.setString("image", image.path);
      setState(() {
        _image = tempimage;
      });
    } else {
      log("error");
    }
  }

  @override
  void initState() {
    super.initState();
    // getdata is a new function which defined at bottom
    getdata();
  }

  getdata() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    final empdatafinal = await ApiService().getEmoloyeeModel(token);
    final detpdata = await ApiService().getDepartmentModel(token);
    final designdata = await ApiService().getDesignationModel(token);
    setState(() {
      newemplist = empdatafinal;
      newdeptlist = detpdata;
      newdesignlist = designdata;
      tokenn = token;
    });

    //used for dropdounbutton
    for (var element in newdeptlist) {
      alldept_id.add(element.id.toString());
    }
    for (var element in newdeptlist) {
      alldept_name.add(element.name.toString());
    }
    for (var element in newdesignlist) {
      alldesign_id.add(element.id.toString());
    }
    for (var element in newdesignlist) {
      alldesign_name.add(element.name.toString());
    }
    log(alldept_name.toString());
    log(alldesign_name.toString());
  }

  getdata2() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    final empdatafinal = await ApiService().getEmoloyeeModel(token);
    final detpdata = await ApiService().getDepartmentModel(token);
    final designdata = await ApiService().getDesignationModel(token);
    setState(() {
      newemplist = empdatafinal;
      newdeptlist = detpdata;
      newdesignlist = designdata;
      tokenn = token;
    });
  }

  late LocationPermission permission;

  Future _getlocation() async {
    // bool serviceEnabled;
    // LocationPermission permission;
    // serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (serviceEnabled) {
    //   return Future.error('Location services are desabled');
    // }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Position? position;
  Position? _position;
  String? _latitude;
  String? _longitude;
  String? _joinlocation;

  Future _setlocation(void Function(void Function()) setState) async {
    Position position = await _getlocation();
    setState(() {
      _position = position;
      _latitude = position.latitude.toString();
      _longitude = position.longitude.toString();
      _joinlocation = " $_latitude,$_longitude";
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return StatefulBuilder(
                  builder: (BuildContext context, setState) {
                    return AlertDialog(
                      title: const Text(
                        "Add new Employees",
                        style: TextStyle(fontSize: 18),
                      ),
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
                                onPressed: () async {
                                  log(namecontroller.toString());
                                  EasyLoading.show(status: "Please wait...");
                                  if (namecontroller.text.isEmpty ||
                                      dropdwndeptid == null ||
                                      dropdwndesignid == null ||
                                      selecteddate.isEmpty ||
                                      _joinlocation == null ||
                                      _image!.path.isEmpty) {
                                    log("Data not completely fill_up");
                                    EasyLoading.dismiss();
                                    Navigator.pop(context);
                                  } else {
                                    await ApiService()
                                        .postEmoloyeeModel(
                                          name: namecontroller.text,
                                          deptid: dropdwndeptid.toString(),
                                          designid: dropdwndesignid.toString(),
                                          dob: selecteddate.toString(),
                                          token: tokenn,
                                          geoLocation: _joinlocation!,
                                          image: _image!.path,
                                        )
                                        .whenComplete(
                                            () => EasyLoading.dismiss())
                                        .whenComplete(() => getdata())
                                        .whenComplete(() {
                                      setState(
                                        () {
                                          alldept_id = [];
                                          alldept_name = [];
                                          alldesign_id = [];
                                          alldesign_name = [];
                                          namecontroller.clear();
                                          dropdwndeptname = null;
                                          dropdwndesignname = null;
                                          _latitude = null;
                                          _longitude = null;
                                          _image = null;

                                          selecteddate = "";
                                        },
                                      );
                                    }).whenComplete(
                                            () => Navigator.pop(context));
                                  }
                                },
                                child: const Text(
                                  "Add",
                                  style: TextStyle(fontSize: 17),
                                )),
                          ],
                        )
                      ],
                      content: SingleChildScrollView(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: GestureDetector(
                                  onTap: () {
                                    log("press");
                                    getimage(setState);
                                  },
                                  child: _image != null
                                      ? Image.file(
                                          _image!,
                                          height: 90,
                                          width: 100,
                                          fit: BoxFit.fill,
                                        )
                                      : Image.asset(
                                          "assets/images/profile.jpg", // icon for click image from camera
                                          fit: BoxFit.cover,
                                          height: 90,
                                          width: 100,
                                        ),
                                ),
                              ),
                              TextFormField(
                                controller: namecontroller,
                                decoration: const InputDecoration(
                                  hintText: "Name",
                                ),
                              ),
                              DateTimePicker(
                                type: DateTimePickerType.date,
                                dateMask: 'd-MM-yyyy',
                                firstDate: DateTime(1980),
                                lastDate: DateTime(2023),
                                dateLabelText: 'Date Of Birth',
                                onChanged: (val) {
                                  setState(() {
                                    selecteddate = val;
                                  });
                                },
                                validator: (val) {
                                  print(val);
                                  return null;
                                },
                                onSaved: (val) => print(val),
                              ),
                              DropdownSearch<String>(
                                popupProps: const PopupProps.menu(
                                  constraints:
                                      BoxConstraints.tightFor(height: 170),
                                  searchFieldProps: TextFieldProps(
                                      decoration: InputDecoration(
                                          hintText: "Search",
                                          border: OutlineInputBorder(),
                                          constraints:
                                              BoxConstraints(maxHeight: 40))),
                                  showSearchBox: true,
                                  showSelectedItems: true,
                                ),
                                items: alldept_name,
                                dropdownDecoratorProps:
                                    const DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                                labelText: "Department ",
                                                hintText:
                                                    "Choose your department")),
                                onChanged: (String? newvalue) {
                                  setState(() {
                                    dropdwndeptname = newvalue as String;
                                  });
                                  int ind =
                                      alldept_name.indexOf(dropdwndeptname!);
                                  dropdwndeptid = alldept_id[ind];
                                },
                              ),
                              DropdownSearch<String>(
                                popupProps: const PopupProps.menu(
                                  constraints:
                                      BoxConstraints.tightFor(height: 170),
                                  searchFieldProps: TextFieldProps(
                                      decoration: InputDecoration(
                                          hintText: "Search",
                                          border: OutlineInputBorder(),
                                          constraints:
                                              BoxConstraints(maxHeight: 40))),
                                  showSearchBox: true,
                                  showSelectedItems: true,
                                ),
                                items: alldesign_name,
                                dropdownDecoratorProps:
                                    const DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                                //constraints: ,
                                                labelText: "Designation ",
                                                hintText:
                                                    "Choose your designtion")),
                                onChanged: (String? value) {
                                  setState(() {
                                    dropdwndesignname = value as String;
                                  });
                                  int inddesign = alldesign_name
                                      .indexOf(dropdwndesignname!);
                                  dropdwndesignid = alldesign_id[inddesign];
                                },
                              ),
                              TextButton.icon(
                                onPressed: () {
                                  setState(
                                    () {
                                      click = true;
                                    },
                                  );
                                  _setlocation(setState);
                                },
                                icon: const Icon(
                                  Icons.location_on_outlined,
                                  size: 17,
                                ),
                                label: const Text(
                                  "Geo-Location :",
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              _position != null
                                  ? Column(
                                      children: [
                                        Row(
                                          children: [
                                            const Text("Latitude : ",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Color.fromARGB(
                                                        255, 135, 148, 155),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(_latitude.toString(),
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16))
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "Longitude : ",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Color.fromARGB(
                                                      255, 135, 148, 155),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(_longitude.toString(),
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16))
                                          ],
                                        ),
                                      ],
                                    )
                                  : click
                                      ? CircularProgressIndicator()
                                      : Text("No Location found")
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Employee List"),
      ),
      body: newemplist.isEmpty
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
              color: const Color.fromARGB(255, 236, 234, 234),
              child: ListView.builder(
                itemCount: newemplist.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        int ind = alldept_id
                            .indexOf(newemplist[index].departmentId.toString());
                        String depname = alldept_name[ind];
                        int inddesign = alldesign_id.indexOf(
                            newemplist[index].designationId.toString());
                        String designname = alldesign_name[inddesign];

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EmployeeDetailsPage(
                                    name: newemplist[index].name.toString(),
                                    dob:
                                        "${newemplist[index].dateOfBirth!.day}-${newemplist[index].dateOfBirth!.month}-${newemplist[index].dateOfBirth!.year}",
                                    deptname: depname,
                                    designname: designname,
                                    geoLocation: newemplist[index].geoLocation,
                                    image: newemplist[index].image)));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white),
                        child: ListTile(
                            title: Text(newemplist[index].name.toString()),
                            trailing: PopupMenuButton(
                              itemBuilder: (context) => [
                                const PopupMenuItem<int>(
                                    value: 1,
                                    //height: 10,
                                    child: Text(
                                      "Delete",
                                      style: TextStyle(fontSize: 20),
                                    )),
                                const PopupMenuItem<int>(
                                    value: 2,
                                    height: 10,
                                    child: Text(
                                      "Update",
                                      style: TextStyle(fontSize: 20),
                                    ))
                              ],
                              onSelected: (value) {
                                if (value == 1) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return StatefulBuilder(
                                        builder: (context, setState) {
                                          return AlertDialog(
                                            content: const Text(
                                                'Are you sure to delete'),
                                            title: const Text(
                                              'Confirm ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            actions: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  ElevatedButton(
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(
                                                                    Colors.red),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        "Cancel",
                                                        style: TextStyle(
                                                            fontSize: 17),
                                                      )),
                                                  ElevatedButton(
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(Colors
                                                                    .green),
                                                      ),
                                                      onPressed: () {
                                                        ApiService()
                                                            .deleteEmployeeModel(
                                                                id: newemplist[
                                                                        index]
                                                                    .id
                                                                    .toString(),
                                                                token: tokenn)
                                                            .whenComplete(() =>
                                                                getdata2());

                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        "Ok",
                                                        style: TextStyle(
                                                            fontSize: 17),
                                                      )),
                                                ],
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  );
                                } else {
                                  int indupdept = alldept_id.indexOf(
                                      newemplist[index]
                                          .departmentId
                                          .toString());

                                  int indupdesign = alldesign_id.indexOf(
                                      newemplist[index]
                                          .designationId
                                          .toString());

                                  setState(() {
                                    namecontroller.text =
                                        newemplist[index].name.toString();
                                    dropdwndeptid = newemplist[index]
                                        .departmentId
                                        .toString();
                                    dropdwndesignid = newemplist[index]
                                        .designationId
                                        .toString();
                                    dropdwndeptname = alldept_name[indupdept];
                                    dropdwndesignname =
                                        alldesign_name[indupdesign];
                                    selecteddate =
                                        "${newemplist[index].dateOfBirth!.year}-${newemplist[index].dateOfBirth!.month}-${newemplist[index].dateOfBirth!.day}";
                                    //;
                                  });
                                  log(selecteddate);
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return StatefulBuilder(
                                          builder:
                                              (BuildContext context, setState) {
                                            return AlertDialog(
                                              title: const Text(
                                                  "Update Employees"),
                                              actions: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    ElevatedButton(
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                      .red),
                                                        ),
                                                        onPressed: () {
                                                          setState(() {
                                                            namecontroller
                                                                .clear();
                                                            dropdwndeptname =
                                                                null;
                                                            dropdwndesignname =
                                                                null;
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                          "Cancel",
                                                          style: TextStyle(
                                                              fontSize: 17),
                                                        )),
                                                    ElevatedButton(
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(const Color
                                                                          .fromARGB(
                                                                      255,
                                                                      22,
                                                                      177,
                                                                      27)),
                                                        ),
                                                        onPressed: () {
                                                          log(namecontroller
                                                              .toString());

                                                          ApiService()
                                                              .updateEmployeeModel(
                                                                id: newemplist[
                                                                        index]
                                                                    .id
                                                                    .toString(),
                                                                name:
                                                                    namecontroller
                                                                        .text,
                                                                deptid: dropdwndeptid
                                                                    .toString(),
                                                                designid:
                                                                    dropdwndesignid
                                                                        .toString(),
                                                                dob: selecteddate
                                                                    .toString(),
                                                                token: tokenn,
                                                              )
                                                              .whenComplete(() =>
                                                                  getdata());
                                                          setState(() {
                                                            alldept_id = [];
                                                            alldept_name = [];
                                                            alldesign_id = [];
                                                            alldesign_name = [];
                                                            namecontroller
                                                                .clear();
                                                            dropdwndeptname =
                                                                null;
                                                            dropdwndesignname =
                                                                null;
                                                          });

                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                          "Add",
                                                          style: TextStyle(
                                                              fontSize: 17),
                                                        )),
                                                  ],
                                                )
                                              ],
                                              content: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.4,
                                                child: Column(
                                                  children: [
                                                    TextFormField(
                                                      controller:
                                                          namecontroller,
                                                      decoration:
                                                          const InputDecoration(
                                                              hintText: "Name"),
                                                    ),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    DateTimePicker(
                                                      // controller:
                                                      //     TextEditingController(
                                                      //         text:
                                                      //             selecteddate),
                                                      type: DateTimePickerType
                                                          .date,
                                                      dateMask: 'd-MM-yyyy',

                                                      initialValue:
                                                          _selecteddate,
                                                      //DateTime.now().toString(),
                                                      firstDate: DateTime(1980),
                                                      lastDate: DateTime(2023),
                                                      //icon: const Icon(Icons.event),
                                                      dateLabelText:
                                                          selecteddate,

                                                      onChanged: (val) {
                                                        //log(val);
                                                        setState(() {
                                                          selecteddate = val;
                                                          log(val);
                                                        });
                                                      },
                                                      validator: (val) {
                                                        print(val);
                                                        return null;
                                                      },
                                                      onSaved: (val) =>
                                                          print(val),
                                                    ),
                                                    const SizedBox(
                                                      height: 6,
                                                    ),
                                                    DropdownSearch<String>(
                                                      selectedItem:
                                                          dropdwndeptname,
                                                      popupProps:
                                                          const PopupProps.menu(
                                                        constraints:
                                                            BoxConstraints
                                                                .tightFor(
                                                                    height:
                                                                        170),
                                                        searchFieldProps: TextFieldProps(
                                                            decoration: InputDecoration(
                                                                hintText:
                                                                    "Search",
                                                                border:
                                                                    OutlineInputBorder(),
                                                                constraints:
                                                                    BoxConstraints(
                                                                        maxHeight:
                                                                            40))),
                                                        showSearchBox: true,
                                                        showSelectedItems: true,
                                                      ),
                                                      items: alldept_name,
                                                      dropdownDecoratorProps:
                                                          const DropDownDecoratorProps(
                                                              dropdownSearchDecoration:
                                                                  InputDecoration(
                                                                      labelText:
                                                                          "Department ",
                                                                      hintText:
                                                                          "Choose your department")),
                                                      onChanged:
                                                          (String? newvalue) {
                                                        setState(() {
                                                          dropdwndeptname =
                                                              newvalue
                                                                  as String;
                                                        });
                                                        int ind = alldept_name
                                                            .indexOf(
                                                                dropdwndeptname!);
                                                        dropdwndeptid =
                                                            alldept_id[ind];
                                                      },
                                                    ),
                                                    DropdownSearch<String>(
                                                      selectedItem:
                                                          dropdwndesignname,
                                                      popupProps:
                                                          const PopupProps.menu(
                                                        constraints:
                                                            BoxConstraints
                                                                .tightFor(
                                                                    height:
                                                                        170),
                                                        searchFieldProps: TextFieldProps(
                                                            decoration: InputDecoration(
                                                                hintText:
                                                                    "Search",
                                                                border:
                                                                    OutlineInputBorder(),
                                                                constraints:
                                                                    BoxConstraints(
                                                                        maxHeight:
                                                                            40))),
                                                        showSearchBox: true,
                                                        showSelectedItems: true,
                                                      ),
                                                      items: alldesign_name,
                                                      dropdownDecoratorProps:
                                                          const DropDownDecoratorProps(
                                                              dropdownSearchDecoration:
                                                                  InputDecoration(
                                                                      //constraints: ,
                                                                      labelText:
                                                                          "Designation ",
                                                                      hintText:
                                                                          "Choose your designtion")),
                                                      onChanged:
                                                          (String? value) {
                                                        setState(() {
                                                          dropdwndesignname =
                                                              value as String;
                                                        });
                                                        int inddesign =
                                                            alldesign_name.indexOf(
                                                                dropdwndesignname!);
                                                        dropdwndesignid =
                                                            alldesign_id[
                                                                inddesign];
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      });
                                }
                              },
                            )),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
