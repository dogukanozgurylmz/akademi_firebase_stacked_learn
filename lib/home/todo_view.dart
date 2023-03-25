import 'package:akademiapp/home/todo_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _titletextController = TextEditingController();
    TextEditingController _contenttextController = TextEditingController();

    return ViewModelBuilder<TodoViewModel>.reactive(
      viewModelBuilder: () => TodoViewModel(),
      onViewModelReady: (viewModel) => viewModel.getTodos(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              viewModel.todoAdd(
                _titletextController.text,
                _contenttextController.text,
              );
              _titletextController.clear();
              _contenttextController.clear();
            },
          ),
          body: Column(
            children: [
              TextField(
                onChanged: (value) {
                  _titletextController.text = value;
                },
              ),
              TextField(
                onChanged: (value) {
                  _contenttextController.text = value;
                },
              ),
              Expanded(
                child: viewModel.isBusy
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: viewModel.todos.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(viewModel.todos[index].title),
                            subtitle: Text(viewModel.todos[index].content),
                            leading: Checkbox(
                              value: viewModel.todos[index].isDone,
                              onChanged: (value) {
                                viewModel.todoUpdate(
                                  viewModel.todos[index].title,
                                  viewModel.todos[index].content,
                                  viewModel.todos[index].id,
                                  value!,
                                );
                              },
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
