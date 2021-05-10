// import 'package:mockito/mockito.dart' as _i1;
// import 'package:todo_app/db/task_repository.dart' as _i2;
// import 'package:todo_app/models/task.dart';

// class MockTaskRepository extends _i1.Mock implements _i2.TaskRepository {
//   MockTaskRepository() {
//     _i1.throwOnMissingStub(this);
//   }

//   List<Task> tasklist = [];

//   List<Task> get task_items => tasklist;

//   @override
//   Future<Task> create(String text) async {
//     DateTime now = DateTime.now();

//     final Map<String, dynamic> row = {
//       'id': todo_items.length + 1,
//       'description': text,
//       'created_at': now.toString(),
//       'updated_at': now.toString(),
//     };
//     Todo todo = Todo.fromMap(row);
//     this.todolist.insert(0, todo);
//     return todo;
//   }

//   @override
//   Future<void> update(Todo todo) async {
//     String now = DateTime.now().toString();
//     final row = {
//       'id': todo.id,
//       'description': todo.description,
//       'updated_at': now,
//     };

//     var _todolist = this.todolist;
//     _todolist.asMap().forEach((i, v) {
//       if (v.id == todo.id) {
//         print('v ${v.id} / t ${todo.id}');
//         this.todolist[i] = todo;
//       }
//     });
//   }

//   @override
//   Future<void> delete(Todo todo) async {
//     this.todolist.remove(todo);
//   }
// }
