//
// import "package:http/http.dart" as http;
// import 'package:maternuncle/Users.dart';
//
// class Services {
//   static const String url = 'database.json';
//  // static const String url = "http://app.quicktype.io/";
//   static Future<List<Users>> getUsers() async {
//     try {
// final response = await http.get(url);
// if(200==response.statusCode){
//   final List<Users> users = usersFromJson(response.body);
// return users;
// }
// else{
//   return List<Users>();
// }
//     }
//     catch(e){
//       return List<Users>();
//     }
//   }
//}