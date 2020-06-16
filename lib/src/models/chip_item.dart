class ChipItem {
  final id;
  final name;
  List<String> listData;
  dynamic value;
  final multiple;

  ChipItem(
      {this.id, this.name, this.value, this.listData, this.multiple = false});
}
