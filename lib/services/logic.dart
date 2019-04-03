import 'package:rxdart/subjects.dart';

/// just some service code that i didnt think belonged in any other service
class LogicService {
    final _selectedTodosStresm = BehaviorSubject<List<int>>();
    List<int> _selectedTodos = [];

  Stream subscribeToSelectedTodosStresm() {
    return _selectedTodosStresm.stream;
  }



  void updateSelectedTodos(selectedTodos) {
    print(selectedTodos);
    _selectedTodos = selectedTodos;
    _selectedTodosStresm.add(_selectedTodos);
  }

  void addSelectedTodo(selectedTodo) {
    _selectedTodos.add(selectedTodo);
    _selectedTodosStresm.add(_selectedTodos);
  }

  void removeTodoFromSelected(todo) {
    _selectedTodos.remove(todo);
    _selectedTodosStresm.add(_selectedTodos);
  }

  bool checkSelectedTodo(todo) {
    return _selectedTodos.contains(todo);
  }

  List<int> getSelectedTodos() => _selectedTodos;
}

final LogicService logicService = LogicService();