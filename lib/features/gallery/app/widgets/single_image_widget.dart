import 'package:flutter/material.dart';
import 'package:gelato_gallery/features/gallery/domain/entities/photo.dart';

class SingleImageWidget extends StatefulWidget {
  final Photo photo;
  const SingleImageWidget({
    Key? key,
    required this.photo,
  }) : super(key: key);

  @override
  _SingleImageWidgetState createState() => _SingleImageWidgetState();
}

class _SingleImageWidgetState extends State<SingleImageWidget>
    with SingleTickerProviderStateMixin {
  late TransformationController zoomController; //Controller for zooming

  late Animation<Matrix4> _animationReset; //reset controller values

  late AnimationController
      _controllerReset; //Controller for controling the zoom animation

  ///reset the animation to default state
  void _onAnimateReset() {
    zoomController.value = _animationReset.value;
    if (!_controllerReset.isAnimating) {
      _animationReset.removeListener(_onAnimateReset);
      // _animationReset = null;
      _controllerReset.reset();
    }
  }

  //resets the zoom controller to default state
  void _animateResetInitialize() {
    _controllerReset.reset();
    _animationReset = Matrix4Tween(
      begin: zoomController.value,
      end: Matrix4.identity(),
    ).animate(_controllerReset);
    _animationReset.addListener(_onAnimateReset);
    _controllerReset.forward();
  }

  @override
  void initState() {
    super.initState();
    zoomController = TransformationController();

    _controllerReset = AnimationController(
      vsync: this,
      duration:
          const Duration(milliseconds: 400), //duration of zoomout animation
    );
  }

  @override
  void dispose() {
    zoomController.dispose();
    _controllerReset.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _animateResetInitialize, //on double tap reset zoom state
      child: InteractiveViewer(
        transformationController:
            zoomController, //registering widget to controller
        child: Image.network(widget.photo.imageUrl),
      ),
    );
  }
}
