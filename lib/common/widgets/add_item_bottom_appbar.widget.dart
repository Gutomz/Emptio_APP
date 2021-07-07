import 'package:emptio/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:emptio/helpers/extensions.dart';

class AddItemBottomAppBar extends StatelessWidget {
  const AddItemBottomAppBar({
    Key? key,
    this.onDecrementPressed,
    this.onIncrementPressed,
    this.onAddPressed,
    required this.quantity,
    this.total = 0,
    this.hideTotal = false,
  }) : super(key: key);

  final Function()? onDecrementPressed;
  final Function()? onIncrementPressed;
  final Function()? onAddPressed;
  final int quantity;
  final double total;
  final bool hideTotal;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: AppColors.blue,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.35,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.orange),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: onDecrementPressed,
                    color: Colors.white,
                    disabledColor: AppColors.grey,
                    icon: Icon(Icons.remove),
                    iconSize: 20,
                    splashRadius: 20,
                  ),
                  Text(
                    quantity.toString(),
                    style: TextStyle(
                      color: AppColors.orange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    onPressed: onIncrementPressed,
                    color: Colors.white,
                    disabledColor: AppColors.grey,
                    icon: Icon(Icons.add),
                    iconSize: 20,
                    splashRadius: 20,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.55,
              child: ElevatedButton(
                onPressed: onAddPressed,
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: !hideTotal
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.center,
                  children: [
                    Text(
                      "Adicionar",
                      style: TextStyle(
                        fontWeight:
                            !hideTotal ? FontWeight.w500 : FontWeight.w700,
                      ),
                    ),
                    if (!hideTotal)
                      Text(
                        "R\$${total.formatMoney()}",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
