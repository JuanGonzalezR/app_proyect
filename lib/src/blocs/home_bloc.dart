// ignore_for_file: unnecessary_getters_setters

import 'dart:async';
import 'package:app/src/blocs/validators.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc with Validators {

  final _currentPageController      = BehaviorSubject<int>();

  Stream<int> get currentIndexPage        => _currentPageController.stream.transform(validaCurrentPage);
  
  Function(int) get changeCurrentIndexPage     => _currentPageController.sink.add;

  int? get getCurrentIndexPage   => _currentPageController.valueOrNull;


  dispose() {
    _currentPageController.close();
  }
}