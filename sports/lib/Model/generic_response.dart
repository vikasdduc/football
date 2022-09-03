class GenericResponse{
  bool status;
  String message;

  GenericResponse.fromJson(json){
    status = json["status"];
    message = json["message"];

  }

  GenericResponse.withError(msg){
    status = false;
    message = msg==null?'Something went wrong':msg;
  }

}