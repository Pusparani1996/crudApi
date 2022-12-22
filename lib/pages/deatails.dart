import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String name;
  final String deptname;
  final String designname;
  final String dob;
  final String image;
  final String geoLocation;
  const ProfilePage(
      {Key? key,
      required this.name,
      required this.deptname,
      required this.designname,
      required this.dob,
      required this.image,
      required this.geoLocation})
      : super(key: key);

  final double coverheight = 190;
  final double profileheight = 80;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 196, 191, 191),
          title: Text("Profile"),
        ),
        body: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            designstack(),
            Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
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
        ));
  }

  Widget coverImage() => Container(
        width: double.infinity,
        height: coverheight,
        child: Image.network(
            "http://phpstack-598410-2859373.cloudwaysapps.com/$image"),
      );
  Widget profileImage() => Container(
        child: CircleAvatar(
          radius: profileheight,
          backgroundImage: NetworkImage(
              "http://phpstack-598410-2859373.cloudwaysapps.com/$image"),
        ),
      );
  Widget designstack() {
    final bottom = profileheight / 0.5;
    final top = coverheight -
        profileheight /
            1.3; // used for positoin of profile imager over cover image
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          //child: coverImage()
        ),
        Positioned(
            top: top, //position of profile image
            child: profileImage()),
      ],
    );
  }
}
