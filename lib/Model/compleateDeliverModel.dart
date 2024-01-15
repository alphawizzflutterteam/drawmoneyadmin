
class CompleateHistryModel {
  bool error;
  String message;
  List<CompleateDeliver> data;

  CompleateHistryModel({
    required this.error,
    required this.message,
    required this.data,
  });

  factory CompleateHistryModel.fromJson(Map<String, dynamic> json) => CompleateHistryModel(
    error: json["error"],
    message: json["message"],
    data: List<CompleateDeliver>.from(json["data"].map((x) => CompleateDeliver.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CompleateDeliver {
  String? id;
  String ?customer;
  String? userId;
  String? pickupAddress;
  String? dropAddress;
  String? surgeAmount;
  String? paidAmount;
  String? bookingType;
  String?status;
  String? cabType;
  String? reason;
  String ?deliveryBoyId;
  String? productId;
  String ?qty;
  String ?price;
  String ?otp;
  String ?emaill;
  String ?mobilee;
  DateTime? createdAt;
  List<ProductDetail>? productDetails;

  CompleateDeliver({
   this.id,
   this.customer,
   this.userId,
   this.pickupAddress,
   this.dropAddress,
   this.surgeAmount,
   this.paidAmount,
   this.bookingType,
   this.status,
   this.cabType,
   this.reason,
   this.deliveryBoyId,
   this.productId,
   this.qty,
   this.price,
   this.otp,
   this.emaill,
   this.mobilee,
   this.createdAt,
    this.productDetails

  });

  factory CompleateDeliver.fromJson(Map<String, dynamic> json) => CompleateDeliver(
    id: json["id"].toString()==null?"":json["id"].toString(),
    customer: json["customer"]==null?"":json["customer"].toString(),
    userId:  json["user_id"]==null?"":json["user_id"].toString(),
    pickupAddress: json["pickup_Address"]==null?"":json["pickup_Address"].toString(),
    dropAddress: json["drop_address"]==null?"":json["drop_address"].toString(),
    surgeAmount: json["surge_Amount"]==null?"":json["surge_Amount"].toString(),
    paidAmount: json["paid_amount"]==null?"":json["paid_amount"].toString(),
    bookingType: json["booking_type"]==null?"":json["booking_type"].toString(),
    status: json["status"]==null?"":json["status"].toString(),
    cabType: json["cab_type"]==null?"":json["cab_type"].toString(),
    reason:json["reason"]==null?"": json["reason"].toString(),
    deliveryBoyId: json["delivery_boy_id"]==null?"":json["delivery_boy_id"].toString(),
    productId:  json["product_id"]==null?"":json["product_id"].toString(),
    qty:  json["qty"]==null?"":json["qty"].toString(),
    price: json["price"]==null?"":json["price"].toString(),
    otp:  json["otp"]==null?"":json["otp"].toString(),
    emaill:  json["email"]==null?"":json["email"].toString(),
    mobilee:  json["mobile"]==null?"":json["mobile"].toString(),
    createdAt: DateTime.parse(json["created_at"]),
    productDetails:json["productDetails"]==null?[]: List<ProductDetail>.from(json["productDetails"].map((x) => ProductDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer": customer,
    "user_id": userId,
    "pickup_Address": pickupAddress,
    "drop_address": dropAddress,
    "surge_Amount": surgeAmount,
    "paid_amount": paidAmount,
    "booking_type": bookingType,
    "status": status,
    "cab_type": cabType,
    "reason": reason,
    "delivery_boy_id": deliveryBoyId,
    "product_id": productId,
    "qty": qty,
    "price": price,
    "otp": otp,
    "email": emaill,
    "mobile": mobilee,
    "created_at": createdAt,
    "productDetails": List<dynamic>.from(productDetails!.map((x) => x.toJson())),
  };



}
class ProductDetail {
  String productName;
  String qty;
  String price;

  ProductDetail({
    required this.productName,
    required this.qty,
    required this.price,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
    productName: json["product_name"],
    qty: json["qty"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "product_name": productName,
    "qty": qty,
    "price": price,
  };
}