import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:mobx/mobx.dart';
import 'package:opencv_4/factory/pathfrom.dart';
import 'package:opencv_4/opencv_4.dart';
part 'opencv_store.g.dart';

class OpencvStore = _OpencvStoreBase with _$OpencvStore;

abstract class _OpencvStoreBase with Store {
  final picker = ImagePicker();

  @observable
  File image;

  @observable
  Uint8List byte;

  @observable
  bool visible = false;

  @observable
  bool verOriginal = false;

  @action
  Future<File> getImage({ImageSource imageSource: ImageSource.camera}) async {
    final pickedFile = await picker.getImage(source: imageSource);
    if (pickedFile == null) image = null;

    image = File(pickedFile.path);

    return image;
  }

  @action
  cvtColor() async {
    try {
      byte = await Cv2.cvtColor(
        pathFrom: CVPathFrom.GALLERY_CAMERA,
        pathString: image.path,
        outputType: Cv2.COLOR_BGR2GRAY,
      );
      verOriginal = false;

      visible = false;
    } on PlatformException catch (e) {}
  }

  @action
  filter2D() async {
    try {
      byte = await Cv2.filter2D(
        pathFrom: CVPathFrom.GALLERY_CAMERA,
        pathString: image.path,
        outputDepth: -1,
        kernelSize: [2, 2],
      );

      verOriginal = false;

      visible = false;
    } on PlatformException catch (e) {}
  }

  @action
  morphologyEx() async {
    try {
      byte = await Cv2.morphologyEx(
        pathFrom: CVPathFrom.GALLERY_CAMERA,
        pathString: image.path,
        operation: Cv2.MORPH_GRADIENT,
        kernelSize: [5, 5],
      );

      verOriginal = false;

      visible = false;
    } on PlatformException catch (e) {}
  }

  @action
  threshold() async {
    try {
      byte = await Cv2.threshold(
        pathFrom: CVPathFrom.GALLERY_CAMERA,
        pathString: image.path,
        thresholdValue: 150,
        maxThresholdValue: 200,
        thresholdType: Cv2.THRESH_BINARY,
      );

      verOriginal = false;

      visible = false;
    } on PlatformException catch (e) {}
  }
}
