import 'package:app/src/utils/pref_users.dart';
import 'package:flutter/material.dart';
import 'package:app/src/blocs/register_bloc.dart';
import 'package:app/src/providers/provider.dart';
import 'package:app/src/utils/consts_utils.dart';
import 'package:app/src/utils/countrys.dart' as list;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

String _opcionSeleccionada = 'Seleccionar pais';
final pref = PreferenciasUsuario();

// Este es el diseno de los botones especificos
class DesingButtonOutline extends StatefulWidget {
  final String texto;
  final String font;
  final Function() onPress;

  const DesingButtonOutline(this.onPress, this.texto, this.font, {Key? key})
      : super(key: key);

  @override
  State<DesingButtonOutline> createState() => _DesingButtonOutlineState();
}

class _DesingButtonOutlineState extends State<DesingButtonOutline> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: widget.onPress,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(constante.colorSecundario),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: const BorderSide(color: Colors.red)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.texto,
              style: TextStyle(
                  fontFamily: widget.font,
                  fontSize: 17.0,
                  color: Colors.white)),
          const SizedBox(
            width: 10,
          ),
          const FaIcon(
            FontAwesomeIcons.angleDoubleRight,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}

// Este es el diseno de los botones generales
class DesingButtonElevation extends StatefulWidget {
  final Function()? onPress;
  final String title;
  final String font;
  final double tama;
  final double padding;

  const DesingButtonElevation(
      this.onPress, this.title, this.font, this.tama, this.padding,
      {Key? key})
      : super(key: key);

  @override
  State<DesingButtonElevation> createState() => _DesingButtonElevationState();
}

class _DesingButtonElevationState extends State<DesingButtonElevation> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: widget.onPress,
          child: Text(widget.title),
          style: ElevatedButton.styleFrom(
            primary: constante.colorSecundario,
            textStyle:
                TextStyle(fontFamily: widget.font, fontSize: widget.tama),
            padding: EdgeInsets.all(widget.padding),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 5.0,
          ),
        ));
  }
}

// Este es el diseno para las cajas de texto, especialmente para formularios
class DesingTextField extends StatefulWidget {
  final String hint;
  final String label;
  final String? errorText;
  final IconData iconoExterior;
  final Widget iconoInterior;
  final Color colorIcono;
  final Color colorCicle;
  final Function(String) onChange;
  final Function() onTap;
  final TextInputType textType;
  final String font;
  final bool oculto;

  const DesingTextField(
      this.hint,
      this.label,
      this.errorText,
      this.iconoExterior,
      this.iconoInterior,
      this.colorIcono,
      this.colorCicle,
      this.onChange,
      this.onTap,
      this.textType,
      this.font,
      this.oculto,
      {Key? key})
      : super(key: key);

  @override
  State<DesingTextField> createState() => _DesingTextFieldState();
}

class _DesingTextFieldState extends State<DesingTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: widget.onTap,
      obscureText: widget.oculto,
      keyboardType: widget.textType,
      style: TextStyle(fontFamily: widget.font),
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: widget.hint,
          labelText: widget.label,
          errorText: widget.errorText,
          suffixIcon: widget.iconoInterior,
          icon: CircleAvatar(
            backgroundColor: constante.colorPrincipal,
            child: FaIcon(
              widget.iconoExterior,
              color: widget.colorIcono,
            ),
          )),
      onChanged: widget.onChange,
    );
  }
}

// Este es el diseno para el datapicker
class DesingDatepicker extends StatefulWidget {
  final String hint;
  final String label;
  final IconData iconoExterior;
  final Widget iconoInterior;
  final Color colorIcono;
  final Color colorCicle;
  final Function(String) onChange;
  final Function() onTap;
  final TextInputType textType;
  final String font;

  const DesingDatepicker(
      this.hint,
      this.label,
      this.iconoExterior,
      this.iconoInterior,
      this.colorIcono,
      this.colorCicle,
      this.onChange,
      this.onTap,
      this.textType,
      this.font,
      {Key? key})
      : super(key: key);

  @override
  State<DesingDatepicker> createState() => _DesingDatePickerState();
}

class _DesingDatePickerState extends State<DesingDatepicker> {
  String fecha = '';
  TextEditingController controllerText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final registerBloc = Provider.ofRegisterBloc(context);

    return TextField(
      enableInteractiveSelection: false,
      onTap: () => _onTapDatePicker(registerBloc),
      controller: controllerText,
      style: TextStyle(fontFamily: widget.font),
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: widget.hint,
          labelText: widget.label,
          suffixIcon: widget.iconoInterior,
          icon: CircleAvatar(
            backgroundColor: constante.colorPrincipal,
            child: FaIcon(
              widget.iconoExterior,
              color: widget.colorIcono,
            ),
          )),
      onChanged: widget.onChange,
    );
  }

  _onTapDatePicker(RegisterBloc bloc) {
    FocusScope.of(context).requestFocus(FocusNode());
    _selectDate(bloc);
  }

  void _selectDate(RegisterBloc bloc) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1930),
        lastDate: DateTime(2050),
        locale: const Locale('es', 'ES'));

    if (picked != null) {
      setState(() {
        fecha = picked.toString();
        String fechaFin = fecha.substring(0, 10);
        controllerText.text = fechaFin;
        bloc.changeFechaNacimientoReg(fechaFin);

        //print(fechaFin);
      });
    }
  }
}

// Este diseno es para la lista desplegable
class DesingDropdown extends StatefulWidget {
  const DesingDropdown({Key? key}) : super(key: key);

  @override
  _DesingDropdownState createState() => _DesingDropdownState();
}

class _DesingDropdownState extends State<DesingDropdown> {
  @override
  Widget build(BuildContext context) {
    final blocR = Provider.ofRegisterBloc(context);
    return _crearDropdown(blocR);
  }

  List<DropdownMenuItem<Object>>? _getOpcionesDropdown() {
    List<DropdownMenuItem<Object>>? lista = [];

    for (var element in list.paises) {
      lista.add(DropdownMenuItem(
        child: Text(element),
        value: element,
      ));
    }
    return lista;
  }

  Widget _crearDropdown(RegisterBloc bloc) {
    return StreamBuilder(
      stream: bloc.countryStreamReg,
      builder: (context, snapshot) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              CircleAvatar(
                  backgroundColor: constante.colorPrincipal,
                  child: const Icon(
                    Icons.person_pin_circle,
                    color: Colors.white,
                  )),
              const SizedBox(
                width: 22.0,
              ),
              DropdownButton(
                  items: _getOpcionesDropdown(),
                  value: _opcionSeleccionada,
                  style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.black54,
                      fontFamily: 'Comfortaa-Light'),
                  focusColor: Colors.deepPurple[200],
                  onChanged: (v) {
                    bloc.changeCountryReg(v.toString());
                    _opcionSeleccionada = bloc.getCountryBlocReg;
                    //print(bloc.getCountryBlocReg);
                  }),
            ],
          ),
        );
      },
    );
  }
}

//Este es el diseno para los botones de texto
class DesingTextButton extends StatefulWidget {
  final String texto;
  final String font;
  final Function() onPress;

  const DesingTextButton(this.texto, this.font, this.onPress, {Key? key})
      : super(key: key);

  @override
  State<DesingTextButton> createState() => _DesingTextButtonState();
}

class _DesingTextButtonState extends State<DesingTextButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPress,
      child: Text(widget.texto,
          style: TextStyle(
              fontFamily: widget.font, fontSize: 15.0, color: Colors.black54)),
    );
  }
}

// Este es el diseno de recordar contrasena que esta ubicado en el login
class RecordarPass extends StatefulWidget {
  const RecordarPass({Key? key}) : super(key: key);

  @override
  RecordarPassState createState() => RecordarPassState();
}

class RecordarPassState extends State<RecordarPass> {
  //Se debe pasar por manejo de estado
  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.white;
      }
      return Colors.green;
    }

    return Container(
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            constante.recordarContra,
            style:
                const TextStyle(fontFamily: 'Comfortaa-Light', fontSize: 15.0),
          ),
          Checkbox(
            checkColor: Colors.white,
            fillColor: MaterialStateProperty.resolveWith(getColor),
            overlayColor: MaterialStateProperty.resolveWith(getColor),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            value: pref.rememberUser,
            onChanged: (bool? value) {
              setState(() {
                _addPrefs(value);
                isChecked = value!;

                //print(pref.rememberUser);
              });
            },
          )
        ],
      ),
    );
  }

  void _addPrefs(bool? valor) async {
    pref.rememberUser = valor!;
  }
}

Widget crearFondo(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final fondoMorado = Container(
    height: size.height * 0.5,
    width: double.infinity,
    decoration: const BoxDecoration(
        gradient: LinearGradient(colors: <Color>[
      Color.fromRGBO(144, 12, 63, 1.0),
      Color.fromRGBO(239, 154, 154, 1.0),
    ])),
  );

  final circulo = Container(
    width: 100.0,
    height: 100.0,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: const Color.fromRGBO(255, 255, 255, 0.05)),
  );

  return Stack(
    children: <Widget>[
      fondoMorado,
      Positioned(top: 90.0, left: 30.0, child: circulo),
      Positioned(top: -40.0, right: -30.0, child: circulo),
      Positioned(bottom: -50.0, right: -10.0, child: circulo),
      Positioned(top: 90.0, left: 30.0, child: circulo),
      Positioned(top: -40.0, right: -30.0, child: circulo),
      Positioned(bottom: -50.0, right: -10.0, child: circulo),
      Positioned(top: 150.0, right: 10.0, child: circulo),
      Positioned(bottom: 120.0, right: 20.0, child: circulo),
      Positioned(bottom: -50.0, left: -20.0, child: circulo),
      Container(
        padding: const EdgeInsets.only(top: 80.0),
        child: Column(
          children: const [
            Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0),
            SizedBox(
              height: 10.0,
              width: double.infinity,
            ),
            Text(
              "Iniciar Sesion",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontFamily: 'Comfortaa-Bold'),
            )
          ],
        ),
      )
    ],
  );
}

Widget crearFondoForgot(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final fondoMorado = Container(
    height: size.height * 1,
    width: double.infinity,
    decoration: const BoxDecoration(
        gradient: LinearGradient(colors: <Color>[
      Color.fromRGBO(144, 12, 63, 1.0),
      Color.fromRGBO(239, 154, 154, 1.0),
    ])),
  );

  final circulo = Container(
    width: 100.0,
    height: 100.0,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: const Color.fromRGBO(255, 255, 255, 0.05)),
  );

  return Stack(
    children: <Widget>[
      fondoMorado,
      Positioned(top: 90.0, left: 30.0, child: circulo),
      Positioned(top: -40.0, right: -30.0, child: circulo),
      Positioned(bottom: -50.0, right: -10.0, child: circulo),
      Positioned(top: 90.0, left: 30.0, child: circulo),
      Positioned(top: -40.0, right: -30.0, child: circulo),
      Positioned(bottom: -50.0, right: -10.0, child: circulo),
      Positioned(top: 150.0, right: 10.0, child: circulo),
      Positioned(bottom: 120.0, right: 20.0, child: circulo),
      Positioned(bottom: -50.0, left: -20.0, child: circulo),
      Container(
        padding: const EdgeInsets.only(top: 110.0),
        child: Column(
          children: const [
             FaIcon(FontAwesomeIcons.userLock, color: Colors.white, size: 80.0),
             SizedBox(
              height: 10.0,
              width: double.infinity,
            ),
            Text(
              "  Consigue una nueva \n         contrase\u00F1a",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontFamily: 'Comfortaa-Bold'),
            )
          ],
        ),
      )
    ],
  );
}

class ValidaEstadoBloc extends StatelessWidget {
  const ValidaEstadoBloc({
    Key? key,
    required this.snaps,
  }) : super(key: key);

  final AsyncSnapshot snaps;

  @override
  Widget build(BuildContext context) {
    if (snaps.hasError) {
      return const Padding(
        padding: EdgeInsetsDirectional.only(end: 12.0),
        child: Icon(Icons.report_problem_rounded,
            color: Colors.redAccent), // myIcon is a 48px-wide widget.
      );
    } else if (snaps.hasData) {
      return Padding(
        padding: const EdgeInsetsDirectional.only(end: 12.0),
        child: Icon(Icons.check,
            color: Colors.green[700]), // myIcon is a 48px-wide widget.
      );
    } else {
      return const Padding(
        padding: EdgeInsetsDirectional.only(end: 12.0),
        child:
            Icon(Icons.remove_circle_outlined), // myIcon is a 48px-wide widget.
      );
    }
  }
}


enum SingingCharacter { masculino, femenino, otros }

class DesingRadioButton extends StatefulWidget {
  const DesingRadioButton({Key? key}) : super(key: key);

  @override
  _DesingRadioButtonState createState() => _DesingRadioButtonState();
}

class _DesingRadioButtonState extends State<DesingRadioButton> {
  SingingCharacter? _character = SingingCharacter.masculino;

  @override
  Widget build(BuildContext context) {
    final blocR = Provider.ofRegisterBloc(context);
    return StreamBuilder(
      stream: blocR.genderStreamReg,
      builder: (context, snapshot) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                    backgroundColor: constante.colorPrincipal,
                    child: const Icon(
                      Icons.badge,
                      color: Colors.white,
                    )),
                const SizedBox(
                  width: 22.0,
                ),
                const Text(
                  'Genero',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black54,
                      fontFamily: 'Comfortaa-Light'),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            ListTile(
              title: const Text('Masculino'),
              trailing: const Icon(Icons.male),
              leading: Radio<SingingCharacter>(
                value: SingingCharacter.masculino,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    blocR.changeGenderReg(value.toString().substring(17));
                    _character = value;
                    print(blocR.getGenderBlocReg);
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Femenino'),
              trailing: const Icon(Icons.female),
              leading: Radio<SingingCharacter>(
                value: SingingCharacter.femenino,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    blocR.changeGenderReg(value.toString().substring(17));
                    _character = value;
                    print(blocR.getGenderBlocReg);
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Otros'),
              trailing: const Icon(Icons.people_outline_sharp),
              leading: Radio<SingingCharacter>(
                value: SingingCharacter.otros,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    blocR.changeGenderReg(value.toString().substring(17));
                    _character = value;
                    print(blocR.getGenderBlocReg);
                  });
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
