import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class Model {
  final String content;
  final String phone;
  final String date;

  Model._({required this.content, required this.phone, required this.date});

  factory Model.fromJson(Map<String, dynamic> json) {
    return new Model._(
      content: json['content'],
      phone: json['phone'],
      date: json['createdDate']
    );
  }
}

class SecondPage extends StatefulWidget {
  String value = "";
  SecondPage({Key? key, required this.value}) : super(key: key);
  @override
  _SecondPageState createState() => _SecondPageState(value);
}

class _SecondPageState extends State<SecondPage> {
  String value;
  _SecondPageState(this.value);
  late var url =
      "http://192.168.10.251/v2/sendSms/history/${value}?pageNumber=1&pageSize=10";
  var _postJson = [];

  void fetchPosts() async {
    try {
      final response = await http.get(Uri.parse(url),
          headers: {"Authorization": "0f0c524380b8474a8eeda2830bf3d126"});
      print(response.body);
      final jsonData = json
          .decode(response.body)['smsHistory']
          .map((data) => Model.fromJson(data))
          .toList();
      setState(() {
        _postJson = jsonData;
      });
    } catch (err) {}
  }

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("API"),
        backgroundColor: Colors.blueGrey[600],
      ),
      body: Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: ListView.builder(
                itemCount: _postJson.length,
                itemBuilder: (context, i) {
                  final post = _postJson[0];

                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[600],
                          borderRadius: const BorderRadius.all(Radius.circular(
                                  12.0) //                 <--- border radius here
                              ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "phone: ${post.phone} \n\n SMS: ${post.content} \n ${post.date} \n",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                        )),
                  );
                },
              ),
            ),
          )
          // child: Text(value),
          ),
    );
  }
}
