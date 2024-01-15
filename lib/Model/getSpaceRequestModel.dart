
class GetSpaceRequest {
  bool error;
  String message;
  List<RequestList> data;

  GetSpaceRequest({
    required this.error,
    required this.message,
    required this.data,
  });

  factory GetSpaceRequest.fromJson(Map<String, dynamic> json) => GetSpaceRequest(
    error: json["error"],
    message: json["message"],
    data: List<RequestList>.from(json["data"].map((x) => RequestList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class RequestList {
  String ?id;
  String? userId;
  String? from;
  String? to;
  String ?vehicle;
  String ?date;
  String? time;
  DateTime ?createdAt;

  RequestList({
   this.id,
   this.userId,
   this.from,
   this.to,
   this.vehicle,
   this.date,
   this.time,
   this.createdAt,
  });

  factory RequestList.fromJson(Map<String, dynamic> json) => RequestList(
    id: json["id"],
    userId: json["user_id"],
    from: json["from"],
    to: json["to"],
    vehicle: json["vehicle"],
    date: json["date"],
    time: json["time"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "from": from,
    "to": to,
    "vehicle": vehicle,
    "date": date,
    "time": time,
    "created_at": createdAt,
  };
}
