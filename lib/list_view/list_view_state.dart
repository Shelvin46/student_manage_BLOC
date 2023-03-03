part of 'list_view_bloc.dart';

class ListViewState {
  List<StudentModel> value;
  List<StudentModel> filterdValue;
  ListViewState({required this.value,required this.filterdValue});
}

class ListViewInitial extends ListViewState {
  ListViewInitial() : super(value: [],filterdValue: []);
}
