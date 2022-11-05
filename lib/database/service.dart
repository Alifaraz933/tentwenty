

import 'package:dio/dio.dart';

import 'package:http/http.dart' as http;



import 'config.dart';

class ApiService {
  var client = http.Client();
  var dio = new Dio();

  String key = '?api_key=dd586e1c5a8cb0e6289c22a6b281ceeb';

  // get all shows
  Future<dynamic> getAllShows() async {
    var url = Configuration.url + 'movie/upcoming'+key;
   
    var resp = await this.dio.get(url);
   
    var d = resp.data;
    return d;
  }

  // get video of show
  Future<dynamic> getVideo(id) async {
    var url = Configuration.url + 'movie/'+id+'/videos'+key;
   
    var resp = await this.dio.get(url);
   
    var d = resp.data;
    return d;
  }
  // get movie Detail
  Future<dynamic> getMovie(id) async {
    var url = Configuration.url + 'movie/'+id+key;
   
    var resp = await this.dio.get(url);
   
    var d = resp.data;
    return d;
  }

  // search shows
  Future<dynamic> search(keyword) async {
    var url = Configuration.url + 'search/movie'+key+'&query='+keyword;
   
    var resp = await this.dio.get(url);
   
    var d = resp.data;
    return d;
  }
 
  
}
