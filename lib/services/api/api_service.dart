
import 'package:dio/dio.dart';

import '../../models/product.dart';

class ApiService{
  String apiEndpoint;
  ApiService(this.apiEndpoint);

  // Helper method for making GET requests
  Future getResponse() async{
     var response =  await Dio().get(apiEndpoint);
     if(response.statusCode == 200){
       return response.data;

     }
     return response.data;

  }



}