import 'package:emptio/views/purchase_details/store/purchase_details.store.dart';
import 'package:flutter/material.dart';

class PurchaseDetailsEndDrawer extends StatelessWidget {
  const PurchaseDetailsEndDrawer({
    Key? key,
    required PurchaseDetailsStore store,
  })  : _store = store,
        super(key: key);

  final PurchaseDetailsStore _store;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.horizontal(left: Radius.circular(100)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        child: Drawer(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
