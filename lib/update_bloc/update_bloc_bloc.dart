import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:sms/model/database_model.dart';
import '../model/dbfunction.dart';
part 'update_bloc_event.dart';
part 'update_bloc_state.dart';

class UpdateBlocBloc extends Bloc<UpdateBlocEvent, UpdateBlocState> {
  UpdateBlocBloc() : super(UpdateBlocInitial()) {
    on<DetalisShow>((event, emit) {
      List<StudentModel>? value = model.values.toList();
      return emit(UpdateBlocState(values: value));
    });
  }
}
