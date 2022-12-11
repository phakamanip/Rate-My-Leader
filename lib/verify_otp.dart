import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

class VerifyOPTScreen extends StatefulWidget {
  VerifyOPTScreen({Key? key}) : super(key: key);

  @override
  _VerifyOPTScreenState createState() => _VerifyOPTScreenState();
}

class _VerifyOPTScreenState extends State<VerifyOPTScreen> with CodeAutoFill {

String codeValue ="";

 TextEditingController mobileNumber = TextEditingController();
   // String phoneNumber = '+27$mobileNumber';
  
     

     
     callOTPMethod()async{

FirebaseAuth auth = FirebaseAuth.instance;
 
       await FirebaseAuth.instance.verifyPhoneNumber(
  phoneNumber: "+27637911197",
    timeout: const Duration(seconds: 60),

  verificationCompleted: (PhoneAuthCredential credential) async {    
    await auth.signInWithCredential(credential);
},

  verificationFailed: (FirebaseAuthException e) {
     if (e.code == 'invalid-phone-number') {
      print('The provided phone number is not valid.');
    }},

  codeSent: (String verificationId, int? resendToken) async {
    String smsCode = 'xxxx';

    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

    // Sign the user in (or link) with the credential
    await auth.signInWithCredential(credential);
  },



  codeAutoRetrievalTimeout: (String verificationId) {
     phoneNumber: mobileNumber.text.toString();
  timeout: const Duration(seconds: 60);
  codeAutoRetrievalTimeout: (String verificationId) {
    // Auto-resolution timed out...
  };
  },
);



AuthCredential credential = PhoneAuthProvider.credential(
  verificationId: "C+iY2tz6udV",
  smsCode: "",
);

//User user =  FirebaseAuth.instance.signInWithCredential(credential);



     }



@override
void codeUpdated(){
 // print("Update code $code");
  setState(() {
    debugPrint("codeupdated");
  });
}


@override
void initState() {
 _listenOTP();
     super.initState();
    listenOtp();
  }


@override
void listenOtp() async{
await SmsAutoFill().unregisterListener();
listenForCode();

 await SmsAutoFill().listenForCode();
 debugPrint("OTP listen Called");
}

@override
 void dispose(){
   SmsAutoFill().unregisterListener();
   debugPrint("unregisterd user");
   super.dispose();;

 }

 void _listenOTP() async{
   await SmsAutoFill().listenForCode();
 }

  //===========================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
      
       child: Column(children:[
          Center(
            child: PinFieldAutoFill(
              currentCode: codeValue,
              codeLength: 4,
              onCodeChanged:(code){
                debugPrint("------->onCodeChanged $code");
                setState((){

                  codeValue = code.toString();
                });
              },
              onCodeSubmitted: (val){
                debugPrint("onCodeSubmited $val");
              }
            )

          ),

          const SizedBox(height:20),

           ElevatedButton(
            onPressed: (){

              callOTPMethod();
              print(codeValue);}, 
              child: Text("Verify OTP")
              ),


          ElevatedButton(
            onPressed: (){
              listenOtp();}, 
              child: Text("Resend")
              )



       ]),

      )
    );
  }
}