import 'package:flutter/material.dart'; 
import 'package:flutter_auth0/bloc/access_bloc.dart'; 
import 'package:flutter_auth0/bloc/app_provider.dart'; 
import 'package:flutter_auth0/utils/auth_utils.dart'; 
import 'package:flutter_auth0/utils/url_utils.dart' show DOMAIN; 

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AccessBloc accessBloc = AppProvider.of(context).accessBloc; 
    return Scaffold(
      appBar:AppBar(
        title:Text("Flutter Auth0"), 
        actions: < Widget > [
          IconButton(
            icon:Icon(Icons.backspace), 
            onPressed:() {
            }, 
          )
        ], 
      ), 
      body:StreamBuilder < User > (
        stream:accessBloc.output, 
        builder:(BuildContext context, AsyncSnapshot < User > snapshot) {
          if ( ! snapshot.hasData) {
            return Center(child:CircularProgressIndicator()); 
          }else if (snapshot.hasError) {
            return Center(child:Text("Error occured: ${snapshot.error}")); 
          }
          return Center(
            child:Column(
              mainAxisAlignment:MainAxisAlignment.center, 
              children: < Widget > [
                profilePicture(150, snapshot.data.pictureUrl), 
                SizedBox(height:24.0), 
                Text(
                  'Name: ${snapshot.data.name}', 
                  style:TextStyle(fontWeight:FontWeight.w600, fontSize:18.0), ), 
                SizedBox(height:24.0), 
                Text(
                  'Nickname: ${snapshot.data.nickname}', 
                  style:TextStyle(fontWeight:FontWeight.w600, fontSize:18.0), ), 
              ], ), ); 
        }, ), ); 
  }
}

Widget profilePicture(double size, String url) {
  return Container(
    width:size, 
    height:size, 
    decoration:new BoxDecoration(
      border:Border.all(color:Colors.blue, width:4.0), 
      shape:BoxShape.circle, 
      image:new DecorationImage(
        fit:BoxFit.fill, 
        image:new NetworkImage(
          url, ), ), ), ); 
}
