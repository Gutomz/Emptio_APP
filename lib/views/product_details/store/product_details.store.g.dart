// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProductDetailsStore on _ProductDetailsStoreBase, Store {
  final _$productAtom = Atom(name: '_ProductDetailsStoreBase.product');

  @override
  ProductModel get product {
    _$productAtom.reportRead();
    return super.product;
  }

  @override
  set product(ProductModel value) {
    _$productAtom.reportWrite(value, super.product, () {
      super.product = value;
    });
  }

  final _$loadingAtom = Atom(name: '_ProductDetailsStoreBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  @override
  String toString() {
    return '''
product: ${product},
loading: ${loading}
    ''';
  }
}
