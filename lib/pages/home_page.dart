import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_opencv/models/menu_model.dart';
import 'package:flutter_opencv/store/opencv_store.dart';
import 'package:image_picker/image_picker.dart';
import 'package:opencv_4/factory/pathfrom.dart';
import 'package:opencv_4/opencv_4.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //uncomment when image_picker is installed

  final controller = OpencvStore();
  String _versionOpenCV = 'OpenCV';

  List<MenuItem> listItems;

  MenuItem menuItemSelected;

  @override
  void initState() {
    super.initState();

    listItems = [
      MenuItem(
        description: 'Conversão de cor',
        function: () async {
          await controller.cvtColor();
          setState(() {});
        },
      ),
      MenuItem(
        description: 'Filtro',
        function: () async {
          await controller.filter2D();
          setState(() {});
        },
      ),
      MenuItem(
        description: 'Detector de borda (não suportado)',
        function: () {},
      ),
      MenuItem(
        description: 'Binarização',
        function: () async {
          await controller.threshold();
          setState(() {});
        },
      ),
      MenuItem(
        description: 'Morfologia matemática',
        function: () async {
          await controller.morphologyEx();
          setState(() {});
        },
      ),
    ];

    menuItemSelected = listItems.first;

    _getOpenCVVersion();
  }

  /// metodo que devuelve la version de OpenCV utilizada
  Future<void> _getOpenCVVersion() async {
    String versionOpenCV = await Cv2.version();
    setState(() {
      _versionOpenCV = 'OpenCV: ' + versionOpenCV;
    });
  }

  _testFromCamera() async {
    //uncomment when image_picker is installed

    await controller.getImage(imageSource: ImageSource.camera);

    setState(() {
      controller.visible = true;
    });
    await listItems.first.function();

    setState(() {
      controller.visible = false;
    });
  }

  onlyTestOpenCv() async {
    await listItems.first.function();

    setState(() {
      controller.visible = false;
    });
  }

  _testFromGallery() async {
    await controller.getImage(imageSource: ImageSource.gallery);

    setState(() {
      controller.visible = true;
    });

    await listItems.first.function();

    setState(() {
      controller.visible = false;
    });
  }

  Widget buildFloatingActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.photo_camera),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Camera'),
                  onTap: () {
                    Navigator.pop(context);
                    _testFromCamera();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_album),
                  title: Text('Gallery'),
                  onTap: () {
                    Navigator.pop(context);
                    _testFromGallery();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OpenCV'),
        actions: [
          Visibility(
            visible: controller.image != null,
            child: PopupMenuButton<MenuItem>(
              onSelected: (choice) {
                menuItemSelected = choice;
                try {
                  menuItemSelected.function();
                } catch (e) {} // onlyTestOpenCv();
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text('Menu'),
                ),
              ),
              itemBuilder: (BuildContext context) {
                return listItems.map((MenuItem choice) {
                  return PopupMenuItem<MenuItem>(
                    value: choice,
                    child: Text(
                      choice.description,
                    ),
                  );
                }).toList();
              },
            ),
          )
        ],
      ),
      floatingActionButton: buildFloatingActionButton(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        _versionOpenCV,
                        style: TextStyle(fontSize: 23),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Observer(
                        builder: (_) {
                          return controller.verOriginal
                              ? Image.memory(
                                  controller.image.readAsBytesSync(),
                                  width: 300,
                                  height: 300,
                                  fit: BoxFit.fill,
                                )
                              : Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: controller.byte != null
                                      ? Image.memory(
                                          controller.byte,
                                          width: 300,
                                          height: 300,
                                          fit: BoxFit.fill,
                                        )
                                      : Container(
                                          width: 300,
                                          height: 300,
                                          child: Icon(Icons.camera_alt),
                                        ),
                                );
                        },
                      ),
                      Visibility(
                        maintainAnimation: true,
                        maintainState: true,
                        visible: controller.visible,
                        child: Container(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Visibility(
                        visible: controller.image != null,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.verOriginal = !controller.verOriginal;
                          },
                          child: Text(controller.verOriginal
                              ? 'Ver imagem alterada'
                              : 'Ver imagem original'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
