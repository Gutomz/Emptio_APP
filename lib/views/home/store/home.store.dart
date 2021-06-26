import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'home.store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  final PageStorageBucket bucket = PageStorageBucket();

  @observable
  int currentTab = 0;

  @action
  void changeTab(int index) => currentTab = index;
}
