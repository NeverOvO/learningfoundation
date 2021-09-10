
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class LearnRowAndColumnView extends StatefulWidget {
  final arguments;
  const LearnRowAndColumnView({Key? key, this.arguments}) : super(key: key);

  @override
  _LearnRowAndColumnViewState createState() => _LearnRowAndColumnViewState();
}

class _LearnRowAndColumnViewState extends State<LearnRowAndColumnView> {


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
          title: Text("Row&Column"),
        ),
        body:ListView(
          children: [
            Container(
              height: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(color: Colors.red,width: 100,height: 100,),
                  Container(color: Colors.blue,width: 100,height: 150,),
                  Container(color: Colors.green,width: 100,height: 200,),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              color: Colors.amberAccent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(color: Colors.red,width: 100,height: 20,),
                  Container(color: Colors.blue,width: 100,height: 50,),
                  Container(color: Colors.green,width: 100,height: 100,),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Divider(height: 10,color: Colors.blue,),
            SizedBox(height: 10,),
            Container(
              height: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: Container(color: Colors.red)),
                  Expanded(child: Container(color: Colors.blue)),
                  Expanded(child: Container(color: Colors.green)),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Divider(height: 10,color: Colors.blue,),
            SizedBox(height: 10,),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 3000,
              color: Colors.amberAccent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(color: Colors.red,width: 100,height: 200,),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context,index){
                        return Container(
                          child: Text("NNNNN"),
                          color: Color.fromRGBO(255, 10*index, 255, 1),
                        );
                      },
                      itemCount: 100,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 100,),
          ],
        )
      ),
    );
  }
}