import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;
  const CustomButton({
    Key key,
    this.text,
    this.onTap, this.color,
  }) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> with SingleTickerProviderStateMixin {
  double _scale;
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.2,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return GestureDetector(
      onTap: () async {
        await Future.delayed(const Duration(milliseconds: 500));
        widget.onTap();
      },
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      child: Transform.scale(
        scale: _scale,
        child: _animatedButtonUI,
      ),
    );
  }

  Widget get _animatedButtonUI => Row(
        children: [
          Expanded(
            child: Card(
              shadowColor: Theme.of(context).textTheme.headline6.color,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: widget.color==null?Colors.white:Colors.green,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    widget.text,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: widget.color==null?Colors.black:Colors.white,
                          letterSpacing: 0.6,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
}

class CustomButtonBorder extends StatefulWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;
  CustomButtonBorder({
    Key key,
    this.text,
    this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  _CustomButtonBorderState createState() => _CustomButtonBorderState();
}

class _CustomButtonBorderState extends State<CustomButtonBorder> with SingleTickerProviderStateMixin {
  double _scale;
  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      child: Transform.scale(
        scale: _scale,
        child: _animatedButtonUI,
      ),
    );
  }

  Widget get _animatedButtonUI => Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Color(0xffA50D12),
                  border: Border.all(
                    color: Theme.of(context).textTheme.headline6.color,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      widget.icon,
                      color: Theme.of(context).textTheme.headline6.color,
                      size: 22,
                    ),
                    widget.icon==null?SizedBox(
                      width: 2,
                    ):Container(),
                    Text(
                      widget.text,
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            letterSpacing: 0.6,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
