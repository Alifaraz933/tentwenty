import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


import 'package:tentwenty/database/Theme.dart';
import 'package:tentwenty/database/config.dart';
import 'package:tentwenty/database/service.dart';


class SeatsPage extends StatefulWidget {
  dynamic showData;
  SeatsPage({ @required this.showData});
  @override
  _SeatsPageState createState() => _SeatsPageState();
}

class _SeatsPageState extends State<SeatsPage> {
  var service = ApiService();

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
                                  child: Row(
                                    children: [
                                      MaterialButton(
                                        elevation: 0,
                          onPressed: () {

                          

                          },
                          color: Color(0xFFA6A6A6).withOpacity(0.1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total Price',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                          color: textColor1,
                                          fontSize: f10,
                                          fontWeight: w400),
                              ),
                              Text(
                                '\$ 50',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                          color: textColor1,
                                          fontSize: f16,
                                          fontWeight: w600),
                              ),
                            ],
                          ),
                          height: 50,
                          minWidth: 108,
                        ),
                        SizedBox(width:10),
                                      Expanded(
                                        child: MaterialButton(
                                          elevation: 0,
                                                                onPressed: () {
                                      
                                                                
                                      
                                                                },
                                                                color: skyBlue,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(10)),
                                                                child: Text(
                                                                  'Proceed to pay',
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
                                    ],
                                  ),
                                ),
        
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 62,),

              Container(height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                 image: DecorationImage(
                         image: AssetImage('assets/hall2.png',
                         
                         ),
                         fit: BoxFit.contain
                       )
              ),
              ),

              SizedBox(height: 26,),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: h_Padding),
                child: Row(
                  children:[

                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                    
                      child: Row(
                        children: [
                        Container(
                          height: 20,
                          width: 20,
                          child: Image.asset('assets/yellow_seat.png',
                          
                          )),
                        SizedBox(width: 12,),
                        Text('Selected',
                        style: TextStyle( fontSize: f12, fontWeight: w500, color: textColor3),
                        )

                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                    
                      child: Row(
                        children: [
                         Container(
                          height: 20,
                          width: 20,
                          child: Image.asset('assets/grey_seat.png',
                          )),
                        SizedBox(width: 12,),
                        Text('Not available',
                        style: TextStyle( fontSize: f12, fontWeight: w500, color: textColor3),
                        
                        )

                        ],
                      ),
                    ),
                    
                  ]
                ),
              ),
             
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: h_Padding),
                child: Row(
                  children:[

                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                    
                      child: Row(
                        children: [
                         Container(
                          height: 20,
                          width: 20,
                          child: Image.asset('assets/purple_seat.png',
                          )),
                        SizedBox(width: 12,),
                        Text('VIP ( 150\$ )',
                        style: TextStyle( fontSize: f12, fontWeight: w500, color: textColor3),
                        
                        )

                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                    
                      child: Row(
                        children: [
                         Container(
                          height: 20,
                          width: 20,
                          child: Image.asset('assets/sky_seat.png',
                          )),
                        SizedBox(width: 12,),
                        Text('Regular ( 50\$ )',
                        style: TextStyle( fontSize: f12, fontWeight: w500, color: textColor3),
                        
                        )

                        ],
                      ),
                    ),

                  
                    
                  ]
                ),
              ),

             SizedBox(height: 32,),

                    Container(
                      margin: EdgeInsets.symmetric(horizontal: h_Padding),
                      // height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFFA6A6A6).withOpacity(0.1)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('4 / ',
                          style: TextStyle( fontSize: f14, fontWeight: w500, color: textColor1),
                          
                          ),
                            Text('3 row ',
                          style: TextStyle( fontSize: f10, fontWeight: w400, color: textColor3),
                          
                          ),
                          Icon(Icons.close, size: 16,)
                          ],
                        ),
                      ),
                    ),

             

             

            ],
          ),
        ));
  }


}
