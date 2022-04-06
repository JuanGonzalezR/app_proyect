import 'package:app/src/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../services/ent_api.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myCardView(),
    );
  }

  Widget myCardView() {
    return SafeArea(
        child: Card(
      elevation: 5,
      child: _datosFuture(),
    ));
  }
}

_datosFuture() {
  return FutureBuilder(
      future: getInfo(),
      builder: (_, AsyncSnapshot<List<EntLogin>> snapshot) {
        if (snapshot.hasData) {
          List<EntLogin>? datos = snapshot.data;
          return ContCard(data: datos!);
        }
        return const Center(child: CircularProgressIndicator());
      });
}

class ContCard extends StatelessWidget {
  final List<EntLogin> data;

  const ContCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      height: 200,
      child: Stack(
        children: [
          Positioned(
            top: 10,
            left: 5,
            child: SvgPicture.network(
              data[0].logoUrl,
              width: 40,
              height: 40,
              placeholderBuilder: (BuildContext context) => Center(
                child: Container(
                    padding: const EdgeInsets.all(50.0),
                    child: const CircularProgressIndicator()),
              ),
            ),
          ),
          Positioned(
              top: 10,
              left: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Text(
                      data[0].name,
                      style: const TextStyle(
                          fontSize: 20, fontFamily: 'Comfortaa-Bold'),
                    ),
                    const SizedBox(width: 5),
                    Text(data[0].symbol,
                        style: const TextStyle(
                            fontSize: 20, fontFamily: 'Comfortaa-Light')),
                    const SizedBox(width: 5),
                    _valideStatus(data[0].status),
                  ]),
                  const SizedBox(
                    height: 5,
                  ),
                  Text('Precio: ${data[0].price}',
                      style: const TextStyle(fontSize: 13)),
                  Text('Fecha y hora: ${data[0].priceTimestamp}',
                      style: const TextStyle(fontSize: 13)),
                  Text('Intercambios: ${data[0].numExchanges}',
                      style: const TextStyle(fontSize: 13)),
                  Text('Primera vela: ${data[0].firstCandle}',
                      style: const TextStyle(fontSize: 13)),
                  Text('Primer trade: ${data[0].firstTrade}',
                      style: const TextStyle(fontSize: 13)),
                ],
              ))
        ],
      ),
    );
  }
}

Widget _valideStatus(String status) {
  if (status == 'active') {
    return const CircleAvatar(
      backgroundColor: Colors.green,
      radius: 7,
    );
  } else {
    return const CircleAvatar(backgroundColor: Colors.red, radius: 7);
  }
}
