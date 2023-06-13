import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trackerapp/models/WorldStatsModel.dart';
import 'package:trackerapp/utils/app_url.dart';

class StatsServices{

  Future<WorldStatsModel> fetchWorldStats () async {
    final response = await http.get(Uri.parse(AppUrl.worldStatsapi));

    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      return WorldStatsModel.fromJson(data);
    }
    else{
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> countiresListapi () async {
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));

    if(response.statusCode == 200){
      data = jsonDecode(response.body);
      return data;
    }
    else{
      throw Exception('Error');
    }
  }

}