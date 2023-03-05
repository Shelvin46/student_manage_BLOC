part of 'update_bloc_bloc.dart';

@immutable
abstract class UpdateBlocEvent {}

class DetalisShow extends UpdateBlocEvent {}

class UpdateCameraImage extends UpdateBlocEvent {}

class UpdateGalleryImage extends UpdateBlocEvent {}
