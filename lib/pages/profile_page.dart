import 'dart:convert';

import 'package:family_shop/home.dart';
import 'package:family_shop/model/user.dart';
import 'package:family_shop/shop_api.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final User user;
  const ProfilePage({
    super.key,
    required this.user,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoading = false;
  late User userModel;

  @override
  void initState() {
    super.initState();
    requestBackend();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(6),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(50)),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    //hatoooo
                    //dm xatoooo
                    //ilova iwlamidi
                  );
                },
                icon: Icon(size: 30, Icons.arrow_back)),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(17),
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/person.webp"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> requestBackend() async {
    setState(() {
      isLoading = true;
    });
    final response = await ShopApi.GET('${ShopApi.USER_LIST}/2', {});
    final user = User.fromJson(jsonDecode(response.toString()));
    userModel = user;
    setState(() {
      isLoading = false;
    });
  }
}
