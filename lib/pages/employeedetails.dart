import 'package:flutter/material.dart';

class EmployeeDetailsPage extends StatelessWidget {
  final String name;
  final String deptname;
  final String designname;
  final String dob;
  final String image;
  final String geoLocation;

  const EmployeeDetailsPage(
      {super.key,
      required this.name,
      required this.dob,
      required this.deptname,
      required this.designname,
      required this.image,
      required this.geoLocation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          //color: Color.fromARGB(255, 149, 164, 191),
          child: Column(
            children: [
              ClipOval(
                child: Image(
                  image: NetworkImage(
                    "http://phpstack-598410-2859373.cloudwaysapps.com/$image",
                  ),
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.width / 2,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 15,
                decoration: BoxDecoration(
                    // border: Border.all(color: Colors.black)
                    ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      "Name :  ",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      name,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 15,
                decoration: BoxDecoration(
                    //border: Border.all(color: Colors.black)
                    ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      "Date Of Birth :  ",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      dob,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 15,
                decoration: BoxDecoration(
                    //border: Border.all(color: Colors.black)
                    ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      "Department Name :  ",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      deptname,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 15,
                // decoration:
                //     BoxDecoration(
                //       border: Border.all(color: Colors.black)
                //       ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      "Designation Name :  ",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      designname,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 15,
                // decoration:
                //     BoxDecoration(
                //       border: Border.all(color: Colors.black)
                //       ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      "Geo_Location :  ",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      geoLocation,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
