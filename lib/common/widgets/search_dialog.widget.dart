import 'package:emptio/core/app_colors.dart';
import 'package:flutter/material.dart';

class SearchDialog extends StatelessWidget {
  SearchDialog({
    required this.currentSearch,
    this.textInputAction,
    Key? key,
  })  : _controller = TextEditingController(text: currentSearch),
        super(key: key);

  final String currentSearch;

  final TextEditingController _controller;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 2,
          left: 2,
          right: 2,
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: TextField(
              controller: _controller,
              autofocus: true,
              textInputAction: textInputAction ?? TextInputAction.search,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                prefixIcon: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.arrow_back, color: AppColors.grey),
                ),
                suffixIcon: IconButton(
                  onPressed: () => _controller.clear(),
                  icon: Icon(Icons.close, color: AppColors.grey),
                ),
              ),
              onSubmitted: (text) => Navigator.of(context).pop(text),
            ),
          ),
        ),
      ],
    );
  }
}
