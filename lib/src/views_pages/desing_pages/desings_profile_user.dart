import 'package:app/src/providers/provider.dart';
import 'package:app/src/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

const Duration _kExpand = Duration(milliseconds: 200);

// Diseno para el botton navigation bar del menu principal
class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {

  @override
  Widget build(BuildContext context) {
    final _homeBloc = Provider.ofHomeBloc(context);
    return StreamBuilder(
      stream: _homeBloc.currentIndexPage,
      builder: (context, AsyncSnapshot<int> snapshot) {
        int? _currentIndex = 0;
        if (snapshot.hasData) {
          _currentIndex = snapshot.data;
        }
        return SalomonBottomBar(
          currentIndex: _currentIndex ?? 0,
          onTap: (i) => setState(() {_homeBloc.changeCurrentIndexPage(i);}),
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: const Icon(LineAwesomeIcons.home),
              title: const Text("Inicio"),
              selectedColor: Colors.purple,
            ),

            /// Likes
            SalomonBottomBarItem(
              icon: const Icon(LineAwesomeIcons.bell),
              title: const Text("Notificaciones"),
              selectedColor: Colors.pink,
            ),

            /// Search
            SalomonBottomBarItem(
              icon: const Icon(LineAwesomeIcons.folder_open),
              title: const Text("Servicio"),
              selectedColor: Colors.orange,
            ),

            /// Profile
            SalomonBottomBarItem(
              icon: const Icon(LineAwesomeIcons.user_circle),
              title: const Text("Perfil"),
              selectedColor: Colors.teal,
            ),
          ],
        );
      },
    );
  }
}

// Diseno para los card de las opciones 
class ExpansionCard extends StatefulWidget {
  
  const ExpansionCard({
    Key? key,
    this.leading,
    required this.title,
    this.gif,
    this.backgroundColor,
    this.onExpansionChanged,
    this.children = const <Widget>[],
    this.trailing,
    this.initiallyExpanded = false,
    this.color,
    this.expansionArrowColor,
    this.topMargin = 20,
  }) : super(key: key);

  final String? gif;
  final Widget? leading;
  final Widget title;
  final ValueChanged<bool>? onExpansionChanged;
  final List<Widget> children;
  final Color? backgroundColor;
  final Widget? trailing;
  final bool initiallyExpanded;
  final Color? color;
  final Color? expansionArrowColor;
  final double topMargin;

  @override
  _ExpansionTileState createState() => _ExpansionTileState();
}

class _ExpansionTileState extends State<ExpansionCard>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeOutTween =
      CurveTween(curve: Curves.easeOut);
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  final ColorTween _borderColorTween = ColorTween();
  final ColorTween _headerColorTween = ColorTween();
  final ColorTween _iconColorTween = ColorTween();
  final ColorTween _backgroundColorTween = ColorTween();

  late AnimationController _controller;
  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;
  late Animation<Color?> _headerColor;
  late Animation<Color?> _iconColor;
  late Animation<Color?> _backgroundColor;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _heightFactor = _controller.drive(_easeInTween);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
    _headerColor = _controller.drive(_headerColorTween.chain(_easeInTween));
    _iconColor = _controller.drive(_iconColorTween.chain(_easeInTween));
    _backgroundColor =
        _controller.drive(_backgroundColorTween.chain(_easeOutTween));

    _isExpanded =
        PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {
          });
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
    if (widget.onExpansionChanged != null) widget.onExpansionChanged!(_isExpanded);
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    const Color borderSideColor = Colors.transparent; // _borderColor.value ??

    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: _backgroundColor.value ?? Colors.transparent,
            border: const Border(
              top: BorderSide(color: borderSideColor),
              bottom: BorderSide(color: borderSideColor),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTileTheme.merge(
                  iconColor: _iconColor.value,
                  textColor: _headerColor.value,
                  child: Container(
                    margin: EdgeInsets.only(top: widget.topMargin),
                    child: ListTile(
                      onTap: _handleTap,
                      leading: widget.leading,
                      title: widget.title,
                      trailing: widget.trailing ??
                          RotationTransition(
                            turns: _iconTurns,
                            child: Icon(
                              Icons.expand_more,
                              color: widget.expansionArrowColor,
                            ),
                          ),
                    ),
                  )),
              ClipRect(
                child: Align(
                  heightFactor: _heightFactor.value,
                  child: child,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  void didChangeDependencies() {
    final ThemeData theme = Theme.of(context);
    _borderColorTween.end = theme.dividerColor;
    _headerColorTween
      ..begin = Colors.white
      ..end = widget.color ?? const Color(0xff60c9df);
    _iconColorTween
      ..begin = Colors.white
      ..end = widget.color ?? const Color(0xff60c9df);
    _backgroundColorTween.end = widget.backgroundColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: closed ? null : Column(children: widget.children),
    );
  }
}

// Desing of button in card, loguot.
class ButtonProfile extends StatelessWidget {

  final Function()? onPressed;
  final String title;
  final IconData icon;

  const ButtonProfile({Key? key, required this.onPressed, required this.title, required this.icon}) : super(key: key);

 @override
 Widget build(BuildContext context) {
   final responsive = Responsive(context);
  return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(const Color.fromARGB(97, 184, 66, 66)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: const BorderSide(color: Color.fromARGB(129, 146, 63, 57))))),
      child: Row(
        children: [
          FaIcon(
            icon,
            color: Colors.white,
          ),
          SizedBox(width: responsive.wp(2),),
          Text(title,
              style: TextStyle(
                  fontFamily: 'Comfortaa-Light',
                  fontSize: responsive.dp(2),
                  color: Colors.white)),
        ],
      ),
    );
 }
}

// Circle information
class CircleInfoUser extends StatelessWidget {

  final String data, text;
  final IconData icon;

  const CircleInfoUser({Key? key, required this.data, required this.text, required this.icon}) : super(key: key);

 @override
 Widget build(BuildContext context) {
   final responsive = Responsive(context);
  return Stack(
    children: [
      Container(
          width: 200,
          height: responsive.wp(2.7)  * 9.5,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(50), bottomLeft: Radius.circular(50) ),
              gradient: LinearGradient(
                    colors: <Color>[
                  Color.fromARGB(255, 104, 0, 40),
                Color.fromARGB(255, 197, 100, 100),
                ],
                    begin: FractionalOffset.centerRight,
                    end: FractionalOffset.centerLeft)
              ),
        ),
      Container(
          width: responsive.wp(2.7)  * 9.5,
          height: responsive.wp(2.7)  * 9.5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: Color.fromARGB(202, 104, 0, 40)
              ),
          child: Padding(
            padding: EdgeInsets.all(responsive.dp(1)),
            child: Column(
              children: [
                Icon(icon,color: Colors.white, size: responsive.dp(2.2),),
                const Divider(
                  thickness: 1,
                  color: Color.fromARGB(28, 255, 255, 255),
                ),
                Text(data, style: TextStyle(color: const Color.fromARGB(213, 255, 255, 255), fontSize: responsive.dp(1.5))),
                const Divider(
                  thickness: 1,
                  color: Color.fromARGB(28, 255, 255, 255),
                ),
                Text(text, style: TextStyle(color: const Color.fromARGB(213, 255, 255, 255), fontSize: responsive.dp(1.1)))
              ],
            ),
          ),
        ),

        
    ],
  );
 }
}

// Desing in screen profile user
class DesingContainerProfileUser extends StatelessWidget {
  const DesingContainerProfileUser({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final responsive = Responsive(context);
    
    double x = 0.4;
    double y = 0.2;
    double z = 0.4;
    
    return Column(
      children: [
        Container(
          transform: Matrix4(
            1,
            0,
            0,
            0,
            0,
            1,
            0,
            0,
            0,
            0,
            1,
            0,
            0,
            0,
            0,
            1,
          )
            ..rotateX(x)
            ..rotateY(y)
            ..rotateZ(z),
          height: responsive.height * 0.4,
          width: double.infinity,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(100),
                  topRight: Radius.circular(100)),
              gradient: LinearGradient(colors: <Color>[
                Color.fromARGB(255, 104, 0, 40),
                Color.fromARGB(255, 197, 100, 100),
              ])),
        ),
        SizedBox(height: responsive.hp(15),)
      ],
    );
  }
}