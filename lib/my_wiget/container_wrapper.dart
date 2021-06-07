import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DecoratedContainer extends StatelessWidget {
  Widget _childWidget;
  DecoratedContainer(Widget child) : _childWidget = child;
  @override
  Widget build(BuildContext context) => Container(
        child: _childWidget,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              // TODO fix this shit
              color: Colors.grey[300].withOpacity(1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(3, 4), // changes position of shadow
            ),
          ],
          border: Border.all(width: 0.3),
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
      );
}

class InsideDecoratedContainer extends StatelessWidget {
  Widget _childWidget;
  InsideDecoratedContainer(Widget child) : _childWidget = child;
  @override
  Widget build(BuildContext context) => Container(
        child: _childWidget,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              // TODO fix this shit
              color: Colors.grey[300].withOpacity(1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(3, 4), // changes position of shadow
            ),
          ],
          border: Border.all(width: 0.3),
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.fromLTRB(6, 12, 6, 0),
      );
}
