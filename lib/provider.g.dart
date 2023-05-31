// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SiProvider on _SiProviderBase, Store {
  Computed<List<User>>? _$getDataComputed;

  @override
  List<User> get getData =>
      (_$getDataComputed ??= Computed<List<User>>(() => super.getData,
              name: '_SiProviderBase.getData'))
          .value;

  late final _$stateDataAtom =
      Atom(name: '_SiProviderBase.stateData', context: context);

  @override
  ObservableList<User> get stateData {
    _$stateDataAtom.reportRead();
    return super.stateData;
  }

  @override
  set stateData(ObservableList<User> value) {
    _$stateDataAtom.reportWrite(value, super.stateData, () {
      super.stateData = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_SiProviderBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$pageAtom = Atom(name: '_SiProviderBase.page', context: context);

  @override
  int get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(int value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  late final _$requestDataAsyncAction =
      AsyncAction('_SiProviderBase.requestData', context: context);

  @override
  Future requestData() {
    return _$requestDataAsyncAction.run(() => super.requestData());
  }

  @override
  String toString() {
    return '''
stateData: ${stateData},
isLoading: ${isLoading},
page: ${page},
getData: ${getData}
    ''';
  }
}
