import 'package:aqueduct/aqueduct.dart';


class Read extends Serializable{
  int id;
  String baslik;
  String tur;
  double sayfa;
  @override
  Map<String,dynamic > asMap()=> {
      'id': id,
      'kitap': baslik,
      'tur': tur,
      'sayfa':sayfa
    };
  @override
  void readFromMap(Map<String,dynamic> requestBody) {
    id=int.parse(requestBody['id'].toString());
    baslik=requestBody['kitap'] as String;
    tur=requestBody['tur'] as String;
    sayfa = requestBody['sayfa'] as double;
  }

}