import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:tentwenty/database/Theme.dart';
import 'package:tentwenty/database/config.dart';
import 'package:tentwenty/database/service.dart';
import 'package:tentwenty/src/watchPages/showDetail.dart';

class WatchPage extends StatefulWidget {
  @override
  _WatchPageState createState() => _WatchPageState();
}

class _WatchPageState extends State<WatchPage> {
  var service = ApiService();
  List showsList = [];
  List categoryList = [1, 2, 3, 4, 5, 6, 7, 1, 1, 1, 1, 1, 1, 1, 1];
  List searchList = [];
  bool loading = false;
  var search = new TextEditingController();
  bool searchMode = false;
  bool showResults = false;

  @override
  void initState() {
    super.initState();
    getUpcomingShows();
  }

  getUpcomingShows() {
    setState(() {
      loading = true;
    });

    ApiService().getAllShows().then((res) {
      if (res['results'] != null && mounted) {
        this.showsList = res['results'];
      }

      setState(() {
        loading = false;
      });
    });
  }
  searchShows() {
    setState(() {
      loading = true;
    });

    ApiService().search(search.text).then((res) {
      if (res['results'] != null && mounted) {
        this.searchList = res['results'];
      }

      setState(() {
        loading = false;
      });
    });
  }

  PreferredSize mainWatchAppBar() {
    return PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, 111),
      child: Container(
        height: 111,
        padding: EdgeInsets.only(bottom: 24, right: 27, left: 22),
        color: Colors.white,
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Watch',
              style:
                  TextStyle(fontSize: f16, color: textColor1, fontWeight: w500),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  searchMode = true;
                });
              },
              child: Icon(
                Icons.search,
              ),
            )
          ],
        ),
      ),
    );
  }

  PreferredSize searchResultsAppBar() {
    return PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, 111),
      child: Container(
        height: 111,
        padding: EdgeInsets.only(bottom: 24, right: 27, left: 22),
        color: Colors.white,
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  searchMode = false;
                  showResults = false;
                  searchList = [];
                  search.clear();
                });
              },
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
              ),
            ),
            SizedBox(
              width: 26,
            ),
            Text(
              searchList.length.toString() + ' Results Found',
              style:
                  TextStyle(fontSize: f16, color: textColor1, fontWeight: w500),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSize searchWatchAppBar() {
    return PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, 132),
      child: Container(
        height: 132,
        padding: EdgeInsets.only(bottom: 24, right: 27, left: 22),
        color: Colors.white,
        alignment: Alignment.bottomCenter,
        child: TextField(
          controller: search,
          onChanged: (tt) {
          
            setState(() {});
          },
          onSubmitted: (_) {
            if(search.text.trim() != '' ){
 searchShows();
            setState(() {
              showResults = true;
            });
            }
           
          },
          cursorColor: Colors.black,
          style: TextStyle(color: textColor1, fontSize: f14, fontWeight: w400),
          decoration: InputDecoration(
            fillColor: backgroundColor,
            hintText: 'TV shows, movies and more',
            hintStyle: TextStyle(
                fontSize: f14,
                fontWeight: w600,
                color: textColor1.withOpacity(0.3)),
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: Colors.transparent),
              borderRadius: BorderRadius.circular(100),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: Colors.transparent),
              borderRadius: BorderRadius.circular(100),
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  search.clear();
                  searchMode = false;
                  showResults = false;
                  searchList = [];
                });
              },
              child: Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget mainWatchBody() {
    return loading
        ? Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
            ),
          )
        : showsList.length == 0
            ? Center(child: Text('No Data Available'))
            : ListView(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  shows(),
                  SizedBox(
                    height: 24,
                  ),
                ],
              );
  }

  Widget searchBody() {
    return loading
        ? Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
            ),
          )
        : categoryList.length == 0
            ? Center(child: Text('No Data Available'))
            : ListView(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  categories(),
                  SizedBox(
                    height: 24,
                  ),
                ],
              );
  }

  Widget searchResultsBody() {
    return loading
        ? Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
            ),
          )
        : searchList.length == 0
            ? Center(child: Text('No Data Available'))
            : ListView(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  if (!showResults)
                    SizedBox(
                      height: 30,
                    ),
                  if (!showResults)
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: h_Padding),
                      child: Text(
                        'Top Results',
                        style: TextStyle(
                            color: textColor1, fontSize: f12, fontWeight: w500),
                      ),
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  if (!showResults)
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: h_Padding),
                      child: Divider(
                        thickness: 1,
                        color: Colors.black.withOpacity(0.11),
                      ),
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  searchResults(),
                  SizedBox(
                    height: 24,
                  ),
                ],
              );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: showResults
            ? searchResultsAppBar()
            : !searchMode
                ? mainWatchAppBar()
                : searchWatchAppBar(),
        body: !searchMode
            ? mainWatchBody()
            : search.text == ''
                ? searchBody()
                : searchResultsBody());
  }

  Widget shows() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        width: MediaQuery.of(context).size.width,
        child: GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                crossAxisCount: 1,
                childAspectRatio: 335 / 180),
            itemCount: showsList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 1000),
                          reverseTransitionDuration:
                              Duration(milliseconds: 1000),
                          pageBuilder: (context, a, b) => ShowDetailPage(
                                showData: showsList[index],
                              )));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 7,
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2)
                      ]),
                  margin:
                      EdgeInsets.fromLTRB(h_Padding, h_Padding, h_Padding, 0),
                  child: Hero(
                    tag: showsList[index]['id'],
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 180,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    Configuration.image_url +
                                        showsList[index]['poster_path'],
                                    maxHeight: 1000,
                                    maxWidth: 1000),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(10)),
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(h_Padding),
                          child: Material(
                            color: Colors.transparent,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Text(
                                showsList[index]['original_title'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: f18,
                                    fontWeight: w500),
                              ),
                            ),
                          ),
                        )),
                  ),
                ),
              );
            }));
  }

  Widget categories() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: h_Padding, vertical: 0),
        width: MediaQuery.of(context).size.width,
        child: GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                crossAxisCount: 2,
                childAspectRatio: 163 / 100),
            // padding: EdgeInsets.only(left: 12),
            itemCount: categoryList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 7,
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2)
                      ]),
                  child: Hero(
                    // tag: category[index]['id'],
                    tag: index,

                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    'https://images.unsplash.com/photo-1470229722913-7c0e2dbbafd3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c2hvd3xlbnwwfHwwfHw%3D&w=1000&q=80',
                                    maxHeight: 1000,
                                    maxWidth: 1000),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(10)),
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 20),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Text(
                              'Free Guy',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: f16,
                                  fontWeight: w500),
                            ),
                          ),
                        )),
                  ),
                ),
              );
            }));
  }

  Widget searchResults() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: h_Padding, vertical: 0),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: List.generate(
              searchList.length,
              (index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 1000),
                              reverseTransitionDuration:
                                  Duration(milliseconds: 1000),
                              pageBuilder: (context, a, b) => ShowDetailPage(
                                    showData: searchList[index],
                                  )));
                    },
                    child: Container(
                      height: 100,
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AspectRatio(
                            aspectRatio: 130 / 100,
                            child: Hero(
                              tag: searchList[index]['id'],
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            Configuration.image_url +
                                                searchList[index]['poster_path'],
                                            maxHeight: 1000,
                                            maxWidth: 1000),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 21,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  searchList[index]['original_title'],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: textColor1,
                                      fontSize: f16,
                                      fontWeight: w500),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'Fantasy',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: textColor2,
                                      fontSize: f12,
                                      fontWeight: w500),
                                )
                              ],
                            ),
                          ),
                          Icon(
                            Icons.more_horiz_rounded,
                            color: skyBlue,
                          )
                        ],
                      ),
                    ),
                  )),
        ));
  }
}
