import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_029/Model/contact_model.dart';
import 'package:test_029/Provider/contact_provider.dart';

class Add_New extends StatefulWidget {
  const Add_New({super.key});
  static const String routeName="/add-new";

  @override
  State<Add_New> createState() => _Add_NewState();
}

class _Add_NewState extends State<Add_New> {
  final _controllerName=TextEditingController();
  final _controllerPhone=TextEditingController();
  final _controllerEmail=TextEditingController();
  final _controllerAddress=TextEditingController();
  final _controllerGPO=TextEditingController();
  final _controllerCompany=TextEditingController();
  final _controllerDesignation=TextEditingController();
  final _controllerWebsite=TextEditingController();

  final _formKey=GlobalKey<FormState>();

  late ContactProvider _provider;
  bool isInit=true;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if(isInit){
      _provider=Provider.of<ContactProvider>(context,listen: false);
    }
    super.didChangeDependencies();
  }
  @override
  void dispose(){
    _controllerName.dispose();
    _controllerPhone.dispose();
    _controllerEmail.dispose();
    _controllerAddress.dispose();
    _controllerGPO.dispose();
    _controllerCompany.dispose();
    _controllerDesignation.dispose();
    _controllerWebsite.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Contact"),
        backgroundColor: Colors.lightGreen,
        actions: [
          IconButton(onPressed: save, icon:const Icon(Icons.save))
        ],
      ),
      body:Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                child: TextFormField(
                  controller: _controllerName,
                  decoration:const InputDecoration(border: InputBorder.none,label:Text ("Name*",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,))),
                  validator: (value){
                    if(value==null||value.isEmpty){
                      return ("Filed must not be empty");
                    }
                    if(value.length>20){
                      return("Filed character less than 20");
                    }
                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _controllerPhone,
                  decoration:const InputDecoration(label:Text("Phone*",style: TextStyle(decoration: TextDecoration.none,fontSize: 17,fontWeight: FontWeight.bold)),border: InputBorder.none),
                  validator: (value){
                    if(value==null||value.isEmpty){
                      return ("Filed must not be empty");
                    }
                    if(value.length>14){
                      return("Filed character less than 14");
                    }
                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _controllerEmail,
                  decoration:const InputDecoration(label:Text( "Email",style: TextStyle(decoration: TextDecoration.none,fontSize: 17,fontWeight: FontWeight.bold)),border: InputBorder.none,),
                ),
              ),
            ),
            const SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                child: TextFormField(
                  keyboardType: TextInputType.streetAddress,
                  controller: _controllerAddress,
                  decoration:const InputDecoration(label:Text ("Address/Street",style: TextStyle(decoration: TextDecoration.none,fontSize: 17,fontWeight: FontWeight.bold)),border: InputBorder.none,),
                ),
              ),
            ),
            const SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _controllerGPO,
                  decoration:const InputDecoration(label:Text( "GPO/POST CODE",style: TextStyle(decoration: TextDecoration.none,fontSize: 17,fontWeight: FontWeight.bold)),border: InputBorder.none,),
                ),
              ),
            ),
            const SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _controllerCompany,
                  decoration:const InputDecoration(label:Text( "Company",style: TextStyle(decoration: TextDecoration.none,fontSize: 17,fontWeight: FontWeight.bold)),border: InputBorder.none,),
                ),
              ),
            ),
            const SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _controllerDesignation,
                  decoration:const InputDecoration(label:Text ("Designation",style: TextStyle(decoration: TextDecoration.none,fontSize: 17,fontWeight: FontWeight.bold)),border: InputBorder.none,),
                ),
              ),
            ),
            const SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                child: TextFormField(
                  keyboardType: TextInputType.url,
                  controller: _controllerWebsite,
                  decoration:const InputDecoration(label:Text("Website",style: TextStyle(decoration: TextDecoration.none,fontSize: 17,fontWeight: FontWeight.bold)),border: InputBorder.none,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void save() {
    if(_formKey.currentState!.validate()){
      final contact=ContactModel(
          name: _controllerName.text,
          phone: _controllerPhone.text,
          email: _controllerEmail.text,
          address: _controllerAddress.text,
          gpo: _controllerGPO.text,
          company: _controllerCompany.text,
          designation: _controllerDesignation.text,
          website: _controllerWebsite.text
      );
     // print(contact);
      _provider.insertdataprovider(contact).then((rowId){
        contact.id=rowId;
        Navigator.pop(context);
      }).catchError((error){
        throw error;
      });

    }
  }
}
