import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Site Search'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  static String name = "";
  List<String> sites = ["Google","Wikipedia"];
  List<String> urls = [
    "https://www.google.co.jp/search?q=",
    "https://ja.wikipedia.org/wiki/"
  ];
  String _site = "Google";
  String url = "";
  String register_search = "";
  bool drawer_field = false;
  String message = "";
  String _hint_text = "Write you want find...";

  void _setSite(String site){
    setState(() {
      _site = site;
    });
      message = "${_site} Search";
  }

  void _name_change(value){
    setState(() {
      name = value;
    });
  }

  void _change_hit(){
    setState(() {
      _hint_text = "Write your new site's title";
    });
  }


  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView.builder(
          itemCount: sites.length,
          itemBuilder: ((context, index) {
              return ListTile(
                title: Text(sites[index]),
                onTap: ()=> {_setSite(sites[index])}
              );
            }
          )
          )
      ),
      body: Container(
        width: double.infinity,
        child:Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: _hint_text
              ),
              onChanged: (value) {
                _name_change(value);
              },
            ),
            IconButton(
              onPressed: () async {
                if(name.isNotEmpty){{
                    int number = sites.indexOf(_site);
                    String url = Uri.encodeFull(
                      urls[number]+name
                    );
                    if(await canLaunchUrlString(url)){
                        await launchUrlString(url);
                    }
                  }
                }
                },
                icon: Icon(Icons.search),
              ),
              Text(message),
          ]
          )
      ),
    );
  }
}
