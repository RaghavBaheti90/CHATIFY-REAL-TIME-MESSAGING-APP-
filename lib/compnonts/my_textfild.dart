import 'package:flutter/material.dart';

class MYTextFidls extends StatefulWidget {
  final String hintText;
  final bool obscure;
  final TextEditingController controller;
  final FocusNode? focusNode;

  const MYTextFidls(
      {super.key,
      required this.hintText,
      required this.obscure,
      required this.controller,
      this.focusNode});

  @override
  State<MYTextFidls> createState() => _MYTextFidlsState();
}

class _MYTextFidlsState extends State<MYTextFidls> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        obscureText: widget.obscure,
        controller: widget.controller,
        focusNode: widget.focusNode,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.tertiary),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary),
            ),
            fillColor: Theme.of(context).colorScheme.secondary,
            filled: true,
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary)),
      ),
    );
  }
}
