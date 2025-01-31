class DataModel {
  final String id;
  final String data;

  DataModel({required this.id, required this.data});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'data': data,
    };
  }
}