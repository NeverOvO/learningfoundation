import 'dart:async';
import 'dart:ui' as ui;
import 'package:image/image.dart' as imgLib;
import 'package:flutter/material.dart';

class PictureFreePage extends StatefulWidget {
  final Map? arguments;
  const PictureFreePage({Key? key, this.arguments}) : super(key: key);

  @override
  createState() => _PictureFreePageState();
}

class _PictureFreePageState extends State<PictureFreePage> {

  Image? image1 = Image.network('https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fi0.hdslb.com%2Fbfs%2Farchive%2F088f45fa6c18352278ece24321e87a124ef28787.jpg&refer=http%3A%2F%2Fi0.hdslb.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1671688899&t=3f906b8eedd5d1da784f9472663f9375');
  Completer<ui.Image> completer = Completer<ui.Image>();
  ui.Image? info;

  List<imgLib.Image>? parts;

  @override
  void initState() {
    super.initState();
    image1!.image.resolve(ImageConfiguration()).addListener(ImageStreamListener((ImageInfo info, bool _) {
      completer.complete(info.image);
      loadInfo();
    }));
  }

  void loadInfo() async{
    info = await completer.future;
    print("1");
    print(image1!.height);

    imgLib.Image? image2 = imgLib.decodeImage(image1!.image.);

    int x = 0;
    int y = 0;

    // for (int i = 0; i < 3; i++) {
    //   for (int j = 0; j < 3; j++) {
    //     parts!.add(imgLib.copyCrop(image1!, x, y, 288, 288));
    //     x += 288;
    //   }
    //   x = 0;
    //   y += 288;
    // }


  }



  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    loadInfo();
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
              image1!,
              // GridView.builder(
              //   physics: NeverScrollableScrollPhysics(),
              //   shrinkWrap: true,
              //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: 8,
              //     childAspectRatio: 1, //显示区域宽高相等
              //     mainAxisSpacing: 5,
              //     crossAxisSpacing: 5,
              //   ),
              //   itemCount: 40,
              //   itemBuilder: (context,index){
              //     return ClipRect(
              //       clipper: MyClipper(
              //         index: index + 1,
              //         gcd: 288,
              //       ), //使用自定义的clipper
              //       child: image1!,
              //     );
              //   },
              // ),
              GestureDetector(
                onTap: () async{
                  int width = info!.width;
                  int height = info!.height;
                  print('-------------->>>${width}x${height}');
                  print(width.gcd(height));
                  print(width / 288);
                  print(height / 288);
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

class MyClipper extends CustomClipper<Rect> {
  int? index = 0;
  int? gcd = 0;
  MyClipper({this.index ,this.gcd});

  @override
  Rect getClip(Size size) => Rect.fromPoints(ui.Offset(0, 0), ui.Offset((144 * index!).toDouble(), (144 * index!).toDouble()));

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => false;
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