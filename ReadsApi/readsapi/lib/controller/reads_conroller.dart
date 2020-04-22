import 'package:aqueduct/aqueduct.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:readsapi/Models/Read.dart';
import 'dart:async';

class ReadsController extends ResourceController{
  ReadsController(){
     mongo();
  }
  final Db _db = Db("mongodb://localhost:27017/test");
  DbCollection coll;
  
  Future mongo()async{
    await _db.open();
    print("Monga Succes");
    coll = _db.collection('reads');
  }
  @Operation.get()
  Future<Response> getAllReads() async{
    final readss = await coll.find().toList();
    await _db.close();
    return Response.ok(readss);
  }
  @Operation.get('id')
  Future<Response> getRead(@Bind.path('id')String tur) async{
    final readss = await coll.findOne({"id":int.parse(tur)});
    await _db.close();
    return Response.ok(readss);
  }
  @Operation.post()
  Future<Response> createNewRead(@Bind.body() Read body) async{
    await coll.save(body.asMap());
    return Response.ok(body);
  }
  @Operation.put('id')
  Future<Response> updateRead(@Bind.path('id')int id,@Bind.body() Read body) async{
    await coll.update(
      {"id":id},
      {
       r'$set':{
      'kitap': body.baslik ,
      'tur': body.tur,
      'sayfa':body.sayfa
    }
      }
    );
    await _db.close();
    return Response.ok("Operation update");
  }
  @Operation.delete('id')
  Future<Response> deleteRead(@Bind.path('id')int id) async{
    await coll.remove({"id":id});
    await _db.close();
    return Response.ok("Operation delete");
  }
}