part of 'list_view_bloc.dart';

class ListViewState {
  List<StudentModel> value;
  List<StudentModel> filterdValue;
  bool isNull;
  ListViewState({required this.value, required this.filterdValue,required this.isNull});
}

class ListViewInitial extends ListViewState {
  ListViewInitial() : super(value: [], filterdValue: [],isNull: false);
}
