import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';
import 'package:todo_app/db/todo_repository.dart';
import 'package:todo_app/models/todo.dart';

import 'todo_repository_test.mocks.dart';

@GenerateMocks([TodoRepository])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('Todo テスト', () {
    var todos = MockTodoRepository();
    Todo new_todo;
    test('Todo 追加', () async {
      var text = 'todo test';
      new_todo = await todos.create(text);

      var add_todo = todos.todo_items.where((e) => e.description == text).first;
      expect(add_todo.description == text, true);
    });

    test('Todo 更新', () async {
      var text = 'new todo test';
      new_todo.description = text;
      await todos.update(new_todo);

      var t = todos.todo_items.first;
      expect(t.description == text, true);
    });

    test('Todo 削除', () async {
      await todos.delete(new_todo);
      expect(todos.todo_items.length == 0, true);
    });
  });
}
