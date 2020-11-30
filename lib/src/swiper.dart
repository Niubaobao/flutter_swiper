import 'dart:async';

import 'package:flutter/material.dart';

class Swiper extends StatefulWidget {
  final List<String> images;
  final double height;
  final double width;
  final ValueChanged<int> onTap;
  final Curve curve;

  Swiper(
    this.images, {
    this.height = 200,
    this.width,
    this.onTap,
    this.curve = Curves.linear,
  }) : assert(images != null);
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
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
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
      child: PageView.builder(
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
            onTap: () {
              widget.onTap(index % length);
              print('_buildPageView');
            },
            child: Image(
              image: NetworkImage(widget.images[index % length]),
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }

  Widget _buildIndicator() {
    var length = widget.images.length;
    return Positioned(
      bottom: 10,
      child: Row(
        children: widget.images.map(
          (e) {
            return GestureDetector(
              onTap: () {
                var index = widget.images.indexOf(e);
                _currentIndex = index;
                goToIndex();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: ClipOval(
                  child: Container(
                    width: 8,
                    height: 8,
                    color: e == widget.images[_currentIndex % length]
                        ? Colors.red
                        : Colors.white,
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

  // 设置轮播定时器
  _initTimer() {
    if (_timer == null) {
      _timer = Timer.periodic(
        Duration(seconds: 3),
        (t) {
          _currentIndex++;
          goToIndex();
        },
      );
    }
  }

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
