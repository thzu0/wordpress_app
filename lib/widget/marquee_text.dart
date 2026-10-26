import 'package:flutter/material.dart';

/// متنی که اگه از عرض جا بیشتر باشه، به جای «...» مثل تابلو اعلانات
/// آروم اسکرول میشه. اگه جا بشه، عادی نمایش داده میشه.
class MarqueeText extends StatefulWidget {
  const MarqueeText(
    this.text, {
    super.key,
    this.style,
    this.textAlign = TextAlign.start,
    this.velocity = 30,
    this.pause = const Duration(seconds: 1),
  });

  final String text;
  final TextStyle? style;
  final TextAlign textAlign;

  /// سرعت حرکت (پیکسل بر ثانیه)
  final double velocity;

  /// مکث اول و آخر هر دور
  final Duration pause;

  @override
  State<MarqueeText> createState() => _MarqueeTextState();
}

class _MarqueeTextState extends State<MarqueeText> {
  final ScrollController _controller = ScrollController();
  bool _looping = false;
  int _generation = 0;

  @override
  void didUpdateWidget(covariant MarqueeText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _generation++;
      _looping = false;
      if (_controller.hasClients) _controller.jumpTo(0);
    }
  }

  @override
  void dispose() {
    _generation++;
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loop() async {
    if (_looping) return;
    _looping = true;
    final gen = _generation;
    bool alive() => mounted && gen == _generation && _controller.hasClients;

    while (alive()) {
      await Future.delayed(widget.pause);
      if (!alive()) break;

      final max = _controller.position.maxScrollExtent;
      if (max <= 0) break;

      await _controller.animateTo(
        max,
        duration: Duration(
          milliseconds: (max / widget.velocity * 1000).round(),
        ),
        curve: Curves.linear,
      );
      if (!alive()) break;

      await Future.delayed(widget.pause);
      if (!alive()) break;

      _controller.jumpTo(0);
    }
    if (gen == _generation) _looping = false;
  }

  @override
  Widget build(BuildContext context) {
    final style = DefaultTextStyle.of(context).style.merge(widget.style);
    final direction = Directionality.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final painter = TextPainter(
          text: TextSpan(text: widget.text, style: style),
          textDirection: direction,
          maxLines: 1,
        )..layout();
        final textWidth = painter.width;
        painter.dispose();

        final overflows = textWidth > constraints.maxWidth;

        if (!overflows) {
          return Text(
            widget.text,
            style: widget.style,
            maxLines: 1,
            textAlign: widget.textAlign,
          );
        }

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) _loop();
        });

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: _controller,
          physics: const NeverScrollableScrollPhysics(),
          child: Text(
            widget.text,
            style: widget.style,
            maxLines: 1,
            softWrap: false,
          ),
        );
      },
    );
  }
}
