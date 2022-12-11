// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:voteinorout/listOfLeaders.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:voteinorout/send_opt.dart';
import 'package:voteinorout/verify_otp.dart';
import 'dart:ui' as ui;
// import 'otp.dart';
// import 'phone.dart';


void main() async {
  
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( IntroScreen());

  RenderErrorBox.backgroundColor = Colors.transparent;
    RenderErrorBox.textStyle = ui.TextStyle(color: Colors.transparent);
}

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: 'phone',
        //  routes: {"phone": (context) => SendOTPScreen(), 'otp' : (context) => VerifyOPTScreen()},




      title: 'App name',
      home: Builder(builder: (BuildContext context) {
       // debugShowcheckedmodebanner: false;
        return( Scaffold(
          backgroundColor: Colors.black,
          
          appBar: AppBar(
            backgroundColor: Colors.black.withOpacity(0.6),
           title:
Center(
  child:   Text("RATE POLITICIANS, MINISTERS, MAYORS, COUNCILLORS ETC", 
  
      style: TextStyle(color: Colors.grey, fontSize: 10),
  
      textAlign:  TextAlign.center,
  
      ),
), 
          ), 
          
          body: 
        
          SingleChildScrollView(
                      child: Column(
            children: [
              //Text("Rate My Leader Opinion Polling", style: TextStyle(color: Colors.white, fontSize: 14),),
Container( height: 7, 
        width: MediaQuery.of(context).size.width,

         decoration: BoxDecoration(
             gradient: LinearGradient(
              colors: [
                // Colors.red.withOpacity(.9),
                // Colors.black.withOpacity(.9),
                // Colors.blue.withOpacity(.9),
                // Colors.black.withOpacity(.9), 
                // Colors.green.withOpacity(.9),
                // Colors.black.withOpacity(.9),             
                // Colors.orange.withOpacity(.9),
                // Colors.black.withOpacity(.9),
                // Colors.red.withOpacity(.9),
                // Colors.black.withOpacity(.9),
                // Colors.blue.withOpacity(.9),
                // Colors.black.withOpacity(.9), 
                // Colors.green.withOpacity(.9),
                // Colors.black.withOpacity(.9),             
                // Colors.orange.withOpacity(.9),
                // Colors.black.withOpacity(.9),
                // Colors.red.withOpacity(.9),
                // Colors.black.withOpacity(.9),
                // Colors.blue.withOpacity(.9),
                // Colors.black.withOpacity(.9), 
                // Colors.green.withOpacity(.9),
                // Colors.black.withOpacity(.9),             
                // Colors.orange.withOpacity(.9),
                // Colors.black.withOpacity(.9),
                // Colors.red.withOpacity(.9),
                // Colors.black.withOpacity(.9),
                // Colors.blue.withOpacity(.9),
                // Colors.black.withOpacity(.9), 
                // Colors.green.withOpacity(.9),
                // Colors.black.withOpacity(.9),             
                // Colors.orange.withOpacity(.9),
                // Colors.black.withOpacity(.9),
                // Colors.red.withOpacity(.9),
                // Colors.black.withOpacity(.9),
                // Colors.blue.withOpacity(.9),
                Colors.black.withOpacity(.9), 
                Colors.green.withOpacity(.9),
                Colors.black.withOpacity(.9),
                Colors.blue.withOpacity(.9),
                Colors.black.withOpacity(.9),             
                Colors.orange.withOpacity(.9),
                Colors.black.withOpacity(.9),
                       ],
              begin: Alignment.bottomLeft,
                end: Alignment.bottomRight,
            ),
   )
   ),
   

                 Container(height: MediaQuery.of(context).size.height/20,),
 Center(child: const Text("RML POLLING",style: TextStyle(
              fontStyle: FontStyle.normal,
              fontSize: 17, color: Colors.white),)),
    
              Container(height: MediaQuery.of(context).size.height/20,),
                               Container(height: MediaQuery.of(context).size.height/30,),
                               

  //  Text("RATE POLITICIANS, MINISTERS, MAYORS, COUNCILLORS ETC", 
  //   style: TextStyle(color: Colors.grey, fontSize: 10),
  //   textAlign:  TextAlign.center,
  //   ),
              Image(
                // height: MediaQuery.of(context).size.height/4,
                // width:  MediaQuery.of(context).size.width,
                 image: AssetImage('Images/RMLlogo1A.png'),),
            
         //  Center(child: const Text("RML Polling",style: TextStyle(fontSize: 17, color: Colors.white),)),
                Container(height: MediaQuery.of(context).size.height/30,),

    //           Text("RATE POLITICIANS, MINISTERS, MAYORS, COUNCILLORS ETC", 
    // style: TextStyle(color: Colors.grey, fontSize: 10),
    // textAlign:  TextAlign.center,
    // ),


              Container(height: MediaQuery.of(context).size.height/20,),
           

                 Container(height: MediaQuery.of(context).size.height/30,),

            

              // Text("The score will keep the reps under scrutiny\n and also gives the general public an \n opportunity to express their view of the \n\ said Rep in almost real time"),
              // Container(height: MediaQuery.of(context).size.height/20,),
              SizedBox( width: 190,
                child: ElevatedButton(
                  onPressed: () {
                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => listOfLeaders()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[400],
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    textStyle: TextStyle( fontSize: 15,
                    fontWeight: FontWeight.bold)),
                  child: Text("ENTER APP", style: TextStyle(color: Colors.black),),
                ),
              ),

//               ElevatedButton(
//                 onPressed: () {
//                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => listOfLeaders()));
//                 },
//                   style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.purple.shade700,
//                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
//                   textStyle: TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.bold)),
//                 child: Text("    LOG IN    ", style: TextStyle(color: Colors.black),),
// ),
     Container( height: 7, 
        width: MediaQuery.of(context).size.width,

  //        decoration: BoxDecoration(
  //          gradient: LinearGradient(
  //           colors: [
  //             // Colors.orange.withOpacity(.2),
  //             // Colors.orange.withOpacity(.4),
  //             // Colors.orange.withOpacity(.5),
  //             // Colors.orange.withOpacity(.6),
  //             // Colors.orange.withOpacity(1),
  //             // Colors.orange.withOpacity(1),
  //             // Colors.orange.withOpacity(1),
  //               Colors.orange.withOpacity(.6),
  //               Colors.orange.withOpacity(.5),
  //             // Colors.orange.withOpacity(.4),
  //             // Colors.orange.withOpacity(.3),
  //             // Colors.orange.withOpacity(.2),

              
  //                    ],
  //           begin: Alignment.bottomLeft,
  //             end: Alignment.bottomRight,
  //         ),
  //  )
   ),         

             ],


        ),
          )
        )); 
      } )
    ); 
    }
}




