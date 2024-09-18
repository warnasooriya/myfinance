import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

Widget BuildBarChart(barAnimData) {
  // Implement the bar chart creation logic here using Chart widget
  return Chart(
    rebuild: false,
    data: barAnimData,
    variables: {
      'genre': Variable(
        accessor: (Map map) => map['genre'] as String,
      ),
      'sold': Variable(
        accessor: (Map map) => map['sold'] as num,
        scale: LinearScale(min: 0),
      ),
    },
    transforms: [
      Sort(compare: (tuple1, tuple2) => tuple1['sold'] - tuple2['sold'])
    ],
    marks: [
      IntervalMark(
        transition: Transition(duration: const Duration(seconds: 1)),
        entrance: {MarkEntrance.y},
        label: LabelEncode(encoder: (tuple) => Label(tuple['sold'].toString())),
        tag: (tuple) => tuple['genre'].toString(),
      )
    ],
    axes: [
      Defaults.horizontalAxis,
      Defaults.verticalAxis,
    ],
  );
}
