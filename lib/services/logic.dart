import 'package:rxdart/subjects.dart';

/// just some service code that i didnt think belonged in any other service
class LogicService {
    final _selectedTodosStresm = BehaviorSubject<List<int>>();
    List<int> _selectedTodos = [];

  Stream subscribeToSelectedTodosStresm() {
    return _selectedTodosStresm.stream;
  }

  void updateSelectedTodos(selectedTodos) {
    _selectedTodos = selectedTodos;
    _selectedTodosStresm.add(selectedTodos);
  }

  List<int> getSelectedTodos() => _selectedTodos;
}

final LogicService logicService = LogicService();