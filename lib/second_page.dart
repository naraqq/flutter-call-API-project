import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final url = "http://192.168.10.251/v2/sendSms/history/80105376?pageNumber=1";
  var _postJson = [];

  void fetchPosts() async {
    try {
      final response = await http.get(Uri.parse(url));
      final jsonData = jsonDecode(response.body) as List;
      print(response);
      setState(() {
        _postJson = jsonData;
      });
    } catch (err) {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPosts();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: _postJson.length,
          itemBuilder: (context, i) {
            final post = _postJson[i];
            return Text("Title: ${post["title"]}\n Body: ${post["body"]}\n\n");
          },
        ),
      ),
    );
  }
}
