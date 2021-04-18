import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/db/todo_repository.dart';

import 'package:todo_app/util.dart';
import 'package:todo_app/widgets/addTodoBottomSheet.dart';
import 'package:todo_app/views/reminderPage.dart';

class TodoAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(180.0);

  @override
  Widget build(BuildContext context) {
    var todo_repository = Provider.of<TodoRepository>(context);
    return GradientAppBar(
      title: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'TODO LIST',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                IconButton(
                  icon: Icon(
                    Icons.add,
                  ),
                  onPressed: () async {
                    var result = await showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (context) {
                        return addTodoBottomSheet(AddmodalStatus.add_todo);
                      },
                    );
                    if (result == null) return;
                    await todo_repository.create('${result}');
                    await todo_repository.getAll();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      elevation: 0,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [CustomColors.HeaderBlueDark, CustomColors.HeaderBlueLight],
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(10),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (BuildContext context) => reminderPage(),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            decoration: BoxDecoration(
              color: CustomColors.HeaderGreyLight,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '期限の近いタスク',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'レポート締め切り',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      '13.00 PM',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                      ),
                    )
                  ],
                ),
                Transform.rotate(
                  angle: 0.35,
                  child: Icon(
                    Icons.notifications_on,
                    color: Colors.white,
                    size: 45,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
