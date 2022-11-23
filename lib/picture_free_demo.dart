import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:image/image.dart' as imgLib;
import 'package:flutter/material.dart';

class PictureFreePage extends StatefulWidget {
  final Map? arguments;
  const PictureFreePage({Key? key, this.arguments}) : super(key: key);

  @override
  createState() => _PictureFreePageState();
}

class _PictureFreePageState extends State<PictureFreePage> {


  String url = 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fi0.hdslb.com%2Fbfs%2Farchive%2F088f45fa6c18352278ece24321e87a124ef28787.jpg&refer=http%3A%2F%2Fi0.hdslb.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1671688899&t=3f906b8eedd5d1da784f9472663f9375';
  List<imgLib.Image>? parts = [];//import 'package:image/image.dart' as imgLib;
  List<Image>? output = <Image>[];

  @override
  void initState() {
    super.initState();
  }

  void loadInfo() async{
    print("1");
    Uint8List bytes = (await NetworkAssetBundle(Uri.parse(url)).load(url)).buffer.asUint8List();
    // print(bytes);

    imgLib.Image? image2 = imgLib.decodeImage(bytes);
    int x = 0;
    int y = 0;

    parts!.clear();
    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 8; j++) {
        parts!.add(imgLib.copyCrop(image2!, x, y, 288, 288));
        x += 288;
      }
      x = 0;
      y += 288;
    }

    output!.clear();
    for (var img in parts!) {
      output!.add(Image.memory(Uint8List.fromList(imgLib.encodePng(img))));
    }

    setState(() {

    });
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
          child: ListView(
            children: [
              Image(image: NetworkImage(url)),
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                  childAspectRatio: 1, //显示区域宽高相等
                  mainAxisSpacing: 0.5,
                  crossAxisSpacing: 0.5,
                ),
                itemCount: output!.length,
                itemBuilder: (context,index){
                  return output![index];
                },
              ),
              GestureDetector(
                onTap: () async{
                  loadInfo();
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(20),
                  child: Text("1:按宫格切割测试====>"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// List<Image> splitImage(List<int> input) {
//   // convert image to image from image package
//   imglib.Image image = imglib.decodeImage(input);
//
//   int x = 0, y = 0;
//   int width = (image.width / 3).round();
//   int height = (image.height / 3).round();
//
//   // split image to parts
//   List<imglib.Image> parts = List<imglib.Image>();
//   for (int i = 0; i < 3; i++) {
//     for (int j = 0; j < 3; j++) {
//       parts.add(imglib.copyCrop(image, x, y, width, height));
//       x += width;
//     }
//     x = 0;
//     y += height;
//   }
//
//   // convert image from image package to Image Widget to display
//   List<Image> output = List<Image>();
//   for (var img in parts) {
//     output.add(Image.memory(imglib.encodeJpg(img)));
//   }
//
//   return output;
// }