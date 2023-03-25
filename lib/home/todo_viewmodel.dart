import 'package:akademiapp/home/todo_model.dart';
import 'package:akademiapp/services/firebase_service.dart';
import 'package:stacked/stacked.dart';

class TodoViewModel extends BaseViewModel {
  FirebaseService _firebaseService = FirebaseService();

  List<TodoModel> _todos = [];

  List<TodoModel> get todos => _todos;

  Future<void> getTodos() async {
    setBusy(true);
    _todos = await _firebaseService.getTodos();
    setBusy(false);
    notifyListeners();
  }

  Future<void> todoAdd(String title, String content) async {
    TodoModel todoModel =
        TodoModel(title: title, content: content, id: '', isDone: false);
    _firebaseService.addTodo(todoModel);
    await getTodos();
    notifyListeners();
  }

  Future<void> todoUpdate(
      String title, String content, String id, bool value) async {
    TodoModel todoModel =
        TodoModel(title: title, content: content, id: id, isDone: value);
    _firebaseService.updateTodo(todoModel);
    await getTodos();
    notifyListeners();
  }
}
