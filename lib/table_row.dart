import 'package:flutter/material.dart';

import 'node.dart';

Widget MyTableRow(BuildContext context, Node<String> row) {
  List<String> valuesList = [];
  Node<String> tmp = row;
  print(tmp.value);

  while (tmp.next != null) {
    valuesList.add(tmp.value!);
    print(tmp.value);
    tmp = tmp.next!;
  }
  valuesList.add(tmp.value!);

  return Container(
    height: 30,
    child: ListView.builder(
      itemCount: valuesList.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Container(
            width: 100,
            height: 30,
            color: Colors.grey[200],
            child: Center(
              child: Text(valuesList[index].toString()),
            ),
          ),
        );
      },
    ),
  );
}
