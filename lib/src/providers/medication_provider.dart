import 'dart:collection';

import 'package:flutter/widgets.dart';

class MedicationProvider extends ChangeNotifier {
  // final item;
  // final measurement;

  // LogModel({this.item, this.measurement});

  /// Internal, private state of the cart.
  final List<LogMeasurement> _items = <LogMeasurement>[
    // LogMeasurement(
    //     item: '',
    //     timestamp: new DateFormat.jm().format(new DateTime.now()))
  ];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<LogMeasurement> get items =>
      UnmodifiableListView(_items);

  /// Adds [item] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void add(LogMeasurement item) {
    _items.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeAll() {
    _items.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void remove(int index) {
    _items.removeAt(index);

    notifyListeners();
  }
}

class LogMeasurement {
  final item;
  final measurement;
  final timestamp;

  LogMeasurement({this.item, this.measurement, this.timestamp});
}
