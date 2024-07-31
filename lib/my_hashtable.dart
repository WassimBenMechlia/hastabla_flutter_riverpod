import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hashtable_flutter/hastacble_provider.dart';
import 'package:hashtable_flutter/node.dart';
import 'package:hashtable_flutter/table_row.dart';

class MyHashTable extends ConsumerWidget {
  final myController = TextEditingController();
  int bucketSize = 10;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hashTable = ref.watch(hashTableProvider);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: bucketSize,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MyTableRow(context, hashTable[index]),
                      );
                    },
                  ),
                ),
                TextField(
                  controller: myController,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      ref
                          .read(hashTableProvider.notifier)
                          .add(myController.text, context);
                      myController.clear();
                    },
                    child: Text("Add +"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      ref
                          .read(hashTableProvider.notifier)
                          .delete(myController.text, context);
                      myController.clear();
                    },
                    child: Text("Delete +"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(hashTableProvider.notifier).empty(context);
                      myController.clear();
                    },
                    child: Text("Empty +"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
