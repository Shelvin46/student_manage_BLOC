part of 'list_view_bloc.dart';

@immutable
abstract class ListViewEvent {}

class ListViewManage extends ListViewEvent {}

class ListStudentDelete extends ListViewEvent {
  int index;
  ListStudentDelete({required this.index});
}

class ListSearchView extends ListViewEvent {
  String query;
  ListSearchView({required this.query});
}

class NullView extends ListViewEvent {}
