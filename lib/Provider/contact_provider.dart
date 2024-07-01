import 'package:flutter/foundation.dart';
import 'package:test_029/Database/contact_db.dart';
import 'package:test_029/Model/contact_model.dart';

class ContactProvider with ChangeNotifier{
  List<ContactModel>_contactList=[];
  List<ContactModel>get contactlist=>_contactList;

  //insert provider
  Future<int>insertdataprovider(ContactModel contactModel)async{
    int insertdataId=await DbHelper.insertdate(contactModel);
    updateList(await DbHelper.getIddata(insertdataId));
    return insertdataId;
  }
  // get all data provider
 void getAllDataProvider()async{
   _contactList=await DbHelper.getAlldata();
   notifyListeners();
 }
 // get id data provider
 Future<ContactModel>getIdDataProvider(int id )=>DbHelper.getIddata(id);
 //update
 void updateList(ContactModel model){
   _contactList.add(model);
   notifyListeners();
 }
 //delete data provider
 Future<void>deleteProviderData(int id )async{
   await DbHelper.deletedata(id);
   _contactList.removeWhere((contact) => contact.id==id);
   notifyListeners();
 }

 Future<int> UpdateFavorite(int id, int value)async{
   return await DbHelper.updateFavorite(id, value);
   //notifyListeners();
 }
}