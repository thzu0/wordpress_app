import 'package:flutter/material.dart';

/// متنی که اگه از عرض جا بیشتر باشه، مثل تابلوهای بالای مغازه‌ها
/// بی‌وقفه حرکت می‌کنه: از یه طرف میره و با یه فاصله از طرف دیگه برمی‌گرده.
/// اگه متن جا بشه، ثابت و عادی نمایش داده میشه.
class MarqueeText extends StatefulWidget {
  const MarqueeText(
    this.text, {
    super.key,
    this.style,
    this.textAlign = TextAlign.start,
    this.velocity = 40,
    this.gap = 40,
    this.startDelay = const Duration(milliseconds: 800),
  });

  final String text;
  final TextStyle? style;
  final TextAlign textAlign;

  /// سرعت حرکت (پیکسل بر ثانیه)
  final double velocity;

  /// فاصله بین آخر متن و شروع دوباره‌ی اون
  final double gap;

  /// مکث کوتاه قبل از شروع حرکت (تا اول بشه متن رو خوند)
  final Duration startDelay;

  @override
  State<MarqueeText> createState() => _MarqueeTextState();
}

class _MarqueeTextState extends State<MarqueeText> {
  final ScrollController _controller = ScrollController();
  bool _looping = false;
  int _generation = 0;
  double _textWidth = 0;

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

    await Future.delayed(widget.startDelay);

    while (alive()) {
      // یه دور کامل = عرض متن + فاصله؛ بعدش کپی دوم دقیقاً جای اولی میشه
      final cycle = _textWidth + widget.gap;
      await _controller.animateTo(
        cycle,
        duration: Duration(
          milliseconds: (cycle / widget.velocity * 1000).round(),
        ),
        curve: Curves.linear,
      );
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
        _textWidth = painter.width;
        painter.dispose();

        final overflows = _textWidth > constraints.maxWidth;

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

        final label = Text(
          widget.text,
          style: widget.style,
          maxLines: 1,
          softWrap: false,
        );

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: _controller,
          physics: const NeverScrollableScrollPhysics(),
          child: Row(
            children: [
              label,
              SizedBox(width: widget.gap),
              label, // کپی دوم که از اونور وارد میشه
            ],
          ),
        );
      },
    );
  }
}
