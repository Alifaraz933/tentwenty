import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:tentwenty/database/Theme.dart';
import 'package:tentwenty/database/config.dart';
import 'package:tentwenty/database/service.dart';
import 'package:tentwenty/src/watchPages/hall.dart';
import 'package:tentwenty/src/watchPages/videoPlayer.dart';

class ShowDetailPage extends StatefulWidget {
  dynamic showData;

  ShowDetailPage({@required this.showData});

  @override
  _ShowDetailPageState createState() => _ShowDetailPageState();
}

class _ShowDetailPageState extends State<ShowDetailPage> {
  var service = ApiService();

  List tags = [];

  String videoLink = '';

  @override
  void initState() {
    super.initState();

    getVideo();
    getDetail();
  }

  _showAlert(text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        // timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  getVideo() {
    ApiService().getVideo(widget.showData['id'].toString()).then((res) {
      if (res['results'] != null && res['results'].length > 0) {
        videoLink = res['results'][0]['key'];
      }
    });
  }

  getDetail() {
    ApiService().getMovie(widget.showData['id'].toString()).then((res) {
      log(res.toString());
      if (res['genres'] != null && res['genres'].length > 0) {
        tags = res['genres'];

        setState(() {});
      }
    });
  }

  Widget imagePart(bool landscape) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: landscape
              ? MediaQuery.of(context).size.height
              : MediaQuery.of(context).size.width,
          color: Colors.transparent,
          child: AspectRatio(
            aspectRatio: 375 / 378,
            child: Hero(
              tag: widget.showData['id'],
              child: FadeInImage(
                fit: BoxFit.cover,
                placeholder: AssetImage(
                  'assets/loading.gif',
                ),
                image: CachedNetworkImageProvider(
                    Configuration.image_url + widget.showData['poster_path'],
                    maxHeight: 1000,
                    maxWidth: 1000),
              ),
            ),
          ),
        ),
        Positioned(
            left: 0,
            top: 0,
            child: Container(
              height: 111,
              padding: EdgeInsets.only(bottom: 24, right: 27, left: 22),
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios_new_rounded,
                        size: 18, color: Colors.white),
                  ),
                  SizedBox(
                    width: 26,
                  ),
                  Text(
                    'Watch',
                    style: TextStyle(
                        fontSize: f16, color: Colors.white, fontWeight: w500),
                  ),
                ],
              ),
            )),
        Positioned(
            bottom: 0,
            child: Container(
              width: landscape ? MediaQuery.of(context).size.height : 243,
              child: Column(
                children: [
                  FittedBox(
                    child: Text(
                      'In Theaters ' +
                          DateFormat('MMMM dd,y').format(
                              DateTime.parse(widget.showData['release_date'])),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.white, fontSize: f16, fontWeight: w500),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  if (landscape)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          elevation: 0,
                          onPressed: () {

                             Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HallPage(
                                              showData: widget.showData,
                                            )));

                          },
                          color: skyBlue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            'Get Tickets',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: f14,
                                fontWeight: w600),
                          ),
                          height: 50,
                          minWidth: 169,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                          height: 50,
                          width: 169,
                          decoration: BoxDecoration(
                              border: Border.all(color: skyBlue),
                              borderRadius: BorderRadius.circular(10)),
                          child: OutlinedButton(
                            onPressed: () {
                              if (videoLink != '') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VideoPlayerPage(
                                              videoKey: videoLink,
                                            )));
                              } else {
                                _showAlert('No video found');
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.play_arrow_rounded,
                                    color: Colors.white),
                                Text(
                                  'Watch Trailer',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: f14,
                                      fontWeight: w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (!landscape)
                    DelayedDisplay(
                      delay: Duration(milliseconds: 800),
                      child: Column(
                        children: [
                          MaterialButton(
                            elevation: 0,
                            onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HallPage(
                                              showData: widget.showData,
                                            )));

                            },
                            color: skyBlue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              'Get Tickets',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: f14,
                                  fontWeight: w600),
                            ),
                            height: 50,
                            minWidth: 243,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: skyBlue),
                                borderRadius: BorderRadius.circular(10)),
                            child: OutlinedButton(
                              onPressed: () {
                                if (videoLink != '') {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => VideoPlayerPage(
                                                videoKey: videoLink,
                                              )));
                                } else {
                                  _showAlert('No video found');
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.play_arrow_rounded,
                                      color: Colors.white),
                                  Text(
                                    'Watch Trailer',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: f14,
                                        fontWeight: w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(
                    height: landscape ? 20 : 34,
                  ),
                ],
              ),
            ))
      ],
    );
  }

  Widget detailPart(bool landscape) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: landscape ? 51 : 27,
        ),
        Text(
          'Genres',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: textColor1, fontSize: f16, fontWeight: w500),
        ),
        SizedBox(
          height: 16,
        ),
        Wrap(
          runSpacing: 10,
          spacing: 5,
          children: List.generate(
              tags.length,
              (index) => Container(
                    height: 24,
                    width: double.parse(
                        (tags[index]['name'].length * 12).toString()),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: index%4 == 0? green : index%4 == 1? pink: index%4 == 2? purple: yellow , borderRadius: BorderRadius.circular(100)),
                    child: Text(
                      tags[index]['name'],
                      style: TextStyle(
                          color: Colors.white, fontSize: f12, fontWeight: w600),
                    ),
                  )),
        ),
        SizedBox(
          height: 24,
        ),
        Divider(
          thickness: 1,
          color: Colors.black.withOpacity(0.11),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'Overview',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: textColor1, fontSize: f16, fontWeight: w500),
        ),
        SizedBox(
          height: 14,
        ),
        Container(
          width: landscape
              ? MediaQuery.of(context).size.height * 0.8
              : double.infinity,
          child: Text(
            widget.showData['overview'],
            maxLines: 10,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: textColor3,
            ),
          ),
        ),
        SizedBox(
          height: 14,
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          physics: landscape
              ? NeverScrollableScrollPhysics()
              : BouncingScrollPhysics(),
          child: landscape
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    imagePart(landscape),
                    detailPart(landscape),
                  ],
                )
              : Column(
                  children: [
                    imagePart(landscape),
                    detailPart(landscape),
                  ],
                ),
        ));
  }
}
