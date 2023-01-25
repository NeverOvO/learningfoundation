import 'dart:io';
import 'dart:isolate';

import 'package:flutter/material.dart';

class LearnIsolateView extends StatefulWidget {
  final Map? arguments;
  const LearnIsolateView({Key? key, this.arguments}) : super(key: key);

  @override
  createState() => _LearnIsolateViewState();
}

class _LearnIsolateViewState extends State<LearnIsolateView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  var content = "点击计算按钮,开始计算";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Isolate"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(),
          ),
          Container(
            child: Text(content),
          ),
          TextButton(
            child: Text('计算'),
            onPressed: () {
              int result = sum(10000000000);
              content = "总和$result";
              setState(() {});
            },
          ),
          TextButton(
            child: Text('测试1'),
            onPressed: () {
              _testIsolate();
            },
          ),
          TextButton(
            child: Text('测试2'),
            onPressed: () {
              _testIsolate1();
            },
          ),
        ],
      ),
    );
  }

  int sum(int num) {
    int count = 0;
    while (num > 0) {
      count = count + num;
      num--;
    }
    return count;
  }

//   _testIsolate() async {
//     ReceivePort rp1 = new ReceivePort();
//     SendPort port1 = rp1.sendPort;
//     // 通过spawn新建一个isolate，并绑定静态方法
//     Isolate? newIsolate = await Isolate.spawn(doWork, port1);
//
//     SendPort? port2;
//     rp1.listen((message) {
//       print("rp1 收到消息: $message"); //2.  4.  7.rp1收到消息
//       if(message == "完成"){
//         newIsolate!.kill(priority: Isolate.immediate);
//         newIsolate = null;
//         print("杀掉");
//       }
//       if (message[0] == 0) {
//         port2 = message[1]; //得到rp2的发送器port2
//       } else {
//         if (port2 != null) {
//           print("port2 发送消息");
//           port2?.send([1, "这条信息是 port2 在main isolate中 发送的"]); // 8.port2发送消息
//         }
//       }
//     });
//
//     print("port1--main isolate发送消息");
//     port1.send([1, "这条信息是 port1 在main isolate中 发送的"]); //1.port1发送消息
//
//     // newIsolate.kill();
//   }
//
// // 新的isolate中可以处理耗时任务
//   static void doWork(SendPort port1) {
//     ReceivePort rp2 = new ReceivePort();
//     SendPort port2 = rp2.sendPort;
//     rp2.listen((message) {
//       //9.10 rp2收到消息
//       print("rp2 收到消息: $message");
//     });
//     // 将新isolate中创建的SendPort发送到main isolate中用于通信
//     print("port1--new isolate发送消息");
//     port1.send([0, port2]); //3.port1发送消息,传递[0,rp2的发送器]
//     // 模拟耗时5秒
//     sleep(Duration(seconds: 1));
//     print("port1--new isolate发送消息");
//     port1.send([1, "这条信息是 port1 在new isolate中 发送的"]); //5.port1发送消息
//     print("port2--new isolate发送消息");
//     port2.send([1, "这条信息是 port2 在new isolate中 发送的"]); //6.port2发送消息
//   }

//I/flutter (14639): port1--main isolate发送消息
//I/flutter (14639): rp1 收到消息: [1, 这条信息是 port1 在main isolate中 发送的]
//I/flutter (14639): port1--new isolate发送消息
//I/flutter (14639): rp1 收到消息: [0, SendPort]
//I/flutter (14639): port1--new isolate发送消息
//I/flutter (14639): port2--new isolate发送消息
//I/flutter (14639): rp1 收到消息: [1, 这条信息是 port1 在new isolate中 发送的]
//I/flutter (14639): port2 发送消息
//I/flutter (14639): rp2 收到消息: [1, 这条信息是 port2 在new isolate中 发送的]
//I/flutter (14639): rp2 收到消息: [1, 这条信息是 port2 在main isolate中 发送的]

  // num result = await compute(summ, 10000000000);
  // content = "计算结果$result";
  // setState(() {});


  //常规方案 需要手动进行关闭线程
  _testIsolate() async {
    ReceivePort rp1 = new ReceivePort();
    SendPort port1 = rp1.sendPort;
    // 通过spawn新建一个isolate，并绑定静态方法
    // Isolate? newIsolate = await Isolate.spawn(doWork, port1);
    Isolate? newIsolate = await Isolate.spawn(doWork1, port1);

    SendPort? port2;
    rp1.listen((message) {
      print("rp1 收到消息: $message"); //2.  4.  7.rp1收到消息
      if(message[0] == -1){
        newIsolate!.kill(priority: Isolate.immediate);
        newIsolate = null;
        print("杀掉线程");
      }
      if (message[0] == 0) { // 对接完成后可以进行一次操作
        port2 = message[1]; //对接
        port2!.send([0,"对接完成"]);
        port2!.send([1,100000000]);
      }
      if(message[0] == 1){ // 这里用来输出结果，完成这一次的操作
        content = "总和${message[1]}";
        setState(() {

        });
      }
    });

    // port2!.send(100); //1.port1发送消息

    // newIsolate.kill();
  }

  // 新的isolate中可以处理耗时任务
  static void doWork1(SendPort port1) {
    ReceivePort rp2 = new ReceivePort();
    SendPort port2 = rp2.sendPort;
    port1.send([0, port2]);
    rp2.listen((message) {
      //9.10 rp2收到消息
      print("rp2 收到消息: $message");
      if(message[0] == 1){ // 对接完成后进行操作
        num result = summ(message[1]);
        port1.send([1,result]);

        sleep(Duration(seconds: 1));
        port1.send([-1]);
      }
    });
    // 模拟耗时5秒
    // sleep(Duration(seconds: 2));
    // port1.send([1,"任务完成"]);

  }

  //改进方案 任务完成后自动关闭线程
  _testIsolate1() async {
    ReceivePort rp1 = new ReceivePort();
    SendPort port1 = rp1.sendPort;
    // 通过spawn新建一个isolate，并绑定静态方法
    // Isolate? newIsolate = await Isolate.spawn(doWork, port1);
    Isolate? newIsolate = await Isolate.spawn(doWork2, port1);

    SendPort? port2;
    rp1.listen((message) {
      print("rp1 收到消息: $message"); //2.  4.  7.rp1收到消息
      if (message[0] == 0) { // 对接完成后可以进行一次操作
        port2 = message[1]; //对接
        port2!.send([0,"对接完成"]);
        port2!.send([1,100000000]);
      }
      if(message[0] == 1){ // 这里用来输出结果，完成这一次的操作
        content = "总和${message[1]}";
        setState(() {

        });
      }
    });

    // port2!.send(100); //1.port1发送消息

    // newIsolate.kill();
  }
  // 新的isolate中可以处理耗时任务
  static void doWork2(SendPort port1) {
    ReceivePort rp2 = new ReceivePort();
    SendPort port2 = rp2.sendPort;
    port1.send([0, port2]);
    rp2.listen((message) {
      print("rp2 收到消息: $message");
      if(message[0] == 1){ // 对接完成后进行操作
        Isolate.exit(port1, [1,summ(message[1])]);
      }
    });
  }



  // 0 进行对接
  // 1 进行数据传递
  // -1 进行线程关闭

  // static Future<dynamic> calculation(int n) async {
  //   //创建一个ReceivePort
  //   final receivePort1 = new ReceivePort();
  //   //创建isolate
  //   Isolate isolate = await Isolate.spawn(createIsolate, receivePort1.sendPort);
  //
  //   //使用 receivePort1.first 获取sendPort1发送来的数据
  //   final sendPort2 = await receivePort1.first as SendPort;
  //   print("receivePort1接收到消息--sendPort2");
  //   //接收消息的ReceivePort
  //   final answerReceivePort = new ReceivePort();
  //   print("sendPort2发送消息--[$n,answerSendPort]");
  //   sendPort2.send([n, answerReceivePort.sendPort]);
  //   //获得数据并返回
  //   num result = await answerReceivePort.first;
  //   print("answerReceivePort接收到消息--计算结果$result");
  //   return result;
  // }
  //
  // //创建isolate必须要的参数
  // static void createIsolate(SendPort sendPort1) {
  //   final receivePort2 = new ReceivePort();
  //   //绑定
  //   print("sendPort1发送消息--sendPort2");
  //   sendPort1.send(receivePort2.sendPort);
  //   //监听
  //   receivePort2.listen((message) {
  //     //获取数据并解析
  //     print("receivePort2接收到消息--$message");
  //     final int n = message[0] as int;
  //     final send = message[1] as SendPort;
  //     //返回结果
  //     num result = summ(n);
  //     print("answerSendPort发送消息--计算结果$result");
  //     send.send(result);
  //   });
  // }

  //计算0到 num 数值的总和
  static num summ(int num) {
    int count = 0;
    while (num > 0) {
      count = count + num;
      num--;
    }
    return count;
  }
}

