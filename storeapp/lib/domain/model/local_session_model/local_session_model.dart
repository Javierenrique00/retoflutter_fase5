


class LocalSessionModel {

  LocalSessionModel({required this.email, required this.firstName, required this.lastName, required this.isLoged, required this.pwd});

  final String email;
  final String firstName;
  final String lastName;
  final bool isLoged;
  final String pwd;

  @override
  String toString()=> '$email,$firstName..isloged:$isLoged';

  

}