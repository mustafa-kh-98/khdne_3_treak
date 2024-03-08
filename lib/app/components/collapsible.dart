import 'package:flutter/widgets.dart';

enum CollapsibleAxis {
  horizontal,
  vertical,
  both,
}

class Collapsible extends StatefulWidget {
  const Collapsible({
    Key? key,
    required this.child,
    required this.collapsed,
    required this.axis,
    this.alignment = Alignment.center,
    this.minWidthFactor = 0.0,
    this.minHeightFactor = 0.0,
    this.fade = false,
    this.minOpacity = 0.0,
    this.duration = const Duration(milliseconds: 240),
    this.curve = Curves.easeOut,
    this.clipBehavior = Clip.hardEdge,
    this.onComplete,
    bool maintainState = false,
    this.maintainAnimation = false,
  })  : assert(minWidthFactor >= 0.0 && minWidthFactor <= 1.0),
        assert(minHeightFactor >= 0.0 && minHeightFactor <= 1.0),
        assert(minOpacity >= 0.0 && minOpacity <= 1.0),
        maintainState = maintainState ||
            maintainAnimation ||
            (axis != CollapsibleAxis.vertical && minWidthFactor > 0.0) ||
            (axis != CollapsibleAxis.horizontal && minHeightFactor > 0.0),
        super(key: key);

  final Widget child;

  final bool collapsed;

  final CollapsibleAxis axis;

  final bool fade;

  final double minWidthFactor;

  final double minHeightFactor;

  final double minOpacity;

  final Duration duration;

  final AlignmentGeometry alignment;

  final Curve curve;

  final Clip clipBehavior;

  final VoidCallback? onComplete;

  final bool maintainState;

  final bool maintainAnimation;

  @override
  _CollapsibleState createState() => _CollapsibleState();
}

class _CollapsibleState extends State<Collapsible> {
  bool get _vertical =>
      widget.axis == CollapsibleAxis.vertical ||
      widget.axis == CollapsibleAxis.both;

  bool get _horizontal =>
      widget.axis == CollapsibleAxis.horizontal ||
      widget.axis == CollapsibleAxis.both;

  bool _maintainChild = true;

  @override
  void initState() {
    super.initState();

    if (!widget.maintainAnimation && widget.collapsed) {
      _maintainChild = false;
    }
  }

  @override
  void didUpdateWidget(Collapsible oldWidget) {
    if (!widget.collapsed) {
      _maintainChild = true;
    }

    super.didUpdateWidget(oldWidget);
  }

  void _toggleChild() {
    if (!widget.maintainState &&
        !widget.maintainAnimation &&
        widget.collapsed) {
      _maintainChild = false;
      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_maintainChild && !widget.maintainState) {
      return const SizedBox.shrink();
    }

    return TickerMode(
      enabled: _maintainChild,
      child: ClipRect(
        clipBehavior: widget.clipBehavior,
        child: AnimatedAlign(
          alignment: widget.alignment,
          heightFactor:
              _vertical && widget.collapsed ? widget.minHeightFactor : 1.0,
          widthFactor:
              _horizontal && widget.collapsed ? widget.minWidthFactor : 1.0,
          duration: widget.duration,
          curve: widget.curve,
          onEnd: () {
            if (widget.onComplete != null) widget.onComplete!();
            _toggleChild();
          },
          child: widget.fade
              ? AnimatedOpacity(
                  opacity: widget.collapsed ? widget.minOpacity : 1.0,
                  duration: widget.duration,
                  curve: widget.curve,
                  child: widget.child,
                )
              : widget.child,
        ),
      ),
    );
  }
}
