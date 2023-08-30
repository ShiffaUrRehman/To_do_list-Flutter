import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:to_do_list/items.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'To Do List',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String data = 'Fetching data...';
  late Future items;

  @override
  void initState() {
    super.initState();
    items = fetchData();
  }

  Future fetchData() async {
    final response =
        await http.get(Uri.parse('http://192.168.56.129:3000/api/todo'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter Node.js Connection'),
        ),
        body: Center(
          child: FutureBuilder(
            future: items,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Items(items: snapshot.data);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ));
  }
}
