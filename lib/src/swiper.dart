import 'dart:async';

import 'package:flutter/material.dart';

class Swiper extends StatefulWidget {
  final List<String> images;
  final double height;
  final double width;

  ///点击回调
  final ValueChanged<int> onTap;

  /// 切换动画
  final Curve curve;

  ///是否循环播放
  final bool loop;

  /// 是否显示指示器
  final bool showIndicator;

  /// 是否自动轮播
  final bool autoplay;

  ///指示器激活的颜色  默认蓝色
  final Color activeColor;

  /// 指示器默认的颜色 默认白色
  final Color defaultColor;

  ///轮播图滚动方向 默认水平
  final Axis scrollDirection;

  ///图片展示样式
  final BoxFit imgFit;

  ///指示器的大小
  final Size indicatorSize;

  ///图片圆角大小
  final BorderRadius borderRadius;
  // final Widget Function(bool active) indicatorBuilder;

  ///自定义单个指示器
  final IndexedWidgetBuilder indicatorBuilder;

  /// 图片padding
  ///
  final EdgeInsetsGeometry imagePadding;

  Swiper(this.images,
      {this.height = 200,
      this.width,
      this.onTap,
      this.curve = Curves.linear,
      this.loop = true,
      this.activeColor = Colors.blue,
      this.defaultColor = Colors.white,
      this.showIndicator = true,
      this.autoplay = true,
      this.scrollDirection = Axis.horizontal,
      this.imgFit = BoxFit.cover,
      this.indicatorSize = const Size(8, 8),
      this.borderRadius,
      this.indicatorBuilder,
      this.imagePadding
      // this.indicatorBuilder = (active) => active ? Placeholder() : 'xx',
      })
      : assert(images != null);

  @override
  _SwiperState createState() => _SwiperState();
}

class _SwiperState extends State<Swiper> {
  PageController _pageController;
  int _currentIndex = 0;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _currentIndex,
    );
    _initTimer();
    // print(widget.imagePadding.vertical);
    // print(widget.imagePadding.collapsedSize.height);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: widget.scrollDirection == Axis.horizontal
          ? Alignment.bottomCenter
          : Alignment.centerRight,
      children: [
        _buildPageView(),
        _buildIndicator(),
      ],
    );
  }

  Widget _buildPageView() {
    var length = widget.images.length;
    return Container(
      height: widget.height,
      width: widget.width,
      child: PageView.builder(
        scrollDirection: widget.scrollDirection,
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
          _changePage();
        },
        itemBuilder: (context, index) {
          return GestureDetector(
            onPanDown: (details) {
              _cancelTimer();
            },
            onTap: () => widget.onTap(index % length),
            child: Container(
              padding: widget.imagePadding ?? EdgeInsets.all(0),
              child: ClipRRect(
                borderRadius: widget.borderRadius ?? BorderRadius.circular(0),
                child: Image(
                  image: NetworkImage(widget.images[index % length]),
                  fit: widget.imgFit,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildIndicator() {
    if (!widget.showIndicator) return SizedBox.shrink();

    if (widget.indicatorBuilder != null) {
      return widget.indicatorBuilder(
          context, _currentIndex % widget.images.length);
    }

    return _buildDefaultIndicator();
  }

  Widget _buildDefaultIndicator() {
    var length = widget.images.length;
    var _width = widget.indicatorSize.width;
    var _height = widget.indicatorSize.height;

    return Positioned(
      bottom: widget.scrollDirection == Axis?.horizontal ? 10 : null,
      right: widget.scrollDirection == Axis?.vertical ? 10 : null,
      child: widget.scrollDirection == Axis.horizontal
          ? Row(
              children: widget.images.map(
                (e) {
                  return GestureDetector(
                      onTap: () => _ontap(e),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: ClipOval(
                          child: Container(
                            width: _width,
                            height: _height,
                            color: e == widget.images[_currentIndex % length]
                                ? widget.activeColor
                                : widget.defaultColor,
                          ),
                        ),
                      ));
                },
              ).toList(),
            )
          : Column(
              children: widget.images.map(
                (e) {
                  return GestureDetector(
                    onTap: () => _ontap(e),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: ClipOval(
                        child: Container(
                          width: _width,
                          height: _height,
                          color: e == widget.images[_currentIndex % length]
                              ? widget.activeColor
                              : widget.defaultColor,
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
    );
  }

  _changePage() {
    Timer(Duration(milliseconds: 300), () {
      _pageController.jumpToPage(_currentIndex);
    });
  }

  // 点击图片回调
  _ontap(e) {
    var index = widget.images.indexOf(e);
    _currentIndex = index;
    goToIndex();
  }

  // 设置轮播定时器
  _initTimer() {
    if (_timer == null) {
      if (widget.autoplay != true) return;
      _timer = Timer.periodic(
        Duration(seconds: 3),
        (t) {
          var length = widget.images.length;
          if (widget.loop != true && (_currentIndex % length == length - 1)) {
            return _timer = null;
          }
          _currentIndex++;
          goToIndex();
        },
      );
    }
  }

  // 滚动到指定页面
  void goToIndex() {
    _pageController.animateToPage(
      _currentIndex,
      duration: Duration(milliseconds: 300),
      curve: widget.curve,
    );
  }

  // 手动滑动的时候取消定时器
  _cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
      _initTimer();
    }
  }
}
