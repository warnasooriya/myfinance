import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

Widget BuildRoseChart(data) {
  // Implement the rose chart creation logic here using Chart widget
  return Expanded(
    child: Chart(
      rebuild: true,
      data: data,
      variables: {
        'name': Variable(
          accessor: (Map map) => map['name'] as String,
        ),
        'value': Variable(
          accessor: (Map map) => map['value'] as num,
          scale: LinearScale(min: 0, marginMax: 0.1),
        ),
      },
      marks: [
        IntervalMark(
          label:
              LabelEncode(encoder: (tuple) => Label(tuple['name'].toString())),
          shape: ShapeEncode(
              value: RectShape(
            borderRadius: const BorderRadius.all(Radius.circular(1)),
          )),
          color: ColorEncode(variable: 'name', values: Defaults.colors10),
          elevation: ElevationEncode(value: 1),
          transition: Transition(
              duration: const Duration(seconds: 5), curve: Curves.elasticOut),
          entrance: {MarkEntrance.y},
        )
      ],
      coord: PolarCoord(startRadius: 0.01),
      padding: (_) => const EdgeInsets.all(0),
    ),
  );
}
