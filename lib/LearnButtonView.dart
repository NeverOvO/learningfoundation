import 'package:flutter/material.dart';

class LearnButtonView extends StatefulWidget {
  final arguments;
  const LearnButtonView({Key? key, this.arguments}) : super(key: key);

  @override createState() => _LearnButtonViewState();
}

class _LearnButtonViewState extends State<LearnButtonView> {


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
          title: Text("Button系列"),
        ),
        body:ListView(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),                //背景颜色
                  foregroundColor: MaterialStateProperty.all(Colors.white),                //字体颜色
                  overlayColor: MaterialStateProperty.all(Colors.red),                   // 高亮色
                  shadowColor: MaterialStateProperty.all( Colors.black),                  //阴影颜色
                  elevation: MaterialStateProperty.all(10),                                     //阴影值
                  side: MaterialStateProperty.all(BorderSide(width: 1,color: Colors.black)),//边框
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),//圆角弧度
                ),
                onPressed: () {  },
                child: Text("ElevatedButton"),
              ),
            ),
            SizedBox(height: 30,),
            Container(
              padding: EdgeInsets.all(10),
              child: TextButton(
                // style: ButtonStyle(
                //   backgroundColor: MaterialStateProperty.all(Colors.blue),                //背景颜色
                //   foregroundColor: MaterialStateProperty.all(Colors.white),                //字体颜色
                //   overlayColor: MaterialStateProperty.all(Colors.red),                   // 高亮色
                //   shadowColor: MaterialStateProperty.all( Colors.black),                  //阴影颜色
                //   elevation: MaterialStateProperty.all(10),                                     //阴影值
                //   side: MaterialStateProperty.all(BorderSide(width: 1,color: Colors.black)),//边框
                //   shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),//圆角弧度
                // ),
                onPressed: () {},
                child: Text("TextButton"),
              ),
            ),
            SizedBox(height: 30,),
            Container(
              padding: EdgeInsets.all(10),
              child: OutlinedButton(
                onPressed: () {},
                child: Text("OutineButton"),
              ),
            ),
            SizedBox(height: 30,),
            Container(
              padding: EdgeInsets.all(10),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.ac_unit_outlined),
              ),
            ),
            SizedBox(height: 30,),
            Container(
              padding: EdgeInsets.all(10),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.dark_mode),
                label: Text("ElevatedButton.icon"),
              ),
            )
          ],
        ),
      ),
    );
  }
}