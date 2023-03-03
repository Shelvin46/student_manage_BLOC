import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';
import 'package:sms/model/database_model.dart';
import 'package:sms/model/dbfunction.dart';

part 'list_view_event.dart';
part 'list_view_state.dart';

class ListViewBloc extends Bloc<ListViewEvent, ListViewState> {
  ListViewBloc() : super(ListViewInitial()) {
    on<ListViewManage>((event, emit) {
      final result = model.listenable();
      List<StudentModel> value = model.values.toList();
      return emit(ListViewState(value: value, filterdValue: []));
    });
    on<ListStudentDelete>((event, emit) async {
      final values = model.values.toList();
      await model.deleteAt(event.index);
      await values.removeAt(event.index);
      return emit(ListViewState(value: values, filterdValue: values));
    });
    on<ListSearchView>((event, emit) {
      final result = model.listenable();
      List<StudentModel> value = model.values.toList();
      List<StudentModel> filteredValue = value.where((student) {
        final name = student.name.toLowerCase();
        final query = event.query!.toLowerCase();
        return name.contains(query);
      }).toList();
      return emit(ListViewState(value: [], filterdValue: filteredValue));
    });
  }
}