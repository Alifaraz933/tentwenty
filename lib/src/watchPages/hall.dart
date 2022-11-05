import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


import 'package:tentwenty/database/Theme.dart';
import 'package:tentwenty/database/config.dart';
import 'package:tentwenty/database/service.dart';
import 'package:tentwenty/src/watchPages/selectSeats.dart';


class HallPage extends StatefulWidget {
  dynamic showData;
  HallPage({ @required this.showData});
  @override
  _HallPageState createState() => _HallPageState();
}

class _HallPageState extends State<HallPage> {
  var service = ApiService();

  int selected = 0;

  DateTime today = DateTime.now();
 

  @override
  void initState() {
    super.initState();

  }

  

  PreferredSize myAppBar() {
    return PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, 123),
      child: Container(
        height: 123,
        padding: EdgeInsets.only(bottom: 24, right: 27, left: 22),
        color: Colors.white,
        alignment: Alignment.bottomCenter,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                 Navigator.pop(context);
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 18,
                ),
              ),
            ),
            
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.showData['original_title'],
                    style:
                        TextStyle(fontSize: f16, color: textColor1, fontWeight: w500),
                  ),
                 Text(
                        'In Theaters ' +
                            DateFormat('MMMM dd,y').format(
                                DateTime.parse(widget.showData['release_date'])),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: skyBlue, fontSize: f12, fontWeight: w500),
                      )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: myAppBar(),
        bottomNavigationBar: 
                                Padding(
                                  padding: const EdgeInsets.all(26.0),
                                  child: MaterialButton(
                                    elevation: 0,
                          onPressed: () {

                             Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SeatsPage(
                                                showData: widget.showData,
                                              )));

                          },
                          color: skyBlue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            'Select Seats',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                  color: Colors.white,
                                  fontSize: f14,
                                  fontWeight: w600),
                          ),
                          height: 50,
                          // minWidth: 169,
                        ),
                                ),
        
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 94,),
              Padding(padding: EdgeInsets.symmetric(horizontal: h_Padding),
              
              child:  Text(
                    'Date',
                    style:
                        TextStyle(fontSize: f16, color: textColor1, fontWeight: w500),
                  ),),
              SizedBox(height: 14,),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,

                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: h_Padding),
                  child: Row(
                    children: List.generate(7, (index) => 
                    
                    Container(height: 32,
                    margin: EdgeInsets.only(right: index == 6? 0: 12),
                  padding: const EdgeInsets.symmetric(horizontal: h_Padding),

                    decoration: BoxDecoration(
                      color: skyBlue,
                      borderRadius: BorderRadius.circular(10)
                    ),
              alignment: Alignment.center,
                    child: Text(
                   DateFormat('d MMM').format(
                                    today.add(Duration(days: index))),
              
                                    style: TextStyle(
                                      color: Colors.white
                                    ),
                    ),
                    )
                    ),
                  ),
                ),
              ),

              SizedBox(height: 39,),

                SingleChildScrollView(
                scrollDirection: Axis.horizontal,

                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: h_Padding),
                  child: Row(
                    children: List.generate(3, (index) => 
                    
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          selected = index;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                    
                            Row(
                              children:[
                               Text('12:30',
                               style:
                          TextStyle(fontSize: f12, color: textColor1, fontWeight: w500),
                               
                               ),
                               SizedBox(width: 9,),
                                Text('Cinetech + Hall '+(index+1).toString(),
                                style:
                          TextStyle(fontSize: f12, color: textColor3, fontWeight: w400),
                               
                               ),
                              ]
                            ),
                            SizedBox(height: 5,),
                            Container(height: 145, width: 249,
                            decoration: BoxDecoration(
                    
                              borderRadius: BorderRadius.circular(10),
                              border:  Border.all(color:  selected == index? skyBlue : Colors.transparent, width: 2)
                       ,
                       image: DecorationImage(
                         image: AssetImage('assets/hall.jpeg'),
                         fit: BoxFit.contain
                       )

                            ),
                            ),
                            SizedBox(height: 10,),
                    
                            Row(
                              children:[
                               Text('From ' ,
                                     style:
                          TextStyle(fontSize: f12, color: textColor3, fontWeight: w500),
                               
                               
                               ),
                         
                                Text('50\$ ',
                                      style:
                          TextStyle(fontSize: f12, color: textColor1, fontWeight: w700),
                               
                               ),
                            
                    
                               Text('or ',
                                     style:
                          TextStyle(fontSize: f12, color: textColor3, fontWeight: w500),
                               
                               ),
                               
                                Text('2500 bonus',
                                      style:
                          TextStyle(fontSize: f12, color: textColor1, fontWeight: w700),
                               
                               ),
                              ]
                            ),
                    
                          ],
                        ),
                      ),
                    )
                    ),
                  ),
                ),
              ),



            ],
          ),
        ));
  }


}
