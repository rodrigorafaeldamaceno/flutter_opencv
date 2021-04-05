// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'opencv_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OpencvStore on _OpencvStoreBase, Store {
  final _$imageAtom = Atom(name: '_OpencvStoreBase.image');

  @override
  File get image {
    _$imageAtom.reportRead();
    return super.image;
  }

  @override
  set image(File value) {
    _$imageAtom.reportWrite(value, super.image, () {
      super.image = value;
    });
  }

  final _$byteAtom = Atom(name: '_OpencvStoreBase.byte');

  @override
  Uint8List get byte {
    _$byteAtom.reportRead();
    return super.byte;
  }

  @override
  set byte(Uint8List value) {
    _$byteAtom.reportWrite(value, super.byte, () {
      super.byte = value;
    });
  }

  final _$visibleAtom = Atom(name: '_OpencvStoreBase.visible');

  @override
  bool get visible {
    _$visibleAtom.reportRead();
    return super.visible;
  }

  @override
  set visible(bool value) {
    _$visibleAtom.reportWrite(value, super.visible, () {
      super.visible = value;
    });
  }

  final _$verOriginalAtom = Atom(name: '_OpencvStoreBase.verOriginal');

  @override
  bool get verOriginal {
    _$verOriginalAtom.reportRead();
    return super.verOriginal;
  }

  @override
  set verOriginal(bool value) {
    _$verOriginalAtom.reportWrite(value, super.verOriginal, () {
      super.verOriginal = value;
    });
  }

  final _$getImageAsyncAction = AsyncAction('_OpencvStoreBase.getImage');

  @override
  Future<File> getImage({ImageSource imageSource = ImageSource.camera}) {
    return _$getImageAsyncAction
        .run(() => super.getImage(imageSource: imageSource));
  }

  final _$cvtColorAsyncAction = AsyncAction('_OpencvStoreBase.cvtColor');

  @override
  Future cvtColor() {
    return _$cvtColorAsyncAction.run(() => super.cvtColor());
  }

  final _$filter2DAsyncAction = AsyncAction('_OpencvStoreBase.filter2D');

  @override
  Future filter2D() {
    return _$filter2DAsyncAction.run(() => super.filter2D());
  }

  final _$morphologyExAsyncAction =
      AsyncAction('_OpencvStoreBase.morphologyEx');

  @override
  Future morphologyEx() {
    return _$morphologyExAsyncAction.run(() => super.morphologyEx());
  }

  final _$thresholdAsyncAction = AsyncAction('_OpencvStoreBase.threshold');

  @override
  Future threshold() {
    return _$thresholdAsyncAction.run(() => super.threshold());
  }

  @override
  String toString() {
    return '''
image: ${image},
byte: ${byte},
visible: ${visible},
verOriginal: ${verOriginal}
    ''';
  }
}
