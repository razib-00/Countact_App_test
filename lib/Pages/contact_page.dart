import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_029/CustomItem/contact_item.dart';
import 'package:test_029/Pages/add_contact_page.dart';
import 'package:test_029/Provider/contact_provider.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});
  static const String routeName="/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Center(
            child: Text("Contact",style: TextStyle(color: Colors.white,fontSize: 40),)),
        backgroundColor: Colors.pinkAccent,
      ),
      body:Consumer<ContactProvider>(
          builder:(context,provider,_)=>ListView.builder(
            itemCount: provider.contactlist.length,
            itemBuilder: (context,index){
              final contact=provider.contactlist[index];
              return Contact_Item(contact);
            },
          )
           ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          Navigator.pushNamed(context, Add_New.routeName);
        },
      ),
    );
  }
}
