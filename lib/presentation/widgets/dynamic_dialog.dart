import 'package:flutter/material.dart';
import 'package:gestione_brand/data/classes/dialog_action.dart';

class DynamicDialog extends StatefulWidget {
  const DynamicDialog(
      {Key? key, this.title, this.message, this.actions, this.content})
      : super(key: key);

  final String? title;
  final String? message;
  final Widget? content;
  final List<DialogAction>? actions;

  @override
  State<DynamicDialog> createState() => _DynamicDialogState();
}

class _DynamicDialogState extends State<DynamicDialog> {
  Widget _actions() {
    return widget.actions != null
        ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              for (DialogAction action in widget.actions!)
                OutlinedButton(
                  onPressed: () => action.callback(),
                  style: ElevatedButton.styleFrom(
                    primary: action.isPositive ? null : Colors.grey.shade500,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                  ),
                  child: Text(
                    action.text,
                    style: TextStyle(
                        color: action.isPositive ? Colors.white : Colors.black),
                  ),
                )
            ],
          )
        : const SizedBox();
  }

  Widget _title() => widget.title != null
      ? Text(
          widget.title!,
          style: Theme.of(context).textTheme.headline5,
          textAlign: TextAlign.center,
        )
      : const SizedBox();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: widget.title == null ? EdgeInsets.zero : null,
      title: _title(),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            if (widget.message != null)
              Text(widget.message!,
                  style: Theme.of(context).textTheme.bodyText2,
                  textAlign: TextAlign.center),
            if (widget.content != null && widget.title != null)
              const SizedBox(height: 10.0),
            if (widget.content != null) widget.content!,
            if (widget.actions != null) const SizedBox(height: 16.0),
            _actions()
          ],
        ),
      ),
    );
  }
}
