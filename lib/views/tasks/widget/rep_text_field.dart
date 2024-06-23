// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:todo_app/utils/app_str.dart';

class RepTextField extends StatelessWidget {
  const RepTextField({
    super.key,
    required this.controller,
    this.isForDescription = false,
    this.onFieldSubmitted,
    this.onChanged,
  });

  final TextEditingController? controller;
  final bool isForDescription;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      width: double.infinity,
      child: ListTile(
        title: TextFormField(
          controller: controller,
          maxLines: !isForDescription ? 6 : null,
          cursorHeight: !isForDescription ? 60 : null,
          style: const TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            border: isForDescription ? InputBorder.none : null,
            counter: Container(),
            hintText: isForDescription ? AppString.addNote : null,
            prefixIcon: isForDescription
                ? const Icon(
                    Icons.bookmark_border,
                    color: Colors.grey,
                  )
                : null,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.shade300,
              ),
            ),
          ),
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
