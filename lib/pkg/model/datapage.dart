class DataPage<T> {
  final int index;
  final int size;
  final int pages;
  final int total;
  final List<T> data;

  DataPage(
      {required this.index,
      required this.size,
      required this.pages,
      required this.total,
      required this.data});

  factory DataPage.fromJson(
      Map<String, dynamic> json, T Function(dynamic json) fromJsonT) {
    try {
      var list = json['data'] as List;
      List<T> dataList = list.map((i) => fromJsonT(i)).toList();

      return DataPage(
        index: json['page']['index'],
        size: json['page']['size'],
        pages: json['page']['pages'],
        total: json['page']['total'],
        data: dataList,
      );
    } catch (e) {
      print(e);
      return DataPage(index: 0, size: 0, pages: 0, total: 0, data: []);
    }
  }
}
