import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_food_delivery/pages/home/home_page.dart';
import 'package:new_food_delivery/route/routing_page.dart';
import 'package:new_food_delivery/widgets/my_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEdit = false;

  TextEditingController fullName =
      TextEditingController(text: userModel.fullName);
  TextEditingController emailAddress =
      TextEditingController(text: userModel.emailAddress);

  Widget textFromField({required String hintText}) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[300],
      ),
      child: ListTile(
        leading: Text(hintText),
      ),
    );
  }

  Widget nonEditTextField() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("images/non_profile.jpg"),
              radius: 50,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        textFromField(hintText: userModel.fullName),
        SizedBox(
          height: 10,
        ),
        textFromField(hintText: userModel.emailAddress),
      ],
    );
  }

  Widget editTextField() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("images/non_profile.jpg"),
              radius: 50,
            ),
          ],
        ),
        TextFormField(
          controller: fullName,
          decoration: InputDecoration(
            hintText: "fullName",
          ),
        ),
        TextFormField(
          controller: emailAddress,
          decoration: InputDecoration(
            hintText: "emailAddres",
          ),
        ),
        SizedBox(
          height: 10,
        ),
        MyButton(
          onPressed: () {
            buildUpdateProfile();
          },
          text: "Up date",
        )
      ],
    );
  }

  Future buildUpdateProfile() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(
      {
        "fullname": fullName.text,
        "emailAdress": emailAddress.text,
      },
    ).then(
      (value) => RoutingPage.goTonext(
        context: context,
        navigateTo: HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: isEdit
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isEdit = false;
                  });
                },
                icon: Icon(Icons.close),
              )
            : IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                ),
              ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isEdit = true;
              });
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: isEdit ? editTextField() : nonEditTextField(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
