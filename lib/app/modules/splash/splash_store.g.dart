// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'splash_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SplashStore on _SplashStoreBase, Store {
  final _$valueAtom = Atom(name: '_SplashStoreBase.value');

  @override
  int get value {
    _$valueAtom.reportRead();
    return super.value;
  }

  @override
  set value(int value) {
    _$valueAtom.reportWrite(value, super.value, () {
      super.value = value;
    });
  }

  final _$_SplashStoreBaseActionController =
      ActionController(name: '_SplashStoreBase');

  @override
  dynamic initPage() {
    final _$actionInfo = _$_SplashStoreBaseActionController.startAction(
        name: '_SplashStoreBase.initPage');
    try {
      return super.initPage();
    } finally {
      _$_SplashStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void increment() {
    final _$actionInfo = _$_SplashStoreBaseActionController.startAction(
        name: '_SplashStoreBase.increment');
    try {
      return super.increment();
    } finally {
      _$_SplashStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
value: ${value}
    ''';
  }
}
