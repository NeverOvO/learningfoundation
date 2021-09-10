import 'package:flutter/material.dart';
import 'package:learningfoundation/LearnContainerView.dart';
import 'package:learningfoundation/LearnRowAndColumnView.dart';

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
      ),
      home: MyHomePage(title: 'Flutter自我入门总结'),
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
      body: ListView(
        children: [
          SizedBox(height: 20,),
          GestureDetector(
            child: _button('Container'),
            behavior: HitTestBehavior.opaque,
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => LearnContainerView()),);
            },
          ),
          SizedBox(height: 20,),
          GestureDetector(
            child: _button('Row&Column'),
            behavior: HitTestBehavior.opaque,
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => LearnRowAndColumnView()),);
            },
          )
        ],
      ),
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
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      margin: EdgeInsets.fromLTRB(200, 1, 200, 1),
      child: Text(title,style: TextStyle(fontSize: 13,color: Colors.white),),
    );
  }
}
