# xhb_swiper

flutter 轮播图组件

![竖向滚动](https://media.giphy.com/media/vVgiJE5lhgeMpbLInK/giphy.gif)

![横向滚动](https://media.giphy.com/media/TQycRd0r0r1WW1QKwE/giphy.gif)

## 使用

1 Add this to your package's pubspec.yaml file:

```
dependencies:
  xhb_swiper: ^lastVersion
```

2 flutter pub get

3import 'package:xhb_swiper/xhb_swiper.dart';

## 提供的属性

![属性](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/7d8a3b23658142a9833a76489839b7ea~tplv-k3u1fbpfcp-watermark.image)

## demo

```
  List<String> _listes = [
    "https://yy0.tv.cmvideo.cn:8443/migutv/res/2019/10/17/59L11DV8GKF0.jpg",
    "https://yy0.tv.cmvideo.cn:8443/migutv/res/2019/09/30/59IHTLCINHHH.jpg",
    "https://yy1.tv.cmvideo.cn:8443/migutv-clt/pomsimage/1504/026/730/202003240715_CCTVNEWS_1500000_20200324_35370063_0_327_HSJ1080H.jpg"
  ];

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
```
