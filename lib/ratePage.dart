// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:voteinorout/send_opt.dart';
import 'listOfLeaders.dart';
import 'package:firebase_auth/firebase_auth.dart';




class RatingPage extends StatefulWidget {

  String value ;
  String value2 ="";

  RatingPage({required this.value, value2});
 

    static String verify = "";


  @override
  State<RatingPage> createState() => _RatingPageState(value, value2);
}

class _RatingPageState extends State<RatingPage> {
   _RatingPageState(this.value, value2);

   String value = "";
   String value2 ="";
   String pictureFromFS ="";
   String savePercentageString ="";
   String commentsStringToFS ="";
   String numberOfVotesString = "";
   List<String> TESTERLIST = [ ]; 
   List NewList = [];

   bool testster = true;

   var listOfCommentsFromFS = "";

   List<String> myListOfFSComments =[];
   List<String> cleanedCommentString =[];
   bool upVoted = false;
   bool downVoted = false;

    var calculationString = "";
    int numberOfVotesInt = 0;
    int totalPercentage = 0;
    int c = 100 ;
    int d = 0;
    int entrants = 2;
    int savePercent = 0;
    int finalTotal =0;
    int trounded =0;
    int updatedSave = 0;

    double finalPercentVote = 0; 
   var  widthDouble;

    TextEditingController commentTextEdit = TextEditingController();
    TextEditingController countryCode = TextEditingController();
    var phone ="";
    var code ="";
    final now =  DateTime.now();

    final FirebaseAuth auth = FirebaseAuth.instance;
  

      calculatingPercentageMethod(){
          setState(() {       
          int A = 100*savePercent;
          int E = entrants *100;   
          double T = A / E ;
          trounded = T.round();
          finalTotal = 100 - trounded;
         
          });

      }


      submitRatingMethod(){  
           double calculatedfinalPercent =    savePercent/numberOfVotesInt * 100;

      Future.delayed(const Duration(milliseconds: 500), (){
           print("-111111111111111111---------------------$calculatedfinalPercent.floor().toString()----------------------");
     
      FirebaseFirestore.instance.collection("Leader")       
      .doc(value).update({ 
         "VoterVoted" :savePercentageString,
         "VotesMade" : numberOfVotesInt.toString(),
         "Calculated%" :calculatedfinalPercent.floor().toString()
      });

        setState(() {
          
               print("-222222222222222---------------------$finalPercentVote.floor().toString()----------------------");

      //  Future.delayed(const Duration(milliseconds: 500),(){
      //     FirebaseFirestore.instance.collection("Leader")
      // .doc(value).update({ 
      
      //    "Calculated%" :calculatedfinalPercent.floor().toString()
      // });
      //   });
  });


      final commentControl = commentTextEdit.text;

      if(commentControl != "" || commentControl.isNotEmpty){
      FirebaseFirestore.instance.collection("Leader").doc(value).collection("comments")
      .doc(now.toString()).set({
      "comment" : "☝️  "  +commentControl.trim() + "\n",
      "date" : now.toString()
      });
      }

    
      });
      }                   



  void _incrementCounter() {
    debugPrint("$upVoted <<<<<<<<<< upVoted RESULT");
 if(upVoted == true){  debugPrint(">>>>>>>>>>>>>>>>>> YOU CANT VOTE TWICE <<<<<<<<<<<<<"); } 
if(upVoted == false){
     setState(() { 
        calculatingPercentageMethod();
        savePercent ++;
        finalPercentVote ++;
        debugPrint(">>>>>>>>>>>>>>> THANKS FOR VOTING >>>>>>>>>>>>>>>>>>>>");
        upVoted = true;

        setState(() {
        savePercentageString = savePercent.toString();
        });
        debugPrint("$savePercent");
        debugPrint(savePercentageString);
        
        });}}

  void _decrementCounter() {
      debugPrint("$downVoted <<<<<<<<<< downVoted RESULT");
 if(downVoted == true){  debugPrint(">>>>>>>>>>>>>>>>>> YOU CANT VOTE TWICE <<<<<<<<<<<<<"); } 
if(downVoted == false){
   setState(() {
  calculatingPercentageMethod();
  savePercent --;
  finalPercentVote --;
   debugPrint(">>>>>>>>>>>>>>> THANKS FOR VOTING >>>>>>>>>>>>>>>>>>>>");
        downVoted = true;
  savePercentageString = savePercent.toString();
      print(savePercent + -1);

    });
  }
  }






  @override
  void initState() {
    super.initState();

//==============================================================================

countryCode.text = "+27";

//==============================================================================

     debugPrint(" This is value: $value"); 
         
            Future.delayed(const Duration(milliseconds: 1700),(){ 

            FirebaseFirestore.instance
            .collection('Leader')
            .doc(value)
            .get()
            .then((value) {  
              debugPrint("=================1=============");
              pictureFromFS         = value.get('image'); 
              savePercentageString  = value.get('VoterVoted');
              numberOfVotesString   = value.get('VotesMade');
              setState(() {
              numberOfVotesInt = int.parse(numberOfVotesString);  
              savePercent      = int.parse(savePercentageString);
              debugPrint("$savePercent" );
              debugPrint("<____2222_______ $numberOfVotesString ____________>   ");
              debugPrint("<____3333_______ $numberOfVotesInt ____________>   ");

             

   finalPercentVote = savePercent/numberOfVotesInt.toInt() * 100;
 if (finalPercentVote.isNaN || finalPercentVote.isInfinite){
  setState(() {
    finalPercentVote =100;
    numberOfVotesString = "1";
    numberOfVotesInt = 1;
    savePercent = 1;
  });
}else{};
        
            //  debugPrint("<____4444_______ $finalPercentVote% ____________>   ");
                      widthDouble =   100 - finalPercentVote;
           //   debugPrint("<____5555_______ $widthDouble% ____________>   ");

              });
          });
  });
            Future.delayed(const Duration(milliseconds: 700),(){ 
              setState(() {
                savePercent - 100;
                updatedSave = 100 - savePercent;
                
              });
            });

 Future.delayed( const Duration(milliseconds: 500),(){
  debugPrint("=================2=============");
   FirebaseFirestore.instance.collection('Leader').doc(value).get().then((value) {
      setState(() {
        try{
     pictureFromFS = value.get('image'); 
     savePercentageString  = value.get('VoterVoted');
     savePercent = int.parse(savePercentageString);
   }catch(e){debugPrint("Error *********************8==========");}
 });
 });

   
  FirebaseFirestore.instance.collection("Leader").doc(value).collection("comments").where("comment", isNotEqualTo: null).get().then(
      (res) { 
          res.docs.forEach((element) {
            setState(() {
             listOfCommentsFromFS = element.get('comment');
             const Divider(thickness: 2, color: Colors.grey,);
                   


         myListOfFSComments.removeWhere((e) => e == " "  );

           var newData = myListOfFSComments.expand((x) => [x]).toList();
           myListOfFSComments.add( listOfCommentsFromFS.toString().trimLeft()+ " \n");
           myListOfFSComments.removeWhere((item) => item == ",");
           bool result = myListOfFSComments.remove("  ");
           myListOfFSComments.removeWhere((item) => ["", null, false, 0].contains(item));
           myListOfFSComments.removeWhere( (item) => item.isEmpty );

           myListOfFSComments.removeWhere( (item) => item.isEmpty );




  print("_------>>>>> 222" + "$NewList" + " 222 <<<<<<------");
  print("_------>>>>> 3333" + "$myListOfFSComments");


            const Divider(thickness: 2, color: Colors.grey,);
                 setState(() {
                 cleanedCommentString =  myListOfFSComments;
                 });
      
            print(">>>>>> 123 " + "$result \n $myListOfFSComments" );



        });
    });

       // print("Successfully completed--------------- $myListOfFSComments ");
        
   }, 

      onError:(e) => debugPrint("Error completing: $e"),

      );
    });
  }







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Rating Page")),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child:const Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          ),
        ),
      ),
      body: SingleChildScrollView(
              child: Center(
        
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

             
               Container( 
                     decoration: BoxDecoration(
                       //color: Colors.black,
                       borderRadius: BorderRadius.circular(20),),


                  
                 // color: Colors.red,
                  child: Center(child: Text(value, style:const TextStyle(fontSize : 22, color: Colors.black),))),


              Stack(children:[
                pictureFromFS =="" ? const CircularProgressIndicator() :  
                
                Container(
                  decoration: BoxDecoration(
                       color: Colors.black,
                       borderRadius: BorderRadius.circular(15),),


              //    color: Colors.black,
                width: MediaQuery.of(context).size.width/1.1,
                height: 250,
                child: Image.network(pictureFromFS)),
               
              ]),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
                  child: Row(children:[ 
           
           const SizedBox(width: 20),     
            
             
     ]),
),
  
const SizedBox(height: 4),



 Container(
   width: MediaQuery.of(context).size.width/1.5,
   height: 30,
           
            decoration: BoxDecoration(  
              color: Colors.black,
              backgroundBlendMode: BlendMode.lighten,        
                border: Border.all(          
                 width: 4,
         	),),

   child: Stack( alignment : AlignmentDirectional.center,
     children: [                    
     SingleChildScrollView(
       scrollDirection: Axis.horizontal,
            child: Row( mainAxisAlignment : MainAxisAlignment.center,
       children:[ 
         finalPercentVote < 0 ? Text("Below Zero % "):
    Container(color: Colors.greenAccent.shade200, height: 22, width: finalPercentVote.toDouble()*2.3,), 
          

    widthDouble !=null ? 
    Container(color: Colors.redAccent.shade400,   height: 22, width: widthDouble*2.3,) : const CircularProgressIndicator()
         ]),
     ),

  Text( "${finalPercentVote.floor()}%",  style: const TextStyle( backgroundColor: Colors.white, fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black) ),
     

     ],
   ),
 ),




            
   Container(
        width: MediaQuery.of(context).size.width/1.2,
        height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.9),
                      Colors.black.withOpacity(0.4),
                      Colors.black.withOpacity(0.4),
                      Colors.black.withOpacity(0.9),
                            ],
                    begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                        ),
        borderRadius: BorderRadius.circular(15),),


            child:  Row( mainAxisAlignment: MainAxisAlignment.center,
              children:[


                  CircleAvatar(
                    backgroundColor: Colors.purple,
          radius: 24,
           child: IconButton(
            padding: EdgeInsets.zero, color: Colors.purple,
            icon: const Icon(size: 40, color: Colors.black, Icons.refresh_outlined),                  
            onPressed: (){

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => RatingPage(value: value,) ), 
          (Route<dynamic> route) => false,
        );
            
                },),
                  ),
                    const  SizedBox(width:20),



                  Row(children:[
                  CircleAvatar(
                     backgroundColor: Colors.green,
                     radius: 24,
                    child: IconButton(
                        padding: EdgeInsets.zero,
                      onPressed: _incrementCounter,
                    tooltip: 'Increment',
                    icon: const Icon(size: 30, color: Colors.black,Icons.thumb_up),
                ),
                  ),
                        ]),

                        
                    const  SizedBox(width:20),
                

            Row(children:[
                CircleAvatar(
                     backgroundColor: Colors.blue,
                                          radius: 24,

                    child: IconButton(
                    padding: EdgeInsets.zero,
                    color: Colors.green,
                    onPressed: _decrementCounter,
                    tooltip: 'decrement',
                    icon: const Icon(size: 30, color: Colors.black, Icons.thumb_down),
                  ),
                ),]),

                    const  SizedBox(width:20),



              CircleAvatar( backgroundColor: Colors.orange,
                                      child: IconButton(
                                    padding: EdgeInsets.zero,
                                      color: Colors.orange,
                                      icon: const Icon(size: 30, color: Colors.black, Icons.message),

  onPressed: (){
         Navigator.of(context).push(MaterialPageRoute(builder: (context) => Comments(value: myListOfFSComments.toString())));
          //    Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(builder: (context) => RatingPage(value: value,) ), 
          //    (Route<dynamic> route) => false,
          // );
          //    setState(() {
          // savePercent;
          //    });
          //    upVoted = false;
          //    downVoted = false;      
                  },),
        ),
              
                
                
        ]),
        
    ),
            
 

      const  SizedBox(height:40),


        Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(.2),
              Colors.black.withOpacity(0.2),],
            begin: Alignment.topLeft,
              end: Alignment.bottomRight,
          ),

           borderRadius: BorderRadius.circular(15),),

           width: MediaQuery.of(context).size.width/1.3, 
           height: MediaQuery.of(context).size.height/6,
          child: TextFormField(
            controller: commentTextEdit,
            maxLines: 4,
          decoration:const InputDecoration(
          labelText: "  Add comment(optional)",
          helperMaxLines: 150
                     )
        ),),

                      const   SizedBox(height:10),

//====================================
testster == true? 
ElevatedButton(onPressed: () async{

 final signCode = await SmsAutoFill().getAppSignature; 
 print("----sign code-----> $signCode"); 
 Navigator.of(context).push(MaterialPageRoute(builder: (context) => SendOTPScreen()));},
  child: const Text("OTP TESTER")) :

//=====================================
         ElevatedButton(
                 child:const Text("SUBMIT"),
                 onPressed: (){
numberOfVotesInt ++;
  debugPrint("mmmmmm $numberOfVotesInt mmmmmmmm");
  setState(() {
    
 
  numberOfVotesInt == numberOfVotesString.toString();
  //numberOfVotesString == numberOfVotesInt.toString();
  debugPrint("mmmmmm $numberOfVotesInt mmmmmmmm");

   });
 // debugPrint(savePercentageString);
  

 submitRatingMethod();

 Navigator.of(context).push(MaterialPageRoute(builder: (context) => const listOfLeaders()));

  


               }), 
//===========================================================================

// Form(
//   child:   Directionality(
  
//     textDirection: TextDirection.ltr,
  
//     child:   Pinput(
  
    
  
//       length: 6,
  
    
  
//       showCursor: true,
  
    
  
//       onChanged:(value){
  
//         code=value;
  
//       }
  
    
  
//     ),
  
//   ),
// ),


ElevatedButton(onPressed: () async{
  // await FirebaseAuth.instance.signInWithPhoneNumber("+27637911197");
 PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: RatingPage.verify, smsCode: code);
 await auth.signInWithCredential(credential);

 },
  child: const Text("Register Phone")),




ElevatedButton(onPressed: () async{
  // await FirebaseAuth.instance.signInWithPhoneNumber("+27637911197");

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '${countryCode.text + phone}',
      verificationCompleted: (PhoneAuthCredential credential){},
      verificationFailed: (FirebaseAuthException e){},
      codeSent: (String verificationId, int? resendToken){
        RatingPage.verify=verificationId;
        Navigator.pushNamed(context, "otp");
      },
      codeAutoRetrievalTimeout: (String verificationId){});


 },
  child: const Text("Send Verification code")),

SizedBox(height: 20),



  Container(
    width: MediaQuery.of(context).size.width/1.5,
    color: Colors.redAccent,
    child: TextField(
    keyboardType: TextInputType.phone,
    onChanged: (value){
      phone = value;
    },
    decoration: InputDecoration(
      border: InputBorder.none, hintText: "Phone"
    ),
  )),





//===========================================================================
               
  const Text('You can only vote for a candidate once every month',),                   
           
           
           
           
            ],
          ),
        ),
      ),
     
      
    );
  }
}


class Comments extends StatelessWidget{

 String value ;

  Comments({required this.value});

  

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Comments and opinions")),
    body: SingleChildScrollView(
          child: Center(
        child: GestureDetector(
          onTap: () {
                        Navigator.pop(context);

          },
        child: Container( 
            
          color: Colors.black.withOpacity(.9),

           child: Column(children: [

             const SizedBox(height: 80),

             
             // Divider(thickness: 2, color: Colors.grey,),
             
              
             Center(child: Text("$value", style: const 
              TextStyle(color:Colors.white, fontWeight: FontWeight.bold), )),
            
            const SizedBox(height: 20),

      
             ],)
            ),
        ),
      ),
    )

    );
}