import 'dart:io';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:learningfoundation/LearnButtonView.dart';
import 'package:learningfoundation/LearnContainerView.dart';
import 'package:learningfoundation/LearnGestureDetectorView.dart';
import 'package:learningfoundation/LearnIsolateView.dart';
import 'package:learningfoundation/LearnRowAndColumnView.dart';
import 'package:learningfoundation/filing_page.dart';
import 'package:learningfoundation/picture_free_demo.dart';

void main() {
  runApp(MyApp());
}

// // 新的isolate中可以处理耗时任务 主程序版本 可以支持进行下载等全局操作
// void doWork(SendPort port1) {
//   ReceivePort rp2 = new ReceivePort();
//   SendPort port2 = rp2.sendPort;
//   port1.send([0, port2]);
//   rp2.listen((message) {
// //9.10 rp2收到消息
//     print("rp2 收到消息: $message");
//     if(message[0] == 1){ // 对接完成后进行操作
//
//       int count = 0;
//       while (message[1] > 0) {
//         count = count + message[1] as int;
//         message[1]--;
//       }
//
//       port1.send([1,count]);
//
//       sleep(Duration(seconds: 1));
//       port1.send([-1]);
//     }
//   });
// // 模拟耗时5秒
// // sleep(Duration(seconds: 2));
// // port1.send([1,"任务完成"]);
//
// }


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
            GestureDetector(
              child: _button('文件归档Demo'),
              behavior: HitTestBehavior.opaque,
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => FillingPage()),);
              },
            ),
            GestureDetector(
              child: _button('Isolate Demo'),
              behavior: HitTestBehavior.opaque,
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => LearnIsolateView()),);
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

