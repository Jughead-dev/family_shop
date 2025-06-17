import 'package:family_shop/model/product.dart';
import 'package:family_shop/model/user.dart';
import 'package:flutter/material.dart';

class UserItem extends StatefulWidget {
  final User user;
  const UserItem({
    super.key,
    required this.user,
  });

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
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
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
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
              SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.all(17),
                child: Text(
                  widget.user.email,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
              SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.all(17),
                child: Text(
                  widget.user.password,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
              SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.all(17),
                child: Text(
                  widget.user.phone,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
              SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.all(17),
                child: Text(
                  widget.user.username,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
              SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.all(17),
                child: Text(
                  widget.user.address.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
              SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.all(17),
                child: Text(
                  widget.user.id.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
              SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.all(17),
                child: Text(
                  widget.user.name.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
              SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.all(17),
                child: Text(
                  "v dagan narsashu ${widget.user.v.toString()}",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void requestBackend() async {
  final response = await Product.GET();
}
