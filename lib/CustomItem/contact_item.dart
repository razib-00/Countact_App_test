import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_029/Model/contact_model.dart';
import 'package:test_029/Pages/details_page.dart';
import 'package:test_029/Provider/contact_provider.dart';

class Contact_Item extends StatefulWidget {
  final ContactModel contactModel;
  //const Contact_Item({super.key});

   const Contact_Item(this.contactModel);

  @override
  State<Contact_Item> createState() => _Contact_ItemState();
}

class _Contact_ItemState extends State<Contact_Item> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(
        padding: const EdgeInsets.only(right: 8.0),
        alignment: Alignment.centerRight,
        color: Colors.red,
        child:const Icon(Icons.delete,size: 60,color: Colors.white,),
      ),
      confirmDismiss:showDialogbody,
      onDismissed: (_){
        Provider.of<ContactProvider>(context,listen: false).deleteProviderData(widget.contactModel.id);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              onTap: (){
                Navigator.pushNamed(context, Details_Page.routeName,arguments: [
                  widget.contactModel.id,
                  widget.contactModel.name
                ]);
              },
              title:  Text(widget.contactModel.name),
              subtitle: Text(widget.contactModel.phone),
              trailing: Consumer<ContactProvider>(
                builder: (context,provider,child)=> IconButton(
                  onPressed: (){
                    final value=widget.contactModel.favorite?0:1;
                    provider.UpdateFavorite(widget.contactModel.id, value).then((value){
                      setState(() {
                        widget.contactModel.favorite=!widget.contactModel.favorite;
                      });
                    });
                  },
                  icon: Icon(
                    widget.contactModel.favorite?(Icons.favorite):Icons.favorite_border,
                    color: Colors.red,),
                ),
              ),

            ),
          ),
        ),
      ),
    );
  }
  Future<bool?>showDialogbody(DismissDirection direction){
    return showDialog(
        context: context,
        builder: (context)=>AlertDialog(
          backgroundColor: Colors.black54,
          title: const Center(child:  Text("Delete",style: TextStyle(fontSize: 40,color: Colors.red),)),
          content:const Text("Sure to delete this contact",style: TextStyle(fontSize: 25,color: Colors.white)),
          actions:[
            ElevatedButton(onPressed: (){
              Navigator.pop(context,false);
            }, child: const Text("CANSEL",style: TextStyle(fontSize: 20,color: Colors.blue),)),
            const SizedBox(width: 30,),
            ElevatedButton(onPressed: (){
              Navigator.pop(context,true);
            }, child: const Text("YES",style: TextStyle(fontSize: 20,color: Colors.red),))
          ]
        )
    );
  }
}
