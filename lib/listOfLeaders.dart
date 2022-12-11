// ignore_for_file: unrelated_type_equality_checks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:voteinorout/addALeader.dart';
import 'package:voteinorout/ratePage.dart';

import 'main.dart';

// ignore: camel_case_types
class listOfLeaders extends StatefulWidget {
  const listOfLeaders({super.key});

  @override
  ListOfLeadersState createState() => ListOfLeadersState();
}

class ListOfLeadersState extends State<listOfLeaders> {
  String nameFirestore = "";
  String surnameFirestore = "";
  String titleFirestore = "";
  String imageFirestore = "";
  String calculatedPercentString = "";
  String nameSearched = "";
  List namesToSearchList = [];
  bool _isDescending = true;

  Stream<QuerySnapshot> chatStream = 
  FirebaseFirestore.instance.collection('Leader').orderBy("Calculated%", descending: true ).snapshots();
  int VotesMade = 0;
  int VoterVotedInt = 0;
  int intToGiveGrade = 0;
  double percentDouble = 0;
  double VoterVotersCalculated = 0;
  String percentInString = "";

  Widget myCardWidget(String name, String surname, String title, String imageFirestore, String percentage) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        decoration: BoxDecoration(
          // gradient: LinearGradient(
          //   colors: [
          //     Colors.black.withOpacity(.9),
          //     Colors.black.withOpacity(.5),
          //     Colors.black.withOpacity(.5),
          //     Colors.black.withOpacity(.9),
          //   ],
          //   begin: Alignment.bottomLeft,
          //   end: Alignment.bottomRight,
          // ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: SingleChildScrollView(
                  child: Card(
          //  color: Colors.purpleAccent,
            shadowColor: Colors.blueAccent,
          //  borderOnForeground: true,
            elevation: 10,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(20),
            //   side: BorderSide(
            //   //  color: Colors.grey.shade100,
            //     // width: 2.0,
            //   ),
            // ),
            child: Column(children: [
              const SizedBox(height: 4),
              Row(children: [
                const SizedBox(width: 18),
                Container(
                  // decoration: BoxDecoration(
                  //    gradient: LinearGradient(
                  //     colors: [
                  //       // Colors.black.withOpacity(.9),
                  //       Colors.black.withOpacity(.9),
                  //        Colors.black.withOpacity(.9),
                  //       // Colors.black.withOpacity(.9),
                  //     ],
                  //     begin: Alignment.bottomLeft,
                  //     end: Alignment.bottomRight,
                  //   ),
                  //   borderRadius: BorderRadius.circular(10),
                  // ),
                  child: Container(
                    //      color: Colors.blueGrey,
                         height: MediaQuery.of(context).size.height / 5.4,
                          width: MediaQuery.of(context).size.width /2.5,
                    //  decoration:
                    decoration: BoxDecoration(  
              color: Colors.blueGrey,
            //  backgroundBlendMode: BlendMode.overlay,        
                border: Border.all(  
                  style: BorderStyle.solid,
                color: Colors.black,
       
                 width: 6,
         	),),
                               child: ClipRRect(
                        borderRadius: BorderRadius.circular(1.0),
                               child: Image.network( imageFirestore,
                              height: MediaQuery.of(context).size.height / 5.5,
                               width: MediaQuery.of(context).size.width /2.5,
                                 fit: BoxFit.cover
                              ),
                             ),
                            ),
                          ),
                const SizedBox(width: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.2,
                  child: Column(children: [
                    Text("$name $surname", style: const TextStyle( color: Colors.blue,
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    // Text(
                    //   surname,
                    //   style: const TextStyle(
                    //       fontSize: 16, fontWeight: FontWeight.w600),
                    // ),

                    Text(title, style: const TextStyle(fontSize: 15, color: Colors.blueGrey)),
                    const SizedBox(width: 14),

                    Container(
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                          ),
                        ),
                        child: Text(" $percentage % ", style: const TextStyle(fontSize: 20))),

                            SizedBox(height: 10),  //  A = 100 STAR
                                                   //  A = 90  GREEN
                                                   //  A = 80
                                                   //  B = 70  BLUE
                                                   //  B = 60
                                                   //  C = 50  ORANGE
                                                   //  D = 40  RED
                                                   //  E = 30  RED
                                                   //  F = 20  FAIL
                                                   //  F = 10  FAIL
                                                   //  F =  +  FAIL

                                 //========================================                          

     percentage[0]  =="9" ? Container(
                 height: 30,
                 width: 30,
                 decoration:
                  BoxDecoration(
                     color: Colors.green, 
                     borderRadius: BorderRadius.circular(5),),
                child: const Text(" A ", style: TextStyle( fontSize: 25))) : Container(),

   //========================================                          

     percentage[0]  =="8" ? Container(
                 height: 30,
                 width: 30,
                 decoration:
                  BoxDecoration(
                     color: Colors.green, 
                     borderRadius: BorderRadius.circular(5),),
                child: const Text(" A ", style: TextStyle( fontSize: 25))) : Container(),

   //========================================  

     percentage[0]  =="7" ? Container(
                 height: 30,
                 width: 30,
                 decoration:
                  BoxDecoration(
                     color: Colors.blue, 
                     borderRadius: BorderRadius.circular(5),),
                child: const Text(" B ", style: TextStyle( fontSize: 25))) : Container(),

   //========================================  

     percentage[0]  =="6" ? Container(
                 height: 30,
                 width: 30,
                 decoration:
                  BoxDecoration(
                     color: Colors.blue, 
                     borderRadius: BorderRadius.circular(5),),
                child: const Text(" B ", style: TextStyle( fontSize: 25))) : Container(),

   //========================================  

     percentage[0]  =="5" ? Container(
                 height: 30,
                 width: 30,
                 decoration:
                  BoxDecoration(
                     color: Colors.orange, 
                     borderRadius: BorderRadius.circular(5),),
                child: const Text(" C ", style: TextStyle( fontSize: 25))) : Container(),

   //========================================  

     percentage[0]  =="4" ? Container(
                height: 30,
                 width: 30,
                 decoration:
                  BoxDecoration(
                     color: Colors.red, 
                     borderRadius: BorderRadius.circular(5),),
                child: const Text(" D ", style: TextStyle( fontSize: 25))) : Container(),

   //========================================  

     percentage[0]  =="3" ? Container(
                height: 30,
                 width: 30,
                 decoration:
                  BoxDecoration(
                     color: Colors.red, 
                     borderRadius: BorderRadius.circular(5),),
                child: const Text(" E ", style: TextStyle( fontSize: 25))) : Container(),

   //========================================  

     percentage[0]  =="2" ? Container(
                 height: 30,
                 width: 30,
                 decoration:
                  BoxDecoration(
                     color: Colors.black, 
                     borderRadius: BorderRadius.circular(5),),
                child: const Text(" FAIL", style: TextStyle( fontSize: 10, color: Colors.white))) : Container(),

   //========================================  

     percentage  =="100" ? Container(
                 height: 40,
                 width: 40,
                 decoration:
                  BoxDecoration(
                  //   color: Colors.blue, 
                     borderRadius: BorderRadius.circular(5),),
                child: const Text(" ⭐ ", style: TextStyle( fontSize: 20, color: Colors.black))) : Container(),

   //========================================  

     percentage[0]  =="0" ? Container(
                 height: 40,
                 width: 40,
                 decoration:
                  BoxDecoration(
                     color: Colors.grey, 
                     borderRadius: BorderRadius.circular(5),),
                child: const Text("No Grade", style: TextStyle( fontSize: 12))) : Container(),

   //========================================  

                    //  SizedBox(width: 20),
                  ]),
                ),
                const SizedBox(
                  height: 30,
                ),
              ]),
              const SizedBox(height: 4),
            ]),
          ),
        ),
      ),
    );
  }


  @override
  void initState() {

   CircularProgressIndicator(); 
    print("___________ENTER________________");
   nameSearched = "";
// nameFirestore.isEmpty? CircularProgressIndicator(): Container();
    //  print(MediaQuery.of(context).size.height);
    super.initState();
    setState(() {
      imageFirestore;
    });

    debugPrint("()()$percentDouble()()()");
    debugPrint("()()$percentInString()()()");

    Future.delayed(const Duration(milliseconds: 700), () {
      chatStream;
      setState(() {
        percentInString == percentDouble.toDouble();
        debugPrint("()()()_______()()");
        //debugPrint(percentInString[0][0]);
        //   debugPrint(percentInString[1]);
        debugPrint(intToGiveGrade.toString());
                debugPrint("()()(a)___ $nameFirestore ____()()");

        print(MediaQuery.of(context).size.height);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
        resizeToAvoidBottomInset: true,
      
        appBar: AppBar(
          elevation: 20,
          backgroundColor: Colors.grey.shade300,
          title: Container(
            color: Colors.white,
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: TextField(
              onChanged: (val) {
                setState(() {
                  nameSearched = val;
                  print(">>>>>>>>>>>>>$nameSearched");
                });
              },
              //  controller: controller,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search 1st Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.red))),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const addALeader()));
              },
              //  backgroundColor: Colors.grey.shade300,
              icon: const Icon(Icons.add, color: Colors.black, size: 35),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            )
          ],
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const IntroScreen()));
              },
              icon: Icon(Icons.arrow_back, color: Colors.black, size: 40)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SingleChildScrollView(
                child: Column(children: [
                  StreamBuilder<QuerySnapshot>(
                      stream: chatStream,
                      builder: (context, snapshot) {
                        try {
                          return Column(children: [
                            Container(
                                height:
                                    MediaQuery.of(context).size.height / 1.16,
                                color: Colors.white,
                                child: ListView.builder(
                                    itemCount: snapshot.data?.docs.length,
                                    itemBuilder: (context, index) {
                                      if (nameSearched != "") {
                                    snapshot.data?.docs[index]
                                              .get("name") == "" ? const CircularProgressIndicator()    
                                       
                                       : myCardWidget(
                                       nameFirestore =   snapshot.data?.docs[index]
                                              .get("name"),
                                          snapshot.data?.docs[index]
                                              .get("surname"),
                                          snapshot.data?.docs[index]
                                              .get("title"),
                                          snapshot.data?.docs[index]
                                              .get("image"),
                                          snapshot.data?.docs[index]
                                              .get("Calculated%"),
                                        ) ;
                                      }
                                      
            nameFirestore.isEmpty ? CircularProgressIndicator() : Container();
        if ( snapshot.data?.docs[index].get("name").contains(nameSearched?.toUpperCase()) 
               || snapshot.data?.docs[index].get("name").contains(nameSearched?[0].toUpperCase()) 
                    ||             
                    // snapshot.data?.docs[index].get("surname").contains(nameSearched?.toLowerCase())           
                    //                     ||
                    // snapshot.data?.docs[index].get("surname").contains(nameSearched?[0].toLowerCase())
                    //                     ||
                               
                                              snapshot.data?.docs[index]
                                                  .get("surname")
                                                  .startsWith(nameSearched
                                                      ?.toUpperCase()) ||
                                              snapshot.data?.docs[index]
                                                  .get("surname")
                                                  .contains(nameSearched
                                                      ?.toLowerCase())
                                          // || snapshot.data?.docs[index].get("surname").contains(nameSearched.toUpperCase())
                                           || snapshot.data?.docs[index].get("name").contains(nameSearched?.toLowerCase())
                                          //  || snapshot.data?.docs[index].get("name").contains(nameSearched.toUpperCase())
                                          //    || snapshot.data?.docs[index].get("surname").comparesTo(nameSearched)

                                          ) {
                                        return SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          child: Row(
                                            children: [
                                              SingleChildScrollView(
                                                                                              child: InkWell(
                                                  child: myCardWidget(
                                                    snapshot.data?.docs[index]
                                                        .get("name"),
                                                    snapshot.data?.docs[index]
                                                        .get("surname"),
                                                    snapshot.data?.docs[index]
                                                        .get("title"),
                                                    snapshot.data?.docs[index]
                                                        .get("image"),
                                                    snapshot.data?.docs[index]
                                                        .get("Calculated%"),
                                                  ),
                                                  onTap: () {
                                                    calculatedPercentString =
                                                        snapshot.data?.docs[index]
                                                            .get("Calculated%");
                                                    intToGiveGrade = int.parse(
                                                        calculatedPercentString);

                                                        debugPrint(calculatedPercentString);

                                                    VoterVotedInt = int.parse(
                                                        snapshot.data?.docs[index]
                                                            .get("VoterVoted"));
                                                    VotesMade = int.parse(snapshot
                                                        .data?.docs[index]
                                                        .get("VotesMade"));
                                                    VoterVotersCalculated =
                                                        VoterVotedInt /
                                                            VotesMade *
                                                            100;

                                                    VoterVotersCalculated == "NaN"
                                                        ? Container()
                                                        : Container();

                                                    if (VoterVotersCalculated
                                                            .isNaN ||
                                                        VoterVotersCalculated
                                                            .isInfinite) {
                                                      setState(() {
                                                        VoterVotersCalculated =
                                                            0.1;
                                                      });
                                                    } else {
                                                      print(
                                                          "This is VoterVotedCalculated>>>>>> $VoterVotersCalculated");
                                                      print(
                                                          "$VoterVotedInt --------- $VotesMade");

                                                      print(" >>>>>>>>>" +
                                                          calculatedPercentString);
                                                    }
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => RatingPage(
                                                                value: snapshot
                                                                        .data
                                                                        ?.docs[
                                                                            index]
                                                                        .get(
                                                                            "name") +
                                                                    " " +
                                                                    snapshot
                                                                        .data
                                                                        ?.docs[
                                                                            index]
                                                                        .get(
                                                                            "surname"),
                                                                value2: snapshot
                                                                    .data
                                                                    ?.docs[index]
                                                                    .get(
                                                                        "name"))));
                                                  },
                                                ),
                                              ),


                                            ],
                                          ),
                                        );
                                      }
                                      return Container();

//            namesToSearchList.add(snapshot.data?.docs[index].get("name"));
                                      if (snapshot.data?.docs[index]
                                          .get("name")
                                          .startsWith(nameSearched)) {
                                        snapshot.data?.docs[index]
                                                    .get("image") ==
                                                ""
                                            ? Container()
                                            : Row(children: [
                                                InkWell(
                                                    onTap: () {
                                                      calculatedPercentString =
                                                          snapshot
                                                              .data?.docs[index]
                                                              .get(
                                                                  "Calculated%");
                                                      intToGiveGrade = int.parse(
                                                          calculatedPercentString);

                                                      VoterVotedInt = int.parse(
                                                          snapshot
                                                              .data?.docs[index]
                                                              .get(
                                                                  "VoterVoted"));
                                                      VotesMade = int.parse(
                                                          snapshot
                                                              .data?.docs[index]
                                                              .get(
                                                                  "VotesMade"));
                                                      VoterVotersCalculated =
                                                          VoterVotedInt /
                                                              VotesMade *
                                                              100;

                                                      VoterVotersCalculated ==
                                                              "NaN"
                                                          ? Container()
                                                          : Container();

                                                      if (VoterVotersCalculated
                                                              .isNaN ||
                                                          VoterVotersCalculated
                                                              .isInfinite) {
                                                        setState(() {
                                                          VoterVotersCalculated =
                                                              0.1;
                                                        });
                                                      } else {
                                                        print(
                                                            "This is VoterVotedCalculated>>>>>> $VoterVotersCalculated");
                                                        print(
                                                            "$VoterVotedInt --------- $VotesMade");

                                                        print(" >>>>>>>>>" +
                                                            calculatedPercentString);
                                                      }
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) => RatingPage(
                                                                  value: snapshot
                                                                          .data
                                                                          ?.docs[
                                                                              index]
                                                                          .get(
                                                                              "name") +
                                                                      " " +
                                                                      snapshot
                                                                          .data
                                                                          ?.docs[
                                                                              index]
                                                                          .get(
                                                                              "surname"),
                                                                  value2: snapshot
                                                                      .data
                                                                      ?.docs[
                                                                          index]
                                                                      .get(
                                                                          "name"))));
                                                    },
                                                    child: Container(
                                                        child: myCardWidget(
                                                      snapshot.data?.docs[index]
                                                          .get("name"),
                                                      snapshot.data?.docs[index]
                                                          .get("surname"),
                                                      snapshot.data?.docs[index]
                                                          .get("title"),
                                                      snapshot.data?.docs[index]
                                                          .get("image"),
                                                      snapshot.data?.docs[index]
                                                          .get("Calculated%"),
                                                    ))),

                                                //  A = 100 STAR
                                                //  A = 90  GREEN
                                                //  A = 80
                                                //  B = 70  BLUE
                                                //  B = 60
                                                //  C = 50  ORANGE
                                                //  D = 40  RED
                                                //  E = 30  RED
                                                //  F = 20  FAIL
                                                //  F = 10  FAIL
                                                //  F =  +  FAIL

                                              ]);
                                      }
                                    })),
                            Container(
                              color: Colors.blue.shade100,
                              height: 20,
                            ),
                          ]);
                        } catch (e) {
                          debugPrint("=======Problem with stream========");
                        }

                        return const Text("Loading Data....");
                      }),
                  const SizedBox(
                    height: 150,
                  ),
                ]),
              ),

              //   SizedBox(height: 100),

//=====================================================================================================================================

              const SizedBox(height: 100),

              const SizedBox(
                width: 150,
              ),
            ],
          ),
        ));
  }
}
