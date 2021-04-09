import 'package:flutter/material.dart';
import 'package:todo_app/util.dart';

class reminderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget TaskCard() {
      return Container(
        margin: EdgeInsets.fromLTRB(20, 0, 20, 25),
        padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
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
      );
    }

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomRight,
              colors: [
                CustomColors.HeaderBlueDark,
                CustomColors.HeaderBlueLight,
              ],
              stops: const [
                0.0,
                1.0,
              ],
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.grey,
              ),
            ),
          ),
          body: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 40),
                child: Text(
                  'リマインダー',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 25),
              TaskCard(),
              TaskCard(),
              TaskCard(),
              TaskCard(),
            ],
          ),
        ),
      ],
    );
  }
}
