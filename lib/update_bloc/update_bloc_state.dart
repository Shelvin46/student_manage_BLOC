part of 'update_bloc_bloc.dart';

class UpdateBlocState {
  List<StudentModel> values;
  XFile? image;
  bool isNull;
  UpdateBlocState({required this.values, required this.image,required this.isNull});
}

class UpdateBlocInitial extends UpdateBlocState {
  UpdateBlocInitial() : super(values: [], image: null,isNull: false);
}
