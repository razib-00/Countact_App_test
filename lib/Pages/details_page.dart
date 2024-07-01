import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_029/Model/contact_model.dart';
import 'package:test_029/Provider/contact_provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Details_Page extends StatefulWidget {
  const Details_Page({super.key});
  static const String routeName="/details-page";

  @override
  State<Details_Page> createState() => _Details_PageState();
}

class _Details_PageState extends State<Details_Page> {
  @override
  Widget build(BuildContext context) {
    final argList=ModalRoute.of(context)!.settings.arguments as List;
    final id=argList[0];
    final name=argList[1];
    return Scaffold(
      appBar: AppBar(
        title:  Center(child: Text(name,style:const TextStyle(fontSize: 40,color: Colors.white),)),
        backgroundColor: Colors.red,
      ),
      body:Consumer<ContactProvider>(
        builder: (context,provider,_)=>FutureBuilder<ContactModel>(
            future: provider.getIdDataProvider(id),
            builder:( context,snapshot){
              if(snapshot.hasData){
                final contact=snapshot.data;
                return buildListviewBody(contact);
              }
              if(snapshot.hasError){
                return const Text("Failed to face data");
              }
              return const CircularProgressIndicator();
            }),
      ),
    );
  }

  dynamic buildListviewBody(ContactModel? contact) {
    return  Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Image.network(contact!.image,width: double.infinity,height: 250,fit: BoxFit.cover,),
            Card(
              elevation: 10,
              child: ListTile(
                title:  Text(contact.phone),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(onPressed: (){
                      _callContact(contact.phone);
                    },
                        child: const Icon(Icons.call,size: 30,color: Colors.lightGreen,)),
                    ElevatedButton(onPressed: (){
                      _smsContact(contact.phone);
                    },
                        child: const Icon(Icons.sms,size: 30,color: Colors.cyan,)),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 10,
              child: ListTile(
                title:  Text(contact.email),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(onPressed: (){
                      _emailContact(contact.email);
                    },
                        child: const Icon(Icons.email,size: 30,color: Colors.pinkAccent,)),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 10,
              child: ListTile(
                title:  Text(contact.website),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(onPressed: (){
                      _webContact(contact.website);
                    },
                        child: const Icon(Icons.web,size: 30,color: Colors.deepOrange,)),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 10,
              child: ListTile(
                title:  Text(contact.address),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(onPressed: (){
                      _address(contact.address);
                    },
                        child: const Icon(Icons.map,size: 30,color: Colors.redAccent,)),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 10,
              child: ListTile(
                title:  Text(contact.designation,
                  style: const TextStyle(fontSize: 30,color: Colors.lightBlueAccent),),
              ),
            ),Card(
              elevation: 10,
              child: ListTile(
                title:  Text(contact.company),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(onPressed: (){
                      _company(contact.company);
                    },
                        child: const Icon(Icons.map,size: 30,color: Colors.amber,)),
                  ],
                ),
              ),
            )
          ],
        ),

    );
  }

  void _callContact(String phone)async {
    final uri= "tel:$phone";
    if(await canLaunchUrlString(uri)){
      await launchUrlString(uri);
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Could not launch application")));
      throw "Could not launch application";
    }
  }

  void _emailContact(String email)async {
    final uri="mailto:$email";
    if(await canLaunchUrlString(uri)){
      await launchUrlString(uri);
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Could not launch application")));
      throw "Could not launch application";
    }
  }

  void _smsContact(String phone) async{
    final uri="sms:$phone";
    if(await canLaunchUrlString(uri)){
      await launchUrlString(uri);
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Could not launch application")));
      throw "Could not launch application";
    }
  }

  void _webContact(String website)async {
    final uri="https:$website";
    if(await canLaunchUrlString(uri)){
      await launchUrlString(uri);
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Could not launch application"),
      ));
      throw "Could not launch application";
    }
  }

  void _address(String address) {}

  void _company(String company) {}
}
