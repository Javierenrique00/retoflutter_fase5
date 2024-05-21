
import '../local_session_model.dart';

LocalSessionModel localSessionModelFromJsonMapper(Map<String, dynamic> json) => LocalSessionModel(
  email: json['email'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  isLoged: json['isLoged'] as bool,
  pwd: json['pwd'] as String);

Map<String, dynamic> localSessionModelToJsonMapper(LocalSessionModel instance) =>
<String, dynamic>{
  'email': instance.email,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'isLoged': instance.isLoged,
  'pwd': instance.pwd
};