import 'package:akademiapp/home/todo_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<TodoModel>> getTodos() async {
    List<TodoModel> todos = [];

    QuerySnapshot querySnapshot = await _firestore.collection('todo').get();

    querySnapshot.docs.map((doc) {
      TodoModel todoModel = TodoModel(
          id: doc.id,
          title: doc['title'],
          content: doc['content'],
          isDone: doc['isDone']);
      todos.add(todoModel);
    }).toList();

    return todos;
  }

  Future<void> addTodo(TodoModel todoModel) async {
    var id = _firestore.collection('todo').doc().id;
    _firestore.collection('todo').doc(id).set({
      'title': todoModel.title,
      'content': todoModel.content,
      'id': id,
      'isDone': false,
    });
  }

  Future<void> updateTodo(TodoModel todoModel) async {
    _firestore.collection('todo').doc(todoModel.id).set({
      'title': todoModel.title,
      'content': todoModel.content,
      'id': todoModel.id,
      'isDone': todoModel.isDone,
    });
  }
}
