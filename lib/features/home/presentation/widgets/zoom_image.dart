import 'package:flutter/material.dart';

class ZoomableImage extends StatefulWidget {
  final String imagePath;
  const ZoomableImage({super.key, required this.imagePath});

  @override
  State<ZoomableImage> createState() => _ZoomableImageState();
}

class _ZoomableImageState extends State<ZoomableImage> {
  double _scale = 1.0;
  double _initialScale = 1.0;
  Offset _position = Offset.zero;
  Offset _initialFocalPoint = Offset.zero;
  Offset _initialPosition = Offset.zero;
  OverlayEntry? _overlayEntry;

  final double _minScale = 1.0;
  final double _maxScale = 3.0;

  void _showOverlay(BuildContext context) {
    final overlay = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: _removeOverlay,
        onScaleStart: (details) {
          _initialScale = _scale;
          _initialFocalPoint = details.focalPoint;
          _initialPosition = _position;
        },
        onScaleUpdate: (details) {
          _scale = (_initialScale * details.scale).clamp(_minScale, _maxScale);
          _position = _initialPosition + (details.focalPoint - _initialFocalPoint);
          _overlayEntry?.markNeedsBuild();
        },
        child: Stack(
          children: [
            Container(color: Colors.black.withOpacity(0.8)),
            Center(
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..translate(_position.dx, _position.dy)
                  ..scale(_scale),
                child: Image.asset(widget.imagePath, fit: BoxFit.contain),
              ),
            ),
          ],
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _scale = 1.0;
      _position = Offset.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showOverlay(context),
      child: Container(
        width: 330,
        height: 300,
        margin: EdgeInsets.only(left: 28, right: 28),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.5),
          image: DecorationImage(
            image: AssetImage(widget.imagePath),
            fit: BoxFit.cover,
          )
        ),
      ),
    );
  }
}
