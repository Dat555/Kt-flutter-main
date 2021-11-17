import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/service.dart';
import 'package:flutter_application_1/model/tesla_model.dart';
import 'package:flutter_application_1/program/showcontent.dart';
import 'package:flutter_application_1/program/value.dart';

class BuidlWeb extends StatefulWidget {
  const BuidlWeb({Key? key}) : super(key: key);

  @override
  _BuidlWeblState createState() => _BuidlWeblState();
}

class _BuidlWeblState extends State<BuidlWeb> {
  int count = 0;
  late Size size;
  int i = 0;
  var arr = [
    Service().fetchDataTesla(Value().country),
    Service().fetchDataTesla(Value().techcrunch),
    Service().fetchDataTesla(Value().apple)
  ];
  var image = [Value().imagecountry, Value().imagetechcrunch, Value().imageapple];
  var str = ["Country", "Tech Crunch", "Apple"];
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(child: buildBody()),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [buildTest(), buildContent(), buildContentList()],
      ),
    );
  }

  Widget buildTest() {
    return Container(
      height: size.height * 0.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "flutter",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Text(
            "News",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.blue[300]),
          )
        ],
      ),
    );
  }

  Widget buildContent() {
    return Container(
      height: size.height * 0.17,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: arr.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 7, left: 7),
                  width: size.width * 0.45,
                  height: size.height * 0.135,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(image[index])),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    color: Colors.redAccent,
                  ),
                ),
                Text(str[index],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19))
              ],
            ),
            onTap: () {
              setState(() {
                i = index;
              });
            },
          );
        },
      ),
    );
  }

  Widget buildContentList() {
    return Container(
      padding: EdgeInsets.all(10),
      height: size.height * 0.84,
      child: FutureBuilder(
          future: arr[i],
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              Tesla_model t = snapshot.data;
              return buildList(t.articles);
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Widget buildList(List<Article> ls) {
    return ListView.builder(
      itemCount: ls.length,
      itemBuilder: (BuildContext context, int index) {
        Article p = ls[index];
        return GestureDetector(
          child: Column(
            children: [
              Card(
                elevation: 10,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Image.network(p.urlToImage == null || p.urlToImage == ''
                          ? Value().imagenull
                          : p.urlToImage),
                      Text(
                        p.title,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        p.content,
                        maxLines: 2,
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20)
            ],
          ),
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => Web(content: p.content)));
          },
        );
      },
    );
  }
}
