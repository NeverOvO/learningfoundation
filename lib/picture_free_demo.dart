
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

  int cross = 8;

  @override
  void initState() {
    super.initState();
  }

  void loadInfo() async{
    //按最大公约数来分割
    Uint8List bytes = (await NetworkAssetBundle(Uri.parse(url)).load(url)).buffer.asUint8List();

    imgLib.Image? image2 = imgLib.decodeImage(bytes);
    int x = 0;
    int y = 0;




    int gcd = image2!.width.gcd(image2.height);
    cross = image2.width ~/ gcd;

    parts!.clear();
    for (int i = 0; i < image2.height / gcd; i++) {
      for (int j = 0; j < image2.width / gcd; j++) {
        parts!.add(imgLib.copyCrop(image2, x, y, gcd, gcd));
        x += gcd;
      }
      x = 0;
      y += gcd;
    }

    output!.clear();
    for (var img in parts!) {
      output!.add(Image.memory(Uint8List.fromList(imgLib.encodePng(img))));

    }

    setState(() {});
  }

  void loadInfo1() async{
    //按50宽度来分割
    Uint8List bytes = (await NetworkAssetBundle(Uri.parse(url)).load(url)).buffer.asUint8List();
    imgLib.Image? image2 = imgLib.decodeImage(bytes);
    int x = 0;
    int y = 0;


    int gcd = 100;
    cross = image2!.width ~/ gcd;

    print(_abgrToArgb(image2.getPixelSafe(0,0)));

    parts!.clear();
    for (int i = 0; i < image2.height ~/ gcd; i++) {
      for (int j = 0; j < cross; j++) {
        parts!.add(imgLib.copyCrop(image2, x, y, gcd, gcd));
        x += gcd;
      }
      x = 0;
      y += gcd;
    }

    output!.clear();
    for (var img in parts!) {
      output!.add(Image.memory(Uint8List.fromList(imgLib.encodePng(img))));
    }

    setState(() {});
  }


  int _abgrToArgb(int oldValue) {
    int newValue = oldValue;
    newValue = newValue & 0xFF00FF00; //open new space to insert the bits
    newValue = ((oldValue & 0xFF) << 16) | newValue; // change BB
    newValue = ((oldValue & 0x00FF0000) >> 16) | newValue; // change RR
    return newValue;
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
                  crossAxisCount: cross,
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
                  child: Text("1:按最大公约数切割测试====>"),
                ),
              ),
              GestureDetector(
                onTap: () async{
                  loadInfo1();
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(20),
                  child: Text("2:按50宽度切割测试====>"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
