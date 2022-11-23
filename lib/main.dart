import 'package:flutter/material.dart';
import 'package:learningfoundation/LearnButtonView.dart';
import 'package:learningfoundation/LearnContainerView.dart';
import 'package:learningfoundation/LearnGestureDetectorView.dart';
import 'package:learningfoundation/LearnRowAndColumnView.dart';
import 'package:learningfoundation/picture_free_demo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(fontSize: 14),
        ),
      ),
      home: MyHomePage(title: 'Flutter练习册'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: GridView(

          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, //每行三列
            childAspectRatio: 3, //显示区域宽高相等
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
          ),
          children: [
            GestureDetector(
              child: _button('Container'),
              behavior: HitTestBehavior.opaque,
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => LearnContainerView()),);
              },
            ),
            GestureDetector(
              child: _button('Row&Column'),
              behavior: HitTestBehavior.opaque,
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => LearnRowAndColumnView()),);
              },
            ),
            GestureDetector(
              child: _button('GestureDetector'),
              behavior: HitTestBehavior.opaque,
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => LearnGestureDetectorView()),);
              },
            ),
            GestureDetector(
              child: _button('Button系列'),
              behavior: HitTestBehavior.opaque,
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => LearnButtonView()),);
              },
            ),
            GestureDetector(
              child: _button('图片自由Demo'),
              behavior: HitTestBehavior.opaque,
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => PictureFreePage()),);
              },
            ),
          ],
        ),
      )
    );
  }


  Widget _button(String title){
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightGreen,
        borderRadius: BorderRadius.all(Radius.circular(3.0)),
        boxShadow: [BoxShadow(blurRadius: 5, spreadRadius: 1, color: Colors.grey, offset:Offset(5,5)),],
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      // margin: EdgeInsets.fromLTRB(200, 1, 200, 1),
      child: Text(title,style: TextStyle(fontSize: 12,color: Colors.white),),
    );
  }
}
