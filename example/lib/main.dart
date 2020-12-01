import 'package:flutter/material.dart';
import 'package:xhb_swiper/xhb_swiper.dart';

void main() => runApp(MyApp());

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Swiper(
            [
              "https://yy0.tv.cmvideo.cn:8443/migutv/res/2019/10/17/59L11DV8GKF0.jpg",
              "https://yy0.tv.cmvideo.cn:8443/migutv/res/2019/09/30/59IHTLCINHHH.jpg",
              "https://yy1.tv.cmvideo.cn:8443/migutv-clt/pomsimage/1504/026/730/202003240715_CCTVNEWS_1500000_20200324_35370063_0_327_HSJ1080H.jpg"
            ],
            onTap: (value) {
              print(value);
            },
            loop: true,
            // width: 100,
          )
        ],
      ),
    );
  }
}
