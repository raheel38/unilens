import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import "package:unilens/config.dart";

class AddPost extends StatefulWidget {
  final String token;
  const AddPost({required this.token, Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  late String userId;
  TextEditingController _postTitle = TextEditingController();
  TextEditingController _postContent = TextEditingController();

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['_id'];
  }

  void PostToCommunity() async {
    if (_postTitle.text.isNotEmpty && _postContent.text.isNotEmpty) {
      // Creating the request body to send to the backend
      var signupBody = {
        "userId": userId,
        "title": _postTitle.text,
        "desc": _postContent.text
      };

      // Making a POST request to the backend
      var response = await http.post(
        Uri.parse(addPost),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(signupBody),
      );

      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['status']);

      if (jsonResponse['status']) {
        // Clear the input fields and close the dialog
        _postTitle.clear();
        _postContent.clear();
        Navigator.pop(context);
      } else {
        print("Something Went Wrong!");
      }
    } else {
      print("Fields cannot be empty");
    }
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add a post '),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _postTitle,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Title",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: _postContent,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Description",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                PostToCommunity();
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayTextInputDialog(context),
        backgroundColor:
            const Color(0xFF450000), // Set the button's background color
        child: const Icon(
          Icons.add,
          color: Colors.white, // Set the icon color to white
        ),
        tooltip: 'Add-ToDo',
      ),
    );
  }
}
