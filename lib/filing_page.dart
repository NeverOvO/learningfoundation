import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FillingPage extends StatefulWidget {
  final Map? arguments;
  const FillingPage({Key? key, this.arguments}) : super(key: key);

  @override
  createState() => _FillingPageState();
}

class _FillingPageState extends State<FillingPage> {

  final TextEditingController fromDirectoryPathController = TextEditingController();
  final TextEditingController toDirectoryPathController = TextEditingController();

  Stream<FileSystemEntity>? fileList;

  List? filaName = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _dirList() async {

    // Stream<FileSystemEntity> fileList = Directory(selectedDirectory!).list(recursive: true);
    //
    // await for(FileSystemEntity fileSystemEntity in fileList){
    //   // print('$fileSystemEntity');
    //   if(fileSystemEntity.uri.toString().endsWith(".log")){
    //     print(fileSystemEntity.exists());
    //   }
    // }
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
          title: const Text("文件归档Demo"),
        ),
        body:Container(
          child: ListView(
            children: [

              Container(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            enabledBorder: UnderlineInputBorder(),
                            labelStyle: TextStyle(color: Colors.grey),
                            labelText: '请输入或选择源文件夹地址',
                          ),
                          controller: fromDirectoryPathController,
                          autocorrect:false,
                          style: TextStyle(color: Colors.black,fontSize: 11),
                        ),
                      ),
                      flex: 2,
                    ),
                    GestureDetector(
                      onTap: () async{
                        String? selectedDirectory = await FilePicker.platform.getDirectoryPath(dialogTitle:"选择源文件夹",lockParentWindow: true);
                        if(selectedDirectory != null){
                          fromDirectoryPathController.text = selectedDirectory;
                        }
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Text("选择",style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () async{
                        if(fromDirectoryPathController.text.isNotEmpty){
                          fileList = Directory(fromDirectoryPathController.text).list(recursive: true);
                          await for(FileSystemEntity fileSystemEntity in fileList!){
                            // print('$fileSystemEntity');
                            // if(fileSystemEntity)
                           if(fileSystemEntity.runtimeType.toString() == "_File"){
                             print(fileSystemEntity.uri.toString().split("/").last);
                             var time = File(fileSystemEntity.path).lastAccessedSync();
                             print(time.toString().replaceFirst(" ", "-").replaceAll(" ", "").replaceAll(".000", "").replaceAll(":", "-"));
                           }
                            // print(fileSystemEntity.uri.toString().split("/").last);

                            // if(filaName.contains(fileSystemEntity))
                            // filaName.add(fileSystemEntity.path)
                            // if(fileSystemEntity.uri.toString().endsWith(".log")){
                            //   print(fileSystemEntity.exists());
                            // }
                          }
                        }

                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Text("检索源文件地址目录",style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            enabledBorder: UnderlineInputBorder(),
                            labelStyle: TextStyle(color: Colors.grey),
                            labelText: '请输入/选择/或新建目标文件夹地址',
                          ),
                          controller: toDirectoryPathController,
                          autocorrect:false,
                          style: TextStyle(color: Colors.black,fontSize: 11),
                        ),
                      ),
                      flex: 2,
                    ),
                    GestureDetector(
                      onTap: () async{
                        String? selectedDirectory = await FilePicker.platform.getDirectoryPath(dialogTitle:"选择目标文件夹",lockParentWindow: true);
                        if(selectedDirectory != null){
                          toDirectoryPathController.text = selectedDirectory;
                        }
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Text("选择",style: TextStyle(color: Colors.white),),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async{
                        String? selectedDirectory = await FilePicker.platform.getDirectoryPath(dialogTitle:"新建目标文件夹",lockParentWindow: true);
                        if(selectedDirectory != null){
                          var file = Directory(selectedDirectory + "/" + formatDate(DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch), [mm, '.', dd,]));
                          try {
                            bool exists = await file.exists();
                            if (!exists) {
                              await file.create();
                              print("创建成功");
                            } else {
                              print("已存在");
                            }
                            toDirectoryPathController.text =file.path;
                          } catch (e) {
                            print(e);
                          }
                        }

                      },
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Text("新建文件夹",style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
