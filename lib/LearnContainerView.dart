import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class LearnContainerView extends StatefulWidget {
  final arguments;
  const LearnContainerView({Key? key, this.arguments}) : super(key: key);

  @override
  _LearnContainerViewState createState() => _LearnContainerViewState();
}

class _LearnContainerViewState extends State<LearnContainerView> {


  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Container"),
        ),
        body:ListView(
          children: [
            Container(
              child: Text("1233123"),
              padding: EdgeInsets.fromLTRB(10, 20, 30, 40),
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.fromLTRB(10, 20, 30, 40),
              decoration: BoxDecoration(
                //边框圆角设置
                color: Colors.red,
                border: Border.all(width: 4, color: Color.fromRGBO(15, 159, 131, 1)),
                // borderRadius: BorderRadius.all(Radius.circular(30.0)),
                borderRadius: BorderRadius.only(topRight:Radius.circular(30.0)),
                image: DecorationImage(
                  image: AssetImage("images/con1.png"),
                  fit: BoxFit.cover,
                ),
                boxShadow: [BoxShadow(blurRadius: 1, spreadRadius: 1, color: Colors.grey, offset:Offset(5,5)),],
              ),
              foregroundDecoration: BoxDecoration(
                color: Color.fromRGBO(12, 12, 12, 0.1),
                border: Border.all(width: 3, color: Colors.red),
                borderRadius: BorderRadius.only(bottomLeft:Radius.circular(30.0)),
              ),
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width / 1.5,
              ),
              transform: Matrix4.rotationZ(0.1),
              clipBehavior: Clip.antiAliasWithSaveLayer,
            ),
            Divider(height: 1,color: Colors.black,)
          ],
        ),
      ),
    );
  }
}