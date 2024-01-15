
class FaqDataModel {
  bool error;
  String message;
  List<Faqllist> data;

  FaqDataModel({
    required this.error,
    required this.message,
    required this.data,
  });

  factory FaqDataModel.fromJson(Map<String, dynamic> json) => FaqDataModel(
    error: json["error"],
    message: json["message"],
    data: List<Faqllist>.from(json["data"].map((x) => Faqllist.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Faqllist {
  String id;
  String question;
  String answer;
  String status;

  Faqllist({
    required this.id,
    required this.question,
    required this.answer,
    required this.status,
  });

  factory Faqllist.fromJson(Map<String, dynamic> json) => Faqllist(
    id: json["id"],
    question: json["question"],
    answer: json["answer"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question": question,
    "answer": answer,
    "status": status,
  };
}
