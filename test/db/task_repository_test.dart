// import 'package:flutter/material.dart';
// import 'package:mockito/annotations.dart';
// import 'package:test/test.dart';
// import 'package:todo_app/db/task_repository.dart';
// import 'package:todo_app/models/task.dart';
// import 'package:todo_app/models/todo.dart';

// import 'task_repository_test.mocks.dart';

// @GenerateMocks([TaskRepository])
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   group('Task テスト', () {
//     var tasks = MockTaskRepository();
//     Task new_task = Task(description: "task test", is_checked: false, is_enabled: false, timer: DateTime.now(),todo_id: 0, createdAt: createdAt, updatedAt: updatedAt)
//     test('Task 追加', () async {
//       var text = 'task test';
//       new_todo = await tasks.create(text);

//       var add_todo = todos.todo_items.where((e) => e.description == text).first;
//       expect(add_todo.description == text, true);
//     });

//     test('Todo 更新', () async {
//       var text = 'new todo test';
//       new_todo.description = text;
//       await todos.update(new_todo);

//       var t = todos.todo_items.first;
//       expect(t.description == text, true);
//     });

//     test('Todo 削除', () async {
//       await todos.delete(new_todo);
//       expect(todos.todo_items.length == 0, true);
//     });
//   });
// }
