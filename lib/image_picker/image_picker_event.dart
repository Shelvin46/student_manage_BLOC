part of 'image_picker_bloc.dart';

@immutable
abstract class ImagePickerEvent {}

class CameraImage extends ImagePickerEvent {}

class GalleryImage extends ImagePickerEvent {}

class RemoveImage extends ImagePickerEvent {}
