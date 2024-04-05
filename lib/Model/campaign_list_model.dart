class CampaignListModel {
  bool? error;
  bool? status;
  List<Data>? data;
  String? msg;

  CampaignListModel({this.error, this.status, this.data, this.msg});

  CampaignListModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['msg'] = this.msg;
    return data;
  }
}

class Data {
  String? gameId;
  String? image;
  String? gameName;
  String? gameNameHindi;
  String? openTime;
  String? status;
  String? closeTime;
  String? marketStatus;
  String? date;
  String? endDate;
  String? resultDate;
  String? resultTime;
  String? ticketPrice;
  String? resultStatus;

  Data(
      {this.gameId,
        this.image,
        this.gameName,
        this.gameNameHindi,
        this.openTime,
        this.status,
        this.closeTime,
        this.marketStatus,
        this.date,
        this.endDate,
        this.resultDate,
        this.resultTime,
        this.ticketPrice,
        this.resultStatus});

  Data.fromJson(Map<String, dynamic> json) {
    gameId = json['game_id'];
    image = json['image'];
    gameName = json['game_name'];
    gameNameHindi = json['game_name_hindi'];
    openTime = json['open_time'];
    status = json['status'];
    closeTime = json['close_time'];
    marketStatus = json['market_status'];
    date = json['date'];
    endDate = json['end_date'];
    resultDate = json['result_date'];
    resultTime = json['result_time'];
    ticketPrice = json['ticket_price'];
    resultStatus = json['result_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['game_id'] = this.gameId;
    data['image'] = this.image;
    data['game_name'] = this.gameName;
    data['game_name_hindi'] = this.gameNameHindi;
    data['open_time'] = this.openTime;
    data['status'] = this.status;
    data['close_time'] = this.closeTime;
    data['market_status'] = this.marketStatus;
    data['date'] = this.date;
    data['end_date'] = this.endDate;
    data['result_date'] = this.resultDate;
    data['result_time'] = this.resultTime;
    data['ticket_price'] = this.ticketPrice;
    data['result_status'] = this.resultStatus;
    return data;
  }
}
