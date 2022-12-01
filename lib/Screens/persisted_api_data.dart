import 'dart:convert';
import 'dart:developer';
import 'package:assignment/Models/datamodel.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:json_cache/json_cache.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersistedAPIdata extends StatefulWidget {
  const PersistedAPIdata({super.key});

  @override
  State<PersistedAPIdata> createState() => _PersistedAPIdataState();
}

class _PersistedAPIdataState extends State<PersistedAPIdata> {
  List<UserData> dataList = <UserData>[];

  Future<UserData> fetchData() async {
    var headers = {
      'securitykey':
          'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjIiLCJlbWFpbCI6Im9yYWlsa2FuZUBnbWFpbC5jb20iLCJjb250YWN0X25vIjoiODQ0NTE2NjU1NiIsImlhdCI6MTY2OTAzNTk4OSwiZXhwIjoxNjY5MTIyMzg5fQ._FSgvVHoxasV41-V25i075gdmDaprZil_iWhQaXydVE',
      'accesstoken':
          'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjIiLCJlbWFpbCI6Im9yYWlsa2FuZUBnbWFpbC5jb20iLCJjb250YWN0X25vIjoiODQ0NTE2NjU1NiIsImlhdCI6MTY2OTg3NDk1NSwiZXhwIjoxNjY5OTYxMzU1fQ.U49AJSbs0LdPsBNoW6clc8FAC-nTwxG9MDxEebwHs3U'
    };
    var request = http.MultipartRequest('POST',
        Uri.parse('http://3.6.144.86/matrimony/public/api/today-matches'));
    request.fields.addAll({'page_no': '1'});

    request.headers.addAll(headers);
    http.StreamedResponse stremedResponse = await request.send();
    var response = await http.Response.fromStream(stremedResponse);
    var data = jsonDecode(response.body);
    if (stremedResponse.statusCode == 200) {
      dataList.addAll(DataModel.fromJson(data).data);
      log(response.body);
      persistData(data);
    } else {
      log(stremedResponse.reasonPhrase.toString());
    }
    return UserData.fromJson(data);
  }

  Future getPersistedData() async {
    final prefs = await SharedPreferences.getInstance();
    final JsonCacheMem jsonCache = JsonCacheMem(JsonCachePrefs(prefs));
    var a = await jsonCache.value('profile');
    dataList.addAll(DataModel.fromJson(a!).data);
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {});
    });
  }

  void persistData(var resp) async {
    final prefs = await SharedPreferences.getInstance();
    final JsonCacheMem jsonCache = JsonCacheMem(JsonCachePrefs(prefs));
    await jsonCache.refresh('profile', resp);
  }

  @override
  void initState() {
    fetchData();
    getPersistedData();
    setState(() {});
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (((context, index) {
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        height: 200,
                        width: MediaQuery.of(context).size.width * .9,
                        child: CachedNetworkImage(
                          imageUrl: dataList[index].image == ''
                              ? 'https://images.pexels.com/photos/8419256/pexels-photo-8419256.jpeg?auto=compress&cs=tinysrgb&w=1600&lazy=load'
                              : dataList[index].image,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                      value: downloadProgress.progress),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                    Text(dataList[index].name),
                  ],
                );
              })))),
    );
  }
}
