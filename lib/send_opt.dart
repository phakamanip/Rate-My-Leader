import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:voteinorout/verify_otp.dart';

class SendOTPScreen extends StatefulWidget {
  SendOTPScreen({Key ? key}) : super(key: key);

  @override
  _SendOTPScreenState createState() => _SendOTPScreenState();
}

class _SendOTPScreenState extends State<SendOTPScreen> {
 

 
    TextEditingController mobileNumber = TextEditingController();
    TextEditingController countrycode = TextEditingController();
    String otpPin =" ";
    String countryDial = "+27";
    String verID = " ";

    showSnackBarText(String text){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(text),
        )
      );
    }
    

//=============================================
callOTPMethod( String number)async{

FirebaseAuth auth = FirebaseAuth.instance;

 await FirebaseAuth.instance.verifyPhoneNumber(
  phoneNumber: number,
  timeout: const Duration(seconds: 60),
  verificationCompleted: (PhoneAuthCredential credential) async {    
    showSnackBarText("Auth Completed ✅");
    await auth.signInWithCredential(credential);
},

  verificationFailed: (FirebaseAuthException e) {

    showSnackBarText("Auth failed");
     if (e.code == 'invalid-phone-number') {
      print('The provided phone number is not valid.');
    }},

  codeSent: (String verificationId, int? resendToken) async {

    showSnackBarText("Code Sent 📨");
    String smsCode = 'xxxx';
    verID = verificationId;


    Navigator.push(context, MaterialPageRoute(builder: (context) =>  VerifyOPTScreen()));

    
  },



  codeAutoRetrievalTimeout: (String verificationId) {

     phoneNumber: mobileNumber.text.toString();
  timeout: const Duration(seconds: 60);
  codeAutoRetrievalTimeout: (String verificationId) {
showSnackBarText("Auth failed(TIMEOUT)");  };
  },
);
}



     void submit() async{
    if( mobileNumber.text== "") return;

    var appSignatureID = await SmsAutoFill().getAppSignature;
    Map sendOtpData ={
      "mobile_number" : mobileNumber.text,
      "app_signature_id" : appSignatureID
    };

    print(sendOtpData);
    Navigator.push(context, MaterialPageRoute(builder: (context) =>  VerifyOPTScreen()));


  }


  Future<void> verifyOTP() async{
    await FirebaseAuth.instance.signInWithCredential(
      PhoneAuthProvider.credential(
        verificationId: verID,
        smsCode: otpPin
      )
    ).whenComplete(() {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  VerifyOPTScreen()));

    });
  }





  @override
  void initState() {
    super.initState();
    countrycode.text = "+27";
    }
 
 
 
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.amber,   
      
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFFC2C0C0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                   child: TextField(
                     controller: mobileNumber,
                     keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText : "Enter Cellphone Number"

                      ),
                   ),
                )
              ),
              const SizedBox(height: 10,),
              ElevatedButton(onPressed:(){ 
                  if(mobileNumber.text.isEmpty){showSnackBarText("Entry is empty");}
              
                else{
                 callOTPMethod(countryDial + mobileNumber.text);
              }
               if(otpPin.length >= 6){
                          verifyOTP();}
                          else{showSnackBarText("Enter OTP Correctly");}
                        /*******/
                submit();
                        /*******/
    
                
                }, child: Text("Submit")),

                Container(
                  
                  child: PinFieldAutoFill(
codeLength:4 ,
onCodeChanged: (val){
  print(val);
},

                ),),
             
             
              ElevatedButton(onPressed:(){
                if(mobileNumber.text.isEmpty){showSnackBarText("Entry is empty");}
              
                else{
                              /*******/

                 callOTPMethod(countryDial + mobileNumber.text);
                             /*******/

              } 
                if(otpPin.length >= 6){
                          verifyOTP();}
                          else{showSnackBarText("Enter OTP Correctly");}


                 }, child: Text("callOTPMethod")),

                 ElevatedButton(onPressed: ()async{
                   

 final signCode = await SmsAutoFill().getAppSignature; 
 print("----sign code-----> $signCode"); 
      Navigator.push(context, MaterialPageRoute(builder: (context) =>  VerifyOPTScreen()));
           
             
                 }, child: Text("Call signCode"))
            ],
          ),
        ),
      )
       );
  }
}