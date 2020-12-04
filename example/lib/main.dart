import 'package:flutter/material.dart';
import 'package:xhb_swiper/xhb_swiper.dart';

void main() => runApp(MyApp());

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ErrorWidget("flutter 自定义");
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
  List<String> _listes = [
    "https://yy0.tv.cmvideo.cn:8443/migutv/res/2019/10/17/59L11DV8GKF0.jpg",
    "https://yy0.tv.cmvideo.cn:8443/migutv/res/2019/09/30/59IHTLCINHHH.jpg",
    "https://yy1.tv.cmvideo.cn:8443/migutv-clt/pomsimage/1504/026/730/202003240715_CCTVNEWS_1500000_20200324_35370063_0_327_HSJ1080H.jpg"
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Swiper(
            _listes,
            onTap: (value) {
              print(value);
            },
            imagMargin: EdgeInsets.all(20),
            // indicatorBuilder: (context, index) {
            //   return Container(
            //     width: 100,
            //     height: 30,
            //     alignment: Alignment.center,
            //     color: Colors.white,
            //     child: Text(
            //       '$index/3',
            //       style: TextStyle(
            //         color: Colors.red,
            //         fontWeight: FontWeight.w700,
            //         fontSize: 20,
            //       ),
            //     ),
            //   );
            // },
            scrollDirection: Axis.horizontal,
            defaultColor: Colors.red,
            loop: true,
            autoplay: true,
            activeColor: Colors.yellow,
            indicatorSize: Size(10, 10),
            borderRadius: BorderRadius.circular(20),
          ),
          Swiper(
            _listes,
            onTap: (value) {
              print(value);
            },
            indicatorBuilder: (context, index) {
              return Container(
                width: 100,
                height: 30,
                alignment: Alignment.center,
                color: Colors.white,
                child: Text(
                  '${index + 1}/3',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              );
            },
          ),
          Swiper(
            _listes,
            borderRadius: BorderRadius.circular(10),
            onTap: (value) {
              print(value);
            },
            scrollDirection: Axis.vertical,
            imagMargin: EdgeInsets.all(30),
            itemdDecoration: BoxDecoration(
              border: Border.all(color: Colors.yellow, width: 10),
            ),
            defaultColor: Colors.red,
          ),
        ],
      ),
    );
  }
}
