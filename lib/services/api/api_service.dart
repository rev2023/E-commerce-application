
import 'package:dio/dio.dart';


class ApiService{
  Uri apiEndpoint;
  ApiService(this.apiEndpoint);

  // Helper method for making GET requests
  Future getResponse() async{
     var response =  await Dio().getUri(apiEndpoint);
     if(response.statusCode == 200){
       return response.data;
     }
     else {
       return response.statusMessage;
     }

  }



}