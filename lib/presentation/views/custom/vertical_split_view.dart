import 'package:fluent_ui/fluent_ui.dart';

class VerticalSplitView extends StatefulWidget {
  const VerticalSplitView({
    super.key,
    required this.left,
    required this.right,
    this.ratio = 0.5,
    this.minWidthLeft = 300,
    this.minWidthRight = 300,
  })  : assert(ratio >= 0),
        assert(ratio <= 1);
  final Widget left;
  final Widget right;
  final double ratio;
  final double minWidthLeft;
  final double minWidthRight;

  @override
  State<VerticalSplitView> createState() => _VerticalSplitViewState();
}

class _VerticalSplitViewState extends State<VerticalSplitView> {
  final _dividerWidth = 16.0;

  //from 0-1
  double _ratio = 0.5;
  double _maxWidth = 0;

  double _widthLeft = 0;

  double _widthRight = 0;

  double _getWidthLeft(double ratio) => ratio * _maxWidth;

  double _getWidthRight(double ratio) => (1 - ratio) * _maxWidth;

  @override
  void initState() {
    super.initState();
    _ratio = widget.ratio;
  }

  void _dragUpdate(DragUpdateDetails details) {
    var ratio = _ratio + (details.delta.dx / _maxWidth);
    if (ratio > 1) {
      ratio = 1;
    } else if (ratio < 0.0) {
      ratio = 0.0;
    }
    final widthLeft = _getWidthLeft(ratio);
    final widthRight = _getWidthRight(ratio);
    if (widthLeft >= widget.minWidthLeft &&
        widthRight >= widget.minWidthRight) {
      setState(() {
        _widthLeft = widthLeft;
        _widthRight = widthRight;
        _ratio = ratio;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, BoxConstraints constraints) {
        assert(_ratio <= 1);
        assert(_ratio >= 0);
        if (_maxWidth == 0) {
          _maxWidth = constraints.maxWidth - _dividerWidth;
          _widthLeft = _getWidthLeft(_ratio);
          _widthRight = _getWidthRight(_ratio);
        } else if (_maxWidth != constraints.maxWidth) {
          _maxWidth = constraints.maxWidth - _dividerWidth;
          _widthLeft = _getWidthLeft(_ratio);
          _widthRight = _getWidthRight(_ratio);
        }

        return SizedBox(
          width: constraints.maxWidth,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: _widthLeft,
                child: widget.left,
              ),
              MouseRegion(
                cursor: SystemMouseCursors.resizeColumn,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onPanUpdate: _dragUpdate,
                  child: SizedBox(
                    width: _dividerWidth,
                    height: 70,
                    child: const RotationTransition(
                      turns: AlwaysStoppedAnimation(0.25),
                      child: Icon(FluentIcons.gripper_bar_horizontal),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: _widthRight,
                child: widget.right,
              ),
            ],
          ),
        );
      },
    );
  }
}
