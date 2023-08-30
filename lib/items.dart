import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Items extends StatelessWidget {
  List<dynamic> items;
  Items({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          'Following are your tasks',
          style: TextStyle(fontSize: 22),
        ),
        SizedBox(
          height: 20,
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              for (Map<String, dynamic> item in items)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                        value: item['isDone'],
                        onChanged: ((value) async {
                          String id = item['_id'];
                          final response = await http.put(Uri.parse(
                              "http://192.168.56.129:3000/api/todo/done/$id"));
                          if (response.statusCode == 200) {
                            print('done');
                            print(response.body);
                          } else {
                            throw Exception('Failed to load tasks');
                          }
                        })),
                    Text(
                      item['description'],
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                        item['priority'] == 1
                            ? '(high)'
                            : item['priority'] == 2
                                ? '(medium)'
                                : '(low)',
                        style: TextStyle(fontSize: 18))
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
