class Environment {
  final id;
  final name;
  final ip;

  Environment({this.id, this.name, this.ip});

  factory Environment.fromJson(Map<String, dynamic> json) => Environment(
        id: json["id"],
        name: json["name"],
        ip: json["ip"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "ip": ip,
      };
}
