import 'package:flutter/material.dart';
import 'package:news_epi/api.dart';
import 'package:news_epi/model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'widgets.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleAuthProvider googleProvider = GoogleAuthProvider();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error),
            );
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder(
                stream: auth.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasError)
                    return Center(
                      child: Text(snapshot.error),
                    );
                  else if (snapshot.hasData) return MyHomePage();
                  return Scaffold(
                    body: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          FirebaseAuth.instance.signInWithPopup(googleProvider);
                        },
                        child: Text("Sign in with google"),
                      ),
                    ),
                  );
                });
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
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
  int _counter = 0;
  int index = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "News App",
            style: TextStyle(color: Colors.blue),
          ),
          backgroundColor: Colors.white,
          leading: Icon(
            Icons.home,
            color: Colors.blue,
          )),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) {
          setState(() {
            index = i;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: "News"),
          BottomNavigationBarItem(icon: Icon(Icons.save), label: "Saved"),
        ],
      ),
      body: FutureBuilder<List<NewsModel>>(
        future: getNews(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: NewsCard(
                    newsModel: NewsModel(
                      title: snapshot.data[index].title,
                      description: snapshot.data[index].description,
                      url: snapshot.data[index].url,
                      imgUrl: snapshot.data[index].imgUrl,
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
