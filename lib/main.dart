import 'package:awsomeflutter/animation.dart';
import 'package:awsomeflutter/hero_animation.dart';
import 'package:awsomeflutter/offsetanddelay.dart';
import 'package:awsomeflutter/parenting_animation.dart';
import 'package:awsomeflutter/radial_hero.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:awsomeflutter/service.dart';
import 'package:awsomeflutter/post_model.dart';
import 'second_route.dart';
import 'transition.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.purpleAccent,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  Future<Null> _refresh() {
    return Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () => _refresh(),
        child: FutureBuilder<List<Post>>(
          future: getAllPosts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Stack(
                  children: <Widget>[
                    Container(
                        child: Center(
                      child: Text('Connection Lost:('),
                    )),
                    ListView()
                  ],
                );
              } else if (snapshot.hasData) {
                return Center(
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, pos) {
                      var d = snapshot.data[pos];
                      return ListTile(
                        onTap: () {},
                        contentPadding: EdgeInsets.all(10),
                        title: Text(d.title),
                        subtitle: Text(d.body),
                        leading: Text(d.id.toString()),
                      );
                    },
                  ),
                );
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text("sajad"),

            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              ),
          ),
          ListTile(
            title: Text("SecondRoute"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondRoute()),
              );
            },
          ),
          ListTile(
            title: Text("OffsetDelay"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OffsetDelayAnimationWidget()),
              );
            },
          ),
          ListTile(
            title: Text("Parenting"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StaggerDemo()),
              );
            },
          ),
          ListTile(
            title: Text("Transformation"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TransformationAnimationWidget()),
              );
            },
          ),
          ListTile(
            title: Text("Hero"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HeroAnimation()),
              );
            },
          ),
          ListTile(
            title: Text("radialHero"),
            onTap: (){
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => RadialExpansionDemo())
               );
            },
          ),
          ListTile(
            title: Text("Animation"),
            onTap: (){
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => AnimRoute())
               );
            },
          )
        ],
      )),
    );
  }
}

// callAPI() {
//   Post post = Post(
//       body: 'Testing body body body',
//       title: 'Flutter jam6',
//       ); // creating a new Post object to send it to API

//   createPost(post).then((response) {
//     if (response.statusCode > 200)
//       print('daorost :${response.body}');
//     else
//       print(response.statusCode);
//   }).catchError((error) {
//     print('error : $error');
//   });
// }
