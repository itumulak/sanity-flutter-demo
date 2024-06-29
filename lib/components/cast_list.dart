import 'package:flutter/material.dart';

import '../models/cast.dart';

class CastList extends StatefulWidget {
  const CastList({super.key, required this.casts});

  final List<Cast> casts;

  @override
  State<CastList> createState() => _CastListState();
}

class _CastListState extends State<CastList> {
  @override
  Widget build(BuildContext context) {
    Widget outputCast(List<Cast> casts) {
      String castList = '';
      int count = 0;

      for (var cast in casts) {
        if (casts.length - 1 > count) {
          castList += '${cast.name} - ';
        } else {
          castList += cast.name;
        }

        count++;
      }

      return Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 20,
        ),
        child: Text(
          castList,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18),
        ),
      );
    }

    return outputCast(widget.casts);
  }
}
