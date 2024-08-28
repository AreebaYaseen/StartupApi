import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/UserModel.dart';

class Home2 extends StatefulWidget {
  const Home2({super.key});

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  List<UserModel> userList=[];

  Future<List<UserModel>> getUserApi() async{
    final response= await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data= jsonDecode(response.body.toString());
    if(response.statusCode==200){
      for(Map i in data){
        print(i['name']);
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    }
    else{
      return userList;

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StartUp'),

      ),
      body: Column(
        children: [
            Expanded(child: FutureBuilder(future: getUserApi(), builder: (
            context, AsyncSnapshot<List<UserModel>> snapshot)
            {
              if(!snapshot.hasData){
                return CircularProgressIndicator();
              }
              else
                {
                  return ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (context, index){
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ReuseableRow(title: 'Name', value: snapshot.data![index].name.toString()),
                                ReuseableRow(title: 'Username', value: snapshot.data![index].username.toString()),
                                ReuseableRow(title: 'Email', value: snapshot.data![index].email.toString()),
                                ReuseableRow(title: 'Address',
                                    value: snapshot.data![index].address!.city.toString()+
                                    snapshot.data![index].address!.geo.toString()+
                                        snapshot.data![index].address!.suite.toString()+
                                        snapshot.data![index].address!.zipcode.toString()


                                )



                              ],
                            ),
                          ),
                        );
                      });

                }
            }))
        ],
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  String title, value;
   ReuseableRow({Key? key , required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(value)
        
      ],
    );
  }
}
