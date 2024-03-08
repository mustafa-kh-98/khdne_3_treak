import 'package:flutter/material.dart';

class LoadingAnimation extends StatefulWidget {
  final double? height;
  final double? width;
  final double? radius;
  final BoxShape? shape;

  const LoadingAnimation({
    Key? key,
    this.shape = BoxShape.rectangle,
    this.radius,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  _LoadingAnimationState createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late Animation gradientPosition;
  late AnimationController loadingPostController;

  @override
  void initState() {
    loadingPostController = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);

    gradientPosition = Tween<double>(
      begin: -3,
      end: 10,
    ).animate(
      CurvedAnimation(parent: loadingPostController, curve: Curves.linear),
    )..addListener(() {
      setState(() {});
    });

    loadingPostController.repeat();
    //  loadingPostController.forward();

    super.initState();
  }

  @override
  void dispose() {
    loadingPostController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.radius ?? 0),
        shape: widget.shape!,
        gradient: LinearGradient(
          begin: Alignment(gradientPosition.value, 0),
          end: Alignment(-1, 0),
          colors: [Colors.black12, Colors.black26, Colors.black12],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}