import '../local_cart_model.dart';

LocalCartModel localCartModelFromJsonMapper(Map<String, dynamic> json) =>
    LocalCartModel(id: json['id'] as int, qty: json['qty'] as int);

Map<String, dynamic> localCartModelToJsonMapper(LocalCartModel instance) => <String, dynamic>{
  'id':instance.id,
  'qty':instance.qty
};