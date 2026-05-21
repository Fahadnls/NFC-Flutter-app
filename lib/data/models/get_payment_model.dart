import 'json/json_parser.dart';

GetPaymentMethodsModel getPaymentMethodsModelFromJson(
  Map<String, dynamic> map,
) => GetPaymentMethodsModel.fromJson(map);

Map<String, dynamic> getPaymentMethodsModelToJson(
  GetPaymentMethodsModel data,
) => data.toJson();

class GetPaymentMethodsModel {
  final int statusCode;
  final bool isSuccess;
  final String message;
  final List<PaymentMethod> paymentMethods;

  GetPaymentMethodsModel({
    required this.statusCode,
    required this.isSuccess,
    required this.message,
    required this.paymentMethods,
  });

  GetPaymentMethodsModel copyWith({
    int? statusCode,
    bool? isSuccess,
    String? message,
    List<PaymentMethod>? paymentMethods,
  }) => GetPaymentMethodsModel(
    statusCode: statusCode ?? this.statusCode,
    isSuccess: isSuccess ?? this.isSuccess,
    message: message ?? this.message,
    paymentMethods: paymentMethods ?? this.paymentMethods,
  );

  factory GetPaymentMethodsModel.fromJson(Map<String, dynamic> json) {
    final map = JsonHelper.parseMap(json);

    final methodsRaw = JsonHelper.parseList<dynamic>(map['paymentMethods']);
    final methods = methodsRaw
        .map((e) => PaymentMethod.fromJson(JsonHelper.parseMap(e)))
        .toList();

    return GetPaymentMethodsModel(
      statusCode: JsonHelper.parseInt(map['statusCode']),
      isSuccess: JsonHelper.parseBool(map['isSuccess']),
      message: JsonHelper.parseString(map['message']),
      paymentMethods: methods,
    );
  }

  Map<String, dynamic> toJson() => {
    'statusCode': statusCode,
    'isSuccess': isSuccess,
    'message': message,
    'paymentMethods': paymentMethods.map((x) => x.toJson()).toList(),
  };
}

class PaymentMethod {
  final int paymentMethodId;
  final String paymentMethodAr;
  final String paymentMethodEn;
  final String paymentMethodCode;
  final bool isDirectPayment;
  final int serviceCharge;
  final int totalAmount;
  final String currencyIso;
  final String imageUrl;
  final bool isEmbeddedSupported;
  final String paymentCurrencyIso;

  PaymentMethod({
    required this.paymentMethodId,
    required this.paymentMethodAr,
    required this.paymentMethodEn,
    required this.paymentMethodCode,
    required this.isDirectPayment,
    required this.serviceCharge,
    required this.totalAmount,
    required this.currencyIso,
    required this.imageUrl,
    required this.isEmbeddedSupported,
    required this.paymentCurrencyIso,
  });

  PaymentMethod copyWith({
    int? paymentMethodId,
    String? paymentMethodAr,
    String? paymentMethodEn,
    String? paymentMethodCode,
    bool? isDirectPayment,
    int? serviceCharge,
    int? totalAmount,
    String? currencyIso,
    String? imageUrl,
    bool? isEmbeddedSupported,
    String? paymentCurrencyIso,
  }) => PaymentMethod(
    paymentMethodId: paymentMethodId ?? this.paymentMethodId,
    paymentMethodAr: paymentMethodAr ?? this.paymentMethodAr,
    paymentMethodEn: paymentMethodEn ?? this.paymentMethodEn,
    paymentMethodCode: paymentMethodCode ?? this.paymentMethodCode,
    isDirectPayment: isDirectPayment ?? this.isDirectPayment,
    serviceCharge: serviceCharge ?? this.serviceCharge,
    totalAmount: totalAmount ?? this.totalAmount,
    currencyIso: currencyIso ?? this.currencyIso,
    imageUrl: imageUrl ?? this.imageUrl,
    isEmbeddedSupported: isEmbeddedSupported ?? this.isEmbeddedSupported,
    paymentCurrencyIso: paymentCurrencyIso ?? this.paymentCurrencyIso,
  );

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    final map = JsonHelper.parseMap(json);
    return PaymentMethod(
      paymentMethodId: JsonHelper.parseInt(map['PaymentMethodId']),
      paymentMethodAr: JsonHelper.parseString(map['PaymentMethodAr']),
      paymentMethodEn: JsonHelper.parseString(map['PaymentMethodEn']),
      paymentMethodCode: JsonHelper.parseString(map['PaymentMethodCode']),
      isDirectPayment: JsonHelper.parseBool(map['IsDirectPayment']),
      serviceCharge: JsonHelper.parseInt(map['ServiceCharge']),
      totalAmount: JsonHelper.parseInt(map['TotalAmount']),
      currencyIso: JsonHelper.parseString(map['CurrencyIso']),
      imageUrl: JsonHelper.parseString(map['ImageUrl']),
      isEmbeddedSupported: JsonHelper.parseBool(map['IsEmbeddedSupported']),
      paymentCurrencyIso: JsonHelper.parseString(map['PaymentCurrencyIso']),
    );
  }

  Map<String, dynamic> toJson() => {
    'PaymentMethodId': paymentMethodId,
    'PaymentMethodAr': paymentMethodAr,
    'PaymentMethodEn': paymentMethodEn,
    'PaymentMethodCode': paymentMethodCode,
    'IsDirectPayment': isDirectPayment,
    'ServiceCharge': serviceCharge,
    'TotalAmount': totalAmount,
    'CurrencyIso': currencyIso,
    'ImageUrl': imageUrl,
    'IsEmbeddedSupported': isEmbeddedSupported,
    'PaymentCurrencyIso': paymentCurrencyIso,
  };
}
