import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText({super.key, required this.text});

  final String text;

  @override
  ExpandableTextState createState() => ExpandableTextState();
}

class ExpandableTextState extends State<ExpandableText>
    with TickerProviderStateMixin<ExpandableText> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedSize(
            duration: const Duration(milliseconds: 500),
            child: ConstrainedBox(
                constraints: isExpanded
                    ? const BoxConstraints()
                    : const BoxConstraints(maxHeight: 90.0),
                child: Text(
                  widget.text,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 204, 204, 204),
                    fontFamily: 'Poppins',
                    fontSize: 15,
                  ),
                ))),
        isExpanded
            ? TextButton(
                child: const Text(
                  'Hide <<',
                  style: TextStyle(
                    color: Color(0xFF9D4EDD),
                    fontFamily: 'Poppins',
                    fontSize: 15,
                  ),
                ),
                onPressed: () => setState(() => isExpanded = false),
              )
            : TextButton(
                child: const Text(
                  'Read More >>',
                  style: TextStyle(
                    color: Color(0xFF9D4EDD),
                    fontFamily: 'Poppins',
                    fontSize: 15,
                  ),
                ),
                onPressed: () => setState(() => isExpanded = true),
              ),
      ],
    );
  }
}
