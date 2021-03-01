import 'package:flutter/material.dart';
import 'package:news_epi/details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  int _counter = 0;
  int index = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: NewsCard(
              title: 'Article Title',
              description: 'This is a description of the article.',
              articleUrl: '',
              imageUrl:
                  'https://api.time.com/wp-content/uploads/2015/02/cats.jpg?quality=85&w=1024&h=512&crop=1',
            ),
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

class NewsCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String articleUrl;

  NewsCard({this.title, this.articleUrl, this.description, this.imageUrl});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return NewsDetails(
                description: description,
                title: title,
                imageUrl: imageUrl,
              );
            },
          ),
        );
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Image.network(imageUrl),
                Positioned(
                  bottom: 12,
                  left: 12,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      color: Colors.pink,
                      child: Text(
                        title,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                description,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
