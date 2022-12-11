
// ignore_for_file: camel_case_types
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:voteinorout/listOfLeaders.dart';
import 'package:recase/recase.dart';


class addALeader extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const addALeader();

  @override
  addALeaderState createState() => addALeaderState();
}

class addALeaderState extends State<addALeader> {

TextEditingController name = TextEditingController();
TextEditingController surname = TextEditingController();
TextEditingController title = TextEditingController();
final storage = FirebaseStorage.instance;
FirebaseDatabase database = FirebaseDatabase.instance;

String picUrl = "";
String nameString ="";
String surnameString ="";
String titleString ="";
File? image;
PlatformFile? pickedFile;
UploadTask? uploadTask;


saveLeaderData(){

         Fluttertoast.showToast(
                    msg: "Submiting your entry ....",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
      
  
     final nameControl = name.text;
     final surnameControl = surname.text;
     final titleControl = title.text;
    
Future.delayed(const Duration(milliseconds: 3000),(){
   
FirebaseFirestore.instance.collection("Leader")
.doc("${nameControl.trim().sentenceCase} ${surnameControl.trim().sentenceCase}").set({
  "name" : nameControl.trim().sentenceCase,
  "surname" : surnameControl.trim().sentenceCase,
  "title" : titleControl.trim().sentenceCase,
  "image" : picUrl,
  "Calculated%" : "0",
  "VoterVoted" : "1",
  "VotesMade" : "1"
});



 Fluttertoast.showToast(
                    msg: "Post Submited. Thank you",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0
                );

 Navigator.of(context).push(MaterialPageRoute(builder: (context) => const listOfLeaders()));
               

});

     debugPrint(nameControl + surnameControl + titleControl);
     debugPrint("$image");
}

 pickImage() async {
   try{
   
 final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if(image == null){
              Fluttertoast.showToast(
                    msg: " No image was selected",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
   
       return; }


  final imageTemporary = File(image.path);  

    setState(() async {

        this.image = imageTemporary; 
        Future.delayed(const Duration(milliseconds: 500),(){
              setState(() {
                this.image =imageTemporary;
              });    
                 
                             
                  
                  });

         Fluttertoast.showToast(
                    msg: "Image is loading ....",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
      

    

                Future.delayed(const Duration(milliseconds: 1500),(){
                  
                  uploadFile();
                             
                  
                  });
      });
 
 }catch(e){debugPrint("Pick Image method error*** $e");}
 

}

Future uploadFile() async{
    debugPrint('uploade File method running..........$image...');

  final path = 'files/${image!}';
  final file = File(image!.path);



  final ref = FirebaseStorage.instance.ref().child(path);
  uploadTask = ref.putFile(file);

  final snapshot = await uploadTask!.whenComplete((){});
  final urlDownload = await snapshot.ref.getDownloadURL();
  picUrl = urlDownload;


}



@override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
   return Scaffold(

    appBar: AppBar(title: const Text("Add a leader"),),
      body: 
      SingleChildScrollView(child: 
      
      Column(children: [
                Container(height: 20,),

       const Text("1.Make sure your entry is not already in the list"),
       Container(height: 10,),
       const Text("2.Have the entrant's decent pic is on your phone"),



        Container(height: 20,),
        
       image !=null? Image.file(image!,
       height: MediaQuery.of(context).size.height/3, 
              width: MediaQuery.of(context).size.width/1.3,
              fit: BoxFit.cover,
              ) 
              
              : GestureDetector(
          onTap:(){
            pickImage();
            debugPrint("===Pick Image pressed===");
          },
                  child: Center(
            child: Container(
             
              color: Colors.grey,
              height: MediaQuery.of(context).size.height/3, 
              width: MediaQuery.of(context).size.width/1.3,
               child: const 
               Icon( Icons.photo, size: 100,),
              ),
          ),
        ),
         

                //  Container(
                //    color: Colors.pink,
                //    child: Text("HI"),
                //    height: 220,),

                 SizedBox(
                   width: MediaQuery.of(context).size.width/1.3,
                   child: TextFormField(
                     controller: name,
                     decoration: const InputDecoration(
                       labelText: "Name"
                     )
                     
                   )),
                    Container(height: 20,),

                 SizedBox(
                   width: MediaQuery.of(context).size.width/1.3,
                   child: TextFormField(
                     controller: surname,
                     decoration: const InputDecoration(
                       labelText: "Surname"
                     )
                     
                   )),

                   Container(height: 20,),

                 SizedBox(
                   width: MediaQuery.of(context).size.width/1.3,
                   child: TextFormField(
                     controller: title,
                     decoration: const InputDecoration(
                       labelText: "Role/Job/Title"
                     )
                     
                   )),

                                      Container(height: 20,),



                   ElevatedButton(onPressed: (){

                     if(name.text == "" || surname.text == "" || title.text == ""|| picUrl == ""){ 
                       
                       
                       Fluttertoast.showToast(
                    msg: "Entry not complete", 
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );                            
                } else{
                   
                     saveLeaderData();
                }
                  
                   }, child: const Text("Submit"))

             
      ],),)
      
       
    );
  }
}