
class NotificationModel {
  bool error;
  String message;
  String total;
  List<NotifivationList> data;

  NotificationModel({
    required this.error,
    required this.message,
    required this.total,
    required this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    error: json["error"],
    message: json["message"],
    total: json["total"],
    data: List<NotifivationList>.from(json["data"].map((x) => NotifivationList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "total": total,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class NotifivationList {
  String id;
  String title;
  String message;
  String type;
  String typeId;
  String sendTo;
  dynamic usersId;
  String image;
  String link;
  DateTime dateSent;

  NotifivationList({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.typeId,
    required this.sendTo,
    required this.usersId,
    required this.image,
    required this.link,
    required this.dateSent,
  });

  factory NotifivationList.fromJson(Map<String, dynamic> json) => NotifivationList(
    id: json["id"],
    title: json["title"],
    message: json["message"],
    type: json["type"],
    typeId: json["type_id"],
    sendTo: json["send_to"],
    usersId: json["users_id"],
    image: json["image"],
    link: json["link"],
    dateSent: DateTime.parse(json["date_sent"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "message": message,
    "type": type,
    "type_id": typeId,
    "send_to": sendTo,
    "users_id": usersId,
    "image": image,
    "link": link,
    "date_sent": dateSent.toIso8601String(),
  };
}
