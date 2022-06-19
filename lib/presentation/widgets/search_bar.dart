import 'package:flutter/material.dart';
import 'package:gestione_brand/data/classes/debouncer.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key, required this.hintText, required this.onSearch})
      : super(key: key);

  final String hintText;
  final Function(String) onSearch;

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder _borderStyle() => const OutlineInputBorder(
          // borderSide: BorderSide(color: Theme.of(context).st),
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        );
    // Brightness brightness = Theme.of(context).brightness;
    final debouncer = Debouncer(milliseconds: 500);

    return SizedBox(
      width: 300,
      height: 40,
      child: TextField(
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: hintText,
          hintMaxLines: 2,
          filled: true,
          border: _borderStyle(),
          enabledBorder: _borderStyle(),
          fillColor: Colors.transparent,
        ),
        onChanged: (query) {
          debouncer.run(() => onSearch(query));
        },
      ),
    );
  }
}
