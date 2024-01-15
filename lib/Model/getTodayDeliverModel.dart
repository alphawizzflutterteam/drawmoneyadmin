
class GetDeliveryModekl {
  bool error;
  String message;
  List<GetDeliveryModeklList> data;

  GetDeliveryModekl({
    required this.error,
    required this.message,
    required this.data,
  });

  factory GetDeliveryModekl.fromJson(Map<String, dynamic> json) => GetDeliveryModekl(
    error: json["error"],
    message: json["message"],
    data: List<GetDeliveryModeklList>.from(json["data"].map((x) => GetDeliveryModeklList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetDeliveryModeklList {
  String? id;
  String?  customer;
  String?  userId;
  dynamic deleveryFrom;
  String?  pickupAddress;
  String?  dropAddress;
  String?  surgeAmount;
  String?  paidAmount;
  String?  bookingType;
  String?  status;
  String ?cabType;
  String? reason;
  String? deliveryBoyId;
  dynamic productId;
  dynamic qty;
  dynamic price;
  String ?otp;
  DateTime? createdAt;
  String ?orderData;
  String? email;
  String? mobile;
  List<ProductDetail>? productDetails;
  String? acceptStatus;

  GetDeliveryModeklList({
     this.id,
     this.customer,
     this.userId,
     this.deleveryFrom,
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
     this.createdAt,
     this.orderData,
     this.email,
     this.mobile,
     this.productDetails,
     this.acceptStatus,
  });

  factory GetDeliveryModeklList.fromJson(Map<String, dynamic> json) => GetDeliveryModeklList(
    id: json["id"],
    customer: json["customer"],
    userId: json["user_id"],
    deleveryFrom: json["delevery_from"],
    pickupAddress: json["pickup_Address"],
    dropAddress: json["drop_address"],
    surgeAmount: json["surge_Amount"],
    paidAmount: json["paid_amount"],
    bookingType: json["booking_type"],
    status: json["status"],
    cabType: json["cab_type"],
    reason: json["reason"],
    deliveryBoyId: json["delivery_boy_id"],
    productId: json["product_id"],
    qty: json["qty"],
    price: json["price"],
    otp: json["otp"],
    createdAt: DateTime.parse(json["created_at"]),
    orderData: json["order_data"],
    email: json["email"],
    mobile: json["mobile"],
    productDetails:json["productDetails"]==null?[]: List<ProductDetail>.from(json["productDetails"].map((x) => ProductDetail.fromJson(x))),
    acceptStatus: json["accept_status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer": customer,
    "user_id": userId,
    "delevery_from": deleveryFrom,
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
    "created_at": createdAt,
    "order_data": orderData,
    "email": email,
    "mobile": mobile,
    "productDetails": List<dynamic>.from(productDetails!.map((x) => x.toJson())),
    "accept_status": acceptStatus,
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