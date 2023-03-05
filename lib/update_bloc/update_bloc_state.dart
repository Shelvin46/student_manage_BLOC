part of 'update_bloc_bloc.dart';

class UpdateBlocState {
  List<StudentModel> values;
  XFile? image;
  UpdateBlocState({required this.values,required this.image});
}

class UpdateBlocInitial extends UpdateBlocState {
  UpdateBlocInitial() : super(values: [],image: null);
}
