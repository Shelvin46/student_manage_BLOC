part of 'update_bloc_bloc.dart';

 class UpdateBlocState {
  List<StudentModel> values;
  UpdateBlocState({required this.values});
}

class UpdateBlocInitial extends UpdateBlocState {
  UpdateBlocInitial() : super(values: []);
}
