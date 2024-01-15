
class GetBannerModel {
  bool error;
  String message;
  List<BannerModelList> data;

  GetBannerModel({
    required this.error,
    required this.message,
    required this.data,
  });

  factory GetBannerModel.fromJson(Map<String, dynamic> json) => GetBannerModel(
    error: json["error"],
    message: json["message"],
    data: List<BannerModelList>.from(json["data"].map((x) => BannerModelList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class BannerModelList {
  String id;
  String type;
  String typeId;
  String link;
  String image;
  DateTime dateAdded;

  BannerModelList({
    required this.id,
    required this.type,
    required this.typeId,
    required this.link,
    required this.image,
    required this.dateAdded,
  });

  factory BannerModelList.fromJson(Map<String, dynamic> json) => BannerModelList(
    id: json["id"],
    type: json["type"],
    typeId: json["type_id"],
    link: json["link"],
    image: json["image"],
    dateAdded: DateTime.parse(json["date_added"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "type_id": typeId,
    "link": link,
    "image": image,
    "date_added": dateAdded.toIso8601String(),
  };
}
