import 'package:flutter/material.dart';
class LearnGestureDetectorView extends StatefulWidget {
  final arguments;
  const LearnGestureDetectorView({Key? key, this.arguments}) : super(key: key);

  @override
  _LearnGestureDetectorViewState createState() => _LearnGestureDetectorViewState();
}

class _LearnGestureDetectorViewState extends State<LearnGestureDetectorView> {


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
          title: Text("GestureDetector"),
        ),
        body:GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Container(
            child: SizedBox(),
            alignment: Alignment.center,
            color: Colors.amber,

          ),
          onTap: (){
            print("onTap");
          },
          onTapUp: (e){
            print("onTapUp");
            print(e.globalPosition);
          },
          onTapDown: (e){
            print("onTapDown");
            print(e.globalPosition);
          },
          onTapCancel: (){
            print("onTapCancel");
          },

          onSecondaryTap: (){
            print("onSecondaryTap");
          },

          onTertiaryTapDown: (e){
            // print(e.globalPosition);
            print("onTertiaryTapDown");
          },
          onTertiaryTapUp: (e){
            print("onTertiaryTapUp");
          },
          onTertiaryTapCancel: (){
            print("onTertiaryTapCancel");
          },

          onDoubleTap: (){
            print("onDoubleTap");
          },
          onDoubleTapDown: (e){
            print("onDoubleTapDown");
            print(e.globalPosition);
          },
          onDoubleTapCancel: (){
            print("onDoubleTapCancel");
          },

          onLongPress: (){
            print("onLongPress");
          },
          onLongPressDown: (e){
            print("onLongPressDown");
          },
          onLongPressUp: (){
            print("onLongPressUp");
          },
          onLongPressStart: (e){
            print("onLongPressStart");
          },
          onLongPressMoveUpdate: (e){
            print("onLongPressMoveUpdate");
          },
          onLongPressEnd: (e){
            print("onLongPressEnd");
          },
          onLongPressCancel: (){
            print("onLongPressCancel");
          },
          
          onSecondaryLongPress: (){
            print("onSecondaryLongPress");
          },

          onVerticalDragDown: (e){
            print(e.localPosition);
            print("onVerticalDragDown");
          },
          onVerticalDragStart: (e){
            print("onVerticalDragStart");
          },
          onVerticalDragUpdate: (e){
            print("onVerticalDragUpdate");
          },
          onVerticalDragEnd: (e){
            print("onVerticalDragEnd");
          },
          onVerticalDragCancel: (){
            print("onVerticalDragCancel");
          },

          onHorizontalDragDown: (e){
            print("onHorizontalDragDown");
          },
          onHorizontalDragStart: (e){
            print("onHorizontalDragStart");
          },
          onHorizontalDragUpdate: (e){
            print("onHorizontalDragStart");
          },
          onHorizontalDragEnd: (e){
            print("onHorizontalDragEnd");
          },
          onHorizontalDragCancel: (){

          },

          onPanDown: (e){
            print("onPanDown");
          },
          onPanStart: (e){
            print("onPanStart");
          },
          onPanUpdate: (e){
            print("onPanUpdate");
          },
          onPanEnd: (e){
            print("onPanEnd");
          },
          onPanCancel: (){

          },

          onForcePressPeak: (e){
            print("onForcePressPeak");
          },
          onForcePressStart: (e){
            print("onForcePressStart");
          },
          onForcePressUpdate: (e){
            print("onForcePressUpdate");
          },
          onForcePressEnd: (e){
            print("onForcePressEnd");
          },
        )
      ),
    );
  }
}