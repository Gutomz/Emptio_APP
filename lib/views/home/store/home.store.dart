import 'package:emptio/views/purchases/purchases.view.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
part 'home.store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {

  final List<Widget> views;

  _HomeStoreBase(this.views);

  @observable
  int currentTab = 0;

  @observable
  Widget currentView = PurchasesView();

  @action
  void changeTab(int index) {
    currentTab = index;
    currentView = views[index];
  }
}
