import 'package:flutter/material.dart';

class PictureFreePage extends StatefulWidget {
  final Map? arguments;
  const PictureFreePage({Key? key, this.arguments}) : super(key: key);

  @override
  createState() => _PictureFreePageState();
}

class _PictureFreePageState extends State<PictureFreePage> {


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
      right: true,
      bottom: false,
      left: true,
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("图片自由Demo"),
        ),
        body:Container(

        ),
      ),
    );
  }
}