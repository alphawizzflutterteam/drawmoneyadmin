class CampainListModel {
    CampainListModel({
        required this.error,
        required this.status,
        required this.data,
        required this.msg,
    });

    final bool? error;
    final bool? status;
    final List<Datum> data;
    final String? msg;

    factory CampainListModel.fromJson(Map<String, dynamic> json){ 
        return CampainListModel(
            error: json["error"],
            status: json["status"],
            data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
            msg: json["msg"],
        );
    }

}

class Datum {
    Datum({
        required this.gameId,
        required this.image,
        required this.gameName,
        required this.gameNameHindi,
        required this.openTime,
        required this.status,
        required this.closeTime,
        required this.marketStatus,
        required this.ticketMaxCount,
        required this.prizeName,
        required this.date,
        required this.endDate,
        required this.resultDate,
        required this.resultTime,
        required this.ticketPrice,
        required this.resultStatus,
    });

    final String? gameId;
    final String? image;
    final String? gameName;
    final String? gameNameHindi;
    final String? openTime;
    final String? status;
    final String? closeTime;
    final String? marketStatus;
    final String? ticketMaxCount;
    final String? prizeName;
    final DateTime? date;
    final DateTime? endDate;
    final DateTime? resultDate;
    final String? resultTime;
    final String? ticketPrice;
    final String? resultStatus;

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            gameId: json["game_id"],
            image: json["image"],
            gameName: json["game_name"],
            gameNameHindi: json["game_name_hindi"],
            openTime: json["open_time"],
            status: json["status"],
            closeTime: json["close_time"],
            marketStatus: json["market_status"],
            ticketMaxCount: json["ticket_max_count"],
            prizeName: json["prize_name"],
            date: DateTime.tryParse(json["date"] ?? ""),
            endDate: DateTime.tryParse(json["end_date"] ?? ""),
            resultDate: DateTime.tryParse(json["result_date"] ?? ""),
            resultTime: json["result_time"],
            ticketPrice: json["ticket_price"],
            resultStatus: json["result_status"],
        );
    }

}
