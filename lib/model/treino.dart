class Treino {
  final int id;
  final int data;
  final int time;

  Treino(
    this.id,
    this.data,
    this.time,
  );

  @override
  String toString() {
    return 'Treino id:$id data:$data time:$time';
  }

  Treino.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        data = json['data'],
        time = json['time'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'data': data,
        'time': time,
      };
}
