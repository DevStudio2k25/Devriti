import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class IconPreviewPage extends StatefulWidget {
  const IconPreviewPage({super.key});

  @override
  State<IconPreviewPage> createState() => _IconPreviewPageState();
}

class _IconPreviewPageState extends State<IconPreviewPage> {
  String? _customImagePath;
  final ImagePicker _picker = ImagePicker();
  double _iconSize = 60.0;

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _customImagePath = image.path;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking image: $e'),
            backgroundColor: Colors.red.shade400,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final iconAsset = _customImagePath ?? 'assets/images/logo_devriti.png';
    final samples = <_IconSample>[
      _IconSample('Android Circle', _Mask.circle, Icons.circle_outlined),
      _IconSample(
        'Android Rounded Square',
        _Mask.roundedSquare,
        Icons.crop_square,
      ),
      _IconSample('Android Square', _Mask.square, Icons.square_outlined),
      _IconSample('Android Squircle', _Mask.squircle, Icons.blur_circular),
      _IconSample('iOS Rounded (20%)', _Mask.iOSRounded, Icons.apple),
      _IconSample(
        'macOS Rounded (16%)',
        _Mask.macRounded,
        Icons.laptop_mac_outlined,
      ),
      _IconSample(
        'Notification Circle',
        _Mask.notification,
        Icons.notifications_none_outlined,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Icon Preview',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.photo_library_outlined,
              color: Colors.black87,
            ),
            onPressed: _pickImage,
          ),
          if (_customImagePath != null)
            IconButton(
              icon: const Icon(Icons.refresh, color: Colors.black87),
              onPressed: () {
                setState(() {
                  _customImagePath = null;
                });
              },
            ),
          const SizedBox(width: 4),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade200, width: 1),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.photo_size_select_small,
                  size: 16,
                  color: Colors.grey.shade600,
                ),
                Expanded(
                  child: SliderTheme(
                    data: SliderThemeData(
                      activeTrackColor: Colors.blue.shade400,
                      inactiveTrackColor: Colors.grey.shade300,
                      thumbColor: Colors.blue.shade500,
                      overlayColor: Colors.blue.withValues(alpha: 0.1),
                      trackHeight: 2,
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 6,
                      ),
                    ),
                    child: Slider(
                      value: _iconSize,
                      min: 40,
                      max: 100,
                      onChanged: (value) {
                        setState(() {
                          _iconSize = value;
                        });
                      },
                    ),
                  ),
                ),
                Icon(
                  Icons.photo_size_select_large,
                  size: 20,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 8),
                Text(
                  '${_iconSize.toInt()}',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: samples.length,
              itemBuilder: (_, index) {
                final s = samples[index];
                return _IconListItem(
                  title: s.label,
                  iconAsset: iconAsset,
                  mask: s.mask,
                  shapeIcon: s.icon,
                  iconSize: _iconSize,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _IconListItem extends StatelessWidget {
  final String title;
  final String iconAsset;
  final _Mask mask;
  final IconData shapeIcon;
  final double iconSize;

  const _IconListItem({
    required this.title,
    required this.iconAsset,
    required this.mask,
    required this.shapeIcon,
    required this.iconSize,
  });

  bool get _isCustomImage => iconAsset.startsWith('/');

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: iconSize,
            height: iconSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipPath(
              clipper: _ShapeClipper(mask),
              child: Container(
                color: Colors.white,
                child: _isCustomImage
                    ? Image.file(File(iconAsset), fit: BoxFit.cover)
                    : Image.asset(iconAsset, fit: BoxFit.cover),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade800,
              ),
            ),
          ),
          Icon(shapeIcon, size: 18, color: Colors.grey.shade400),
        ],
      ),
    );
  }
}

enum _Mask {
  circle,
  roundedSquare,
  square,
  squircle,
  teardrop,
  pebble,
  pill,
  hexagon,
  flower,
  iOSRounded,
  macRounded,
  notification,
}

class _ShapeClipper extends CustomClipper<Path> {
  final _Mask mask;
  const _ShapeClipper(this.mask);

  @override
  Path getClip(Size size) {
    switch (mask) {
      case _Mask.circle:
        return _circle(size);
      case _Mask.square:
        return _square(size);
      case _Mask.roundedSquare:
        return _roundedSquare(size, 0.24);
      case _Mask.squircle:
        return _squirclePath(size, n: 5.0, samples: 128);
      case _Mask.teardrop:
        return _teardropPath(size);
      case _Mask.pebble:
        return _pebblePath(size);
      case _Mask.pill:
        return _pillPath(size);
      case _Mask.hexagon:
        return _hexagonPath(size);
      case _Mask.flower:
        return _flowerPath(size);
      case _Mask.iOSRounded:
        return _roundedSquare(size, 0.20);
      case _Mask.macRounded:
        return _roundedSquare(size, 0.16);
      case _Mask.notification:
        return _insetCircle(size, inset: 0.10);
    }
  }

  Path _circle(Size s) =>
      Path()..addOval(Rect.fromLTWH(0, 0, s.width, s.height));
  Path _square(Size s) =>
      Path()..addRect(Rect.fromLTWH(0, 0, s.width, s.height));
  Path _roundedSquare(Size s, double frac) => Path()
    ..addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, s.width, s.height),
        Radius.circular(s.width * frac),
      ),
    );

  Path _insetCircle(Size s, {double inset = 0.10}) => Path()
    ..addOval(
      Rect.fromLTWH(
        s.width * inset,
        s.height * inset,
        s.width * (1 - 2 * inset),
        s.height * (1 - 2 * inset),
      ),
    );

  Path _squirclePath(Size s, {double n = 5.0, int samples = 128}) {
    final a = s.width / 2;
    final b = s.height / 2;
    final cx = a, cy = b;
    double pwr(double v) => math.pow(v.abs(), 2 / n).toDouble();
    final path = Path();
    for (int i = 0; i <= samples; i++) {
      final t = -math.pi + (2 * math.pi * i / samples);
      final ct = math.cos(t);
      final st = math.sin(t);
      final sx = ct >= 0 ? 1.0 : -1.0;
      final sy = st >= 0 ? 1.0 : -1.0;
      final x = a * pwr(ct) * sx;
      final y = b * pwr(st) * sy;
      final px = cx + x;
      final py = cy + y;
      if (i == 0) {
        path.moveTo(px, py);
      } else {
        path.lineTo(px, py);
      }
    }
    path.close();
    return path;
  }

  Path _teardropPath(Size s) {
    final w = s.width, h = s.height;
    final path = Path();
    path.moveTo(0.5 * w, 0.06 * h);
    path.cubicTo(0.88 * w, 0.02 * h, 1.02 * w, 0.38 * h, 0.82 * w, 0.62 * h);
    path.cubicTo(0.72 * w, 0.78 * h, 0.58 * w, 0.94 * h, 0.5 * w, 0.98 * h);
    path.cubicTo(0.42 * w, 0.94 * h, 0.28 * w, 0.78 * h, 0.18 * w, 0.62 * h);
    path.cubicTo(-0.02 * w, 0.38 * h, 0.12 * w, 0.02 * h, 0.5 * w, 0.06 * h);
    path.close();
    return path;
  }

  Path _pebblePath(Size s) {
    final w = s.width, h = s.height;
    final path = Path();
    path.moveTo(0.65 * w, 0.08 * h);
    path.cubicTo(0.95 * w, 0.20 * h, 1.02 * w, 0.55 * h, 0.78 * w, 0.75 * h);
    path.cubicTo(0.62 * w, 0.92 * h, 0.35 * w, 0.98 * h, 0.22 * w, 0.78 * h);
    path.cubicTo(0.05 * w, 0.55 * h, 0.10 * w, 0.25 * h, 0.33 * w, 0.18 * h);
    path.cubicTo(0.45 * w, 0.13 * h, 0.55 * w, 0.12 * h, 0.65 * w, 0.08 * h);
    path.close();
    return path;
  }

  Path _pillPath(Size s) {
    final w = s.width, h = s.height;
    final rect = Rect.fromLTWH(w * 0.10, h * 0.30, w * 0.80, h * 0.40);
    return Path()
      ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(h * 0.20)));
  }

  Path _hexagonPath(Size s) {
    final w = s.width, h = s.height;
    final path = Path();
    path.moveTo(0.25 * w, 0);
    path.lineTo(0.75 * w, 0);
    path.lineTo(w, 0.5 * h);
    path.lineTo(0.75 * w, h);
    path.lineTo(0.25 * w, h);
    path.lineTo(0, 0.5 * h);
    path.close();
    return path;
  }

  Path _flowerPath(Size s) {
    final w = s.width, h = s.height;
    final cx = w / 2, cy = h / 2;
    final r = 0.34 * math.min(w, h);
    final d = r * 0.75;
    final path = Path()
      ..addOval(Rect.fromCircle(center: Offset(cx, cy - d), radius: r))
      ..addOval(Rect.fromCircle(center: Offset(cx + d, cy), radius: r))
      ..addOval(Rect.fromCircle(center: Offset(cx, cy + d), radius: r))
      ..addOval(Rect.fromCircle(center: Offset(cx - d, cy), radius: r));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _IconSample {
  final String label;
  final _Mask mask;
  final IconData icon;
  _IconSample(this.label, this.mask, this.icon);
}
