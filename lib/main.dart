import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/browser_client.dart';
import 'package:http/http.dart';

void main() {
  runApp(MaterialApp(home: Home(),));
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Demo'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async =>
                  login().then((value) {
                    setState(() {
                      text = value;
                    });
                  }
                  ),
              child: const Text('login'),
            ),
            ElevatedButton(
              onPressed: () async =>
                  getRequest().then((value) {
                    setState(() {
                      text = value;
                    });
                  }
                  ),
              child: const Text('getRequest'),
            ),
            Flexible(
              // flex: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical, //.horizontal
                child: Text(text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<String> login() async{
  Map<String, String> loginData = {
    'username': 'test',
    'password': 'password'
  };

  Client client = Client();
  if(client is BrowserClient) {
    client.withCredentials = true;  // this is the key to store cookies onto the browser
  }
  Response res =  await client.post(Uri.parse('http://yourserver.com'), body: loginData);  //change url to your server url

  return res.body.toString();
}

Future<String> getRequest() async{
  Client client = Client();
  if(client is BrowserClient) {
    client.withCredentials = true;  // this is the key for using the stored cookies from the browser
  }
  Response res =  await client.get(Uri.parse('http://yourserver.com'));   //change url to your server url

  return res.body.toString();
}