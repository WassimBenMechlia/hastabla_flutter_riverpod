import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'node.dart';

class HashTableNotifier extends StateNotifier<List<Node<String>>> {
  HashTableNotifier()
      : super(List.generate(10, (index) => Node<String>(index.toString())));

  void add(String key, BuildContext context) {
    int index = _hash(key);
    final newNode = Node<String>(key);
    Node<String>? tmp = state[index];
    while (tmp?.next != null) {
      tmp = tmp?.next;
    }
    if (tmp?.value != key) {
      tmp?.next = newNode;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("value already exists"),
        ),
      );
    }
    state = List.from(state);
  }

  void delete(String key, BuildContext context) {
    int index = _hash(key);
    Node<String>? tmp = state[index];
    Node<String>? prevPointer = tmp;
    while (tmp?.value != key && tmp?.next != null) {
      prevPointer = tmp;
      tmp = tmp?.next;
    }
    if (tmp?.value != key) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("value doesn't exists"),
        ),
      );
    } else {
      prevPointer?.next = tmp?.next;
    }
    state = List.from(state);
  }

  void empty(BuildContext context) {
    for (int i = 0; i < state.length; i++) {
      state[i].next = null;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("hashtable successfully emptied"),
      ),
    );
    state = List.from(state);
  }

  int _hash(String key) {
    int hashValue = 0;
    key.split('').forEach((ch) => hashValue += key.codeUnitAt(key.indexOf(ch)));
    return hashValue % state.length;
  }
}

final hashTableProvider =
    StateNotifierProvider<HashTableNotifier, List<Node<String>>>((ref) {
  return HashTableNotifier();
});
