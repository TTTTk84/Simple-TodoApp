// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:todo_app/models/task.dart';
// import 'package:todo_app/models/todo.dart';
// import 'package:todo_app/viewmodel/todo_provider.dart';
// import 'package:todo_app/widgets/addTodoBottomSheet.dart';

// class DetailPage extends StatefulWidget {
//   Todo _todo;

//   DetailPage(this._todo);
//   @override
//   _DetailPageState createState() => _DetailPageState();
// }

// class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
//   @override
//   Widget build(BuildContext context) {
//     var todo_provider = Provider.of<TodoProvider>(context);

//     Widget listItem(int index) {
//       Task _task = widget._todo.tasks[index];
//       return Container(
//         padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
//         child: Row(
//           children: <Widget>[
//             Expanded(
//               flex: 1,
//               child: Checkbox(
//                 value: true,
//                 onChanged: (_) {},
//                 activeColor: Color(0xFF1111E6).withOpacity(0.6),
//               ),
//             ),
//             Expanded(
//               flex: 3,
//               child: TextFormField(
//                 autofocus: false,
//                 initialValue: '${_task.task}',
//                 decoration: InputDecoration(
//                   hintText: '腹筋',
//                   border: InputBorder.none,
//                 ),
//                 keyboardType: TextInputType.text,
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontStyle: FontStyle.normal,
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 2,
//               child: Align(
//                 alignment: Alignment.centerRight,
//                 child: Text(
//                   '2020-01-01',
//                   style: TextStyle(color: Colors.grey),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     return Stack(
//       children: <Widget>[
//         Hero(
//           tag: widget._todo.uuid + '_background',
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(0.0),
//             ),
//           ),
//         ),
//         Container(
//           color: Colors.white,
//         ),
//         Scaffold(
//           backgroundColor: Colors.transparent,
//           appBar: AppBar(
//             leading: IconButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               icon: Icon(
//                 Icons.arrow_back,
//                 color: Colors.grey,
//               ),
//             ),
//             actions: [
//               IconButton(
//                 onPressed: () async {
//                   var result = await showModalBottomSheet(
//                     context: context,
//                     backgroundColor: Colors.transparent,
//                     isScrollControlled: true,
//                     builder: (context) {
//                       return addTodoBottomSheet(AddModalStatus.add_task);
//                     },
//                   );
//                   print('test $result');
//                 },
//                 padding: EdgeInsets.only(right: 10),
//                 icon: Icon(
//                   Icons.add,
//                   color: Colors.grey,
//                 ),
//               ),
//             ],
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//           ),
//           body: Column(
//             children: <Widget>[
//               SizedBox(height: 80),
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 padding: EdgeInsets.only(left: 40),
//                 child: Hero(
//                   tag: widget._todo.uuid + '_description',
//                   child: Text(
//                     '${widget._todo.description}',
//                     style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 40),
//               Container(
//                 height: MediaQuery.of(context).size.height / 1.5,
//                 width: MediaQuery.of(context).size.width,
//                 margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
//                 child: ListView.builder(
//                   itemCount: widget._todo.tasks.length,
//                   itemBuilder: (context, index) {
//                     return listItem(index);
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
