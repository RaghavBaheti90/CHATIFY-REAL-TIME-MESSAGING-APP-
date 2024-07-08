import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final void Function()? onTap;
  final String text;

  const CustomButton({Key? key, required this.text, required this.onTap})
      : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: Text(widget.text),
        ),
      ),
    );
  }
}
