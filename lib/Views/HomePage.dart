import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:plasticz/Provider/DBProvider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DeviceInfoPlugin celInfo = DeviceInfoPlugin();
  List<Widget> textWidgets = [];
  String _imeiNumber = "Unknown";
  String _sn = "Unknown";
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String imeiNumber;
    try {
      imeiNumber = await ImeiPlugin.getImei();
    } on PlatformException {}
    if (!mounted) return;
    setState(() {
      _imeiNumber = imeiNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      // decoration: BoxDecoration(
      //     gradient: LinearGradient(
      //         begin: Alignment.centerLeft,
      //         end: Alignment.bottomRight,
      //         stops: [
      //       0.3,
      //       0.5
      //     ],
      //         colors: [
      //       Colors.yellow,
      //       Colors.indigo,
      //     ])),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Plasti Z',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: MaterialButton(
                  shape: StadiumBorder(),
                  color: Colors.black,
                  textColor: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('INICIAR COTIZACIÓN'),
                      SizedBox(width: 20.0),
                      Icon(Icons.shopping_cart_outlined)
                    ],
                  ),
                  onPressed: () async {
                    // AndroidDeviceInfo androidInfo = await celInfo.androidInfo;
                    // setState(() {
                    //   textWidgets.clear();
                    //   textWidgets
                    //       .add(Text('ID ANDROID ${androidInfo.androidId}'));
                    //   // textWidgets.add(Text('ID ${androidInfo.id}'));
                    //   // textWidgets.add(Text('IMEI $_imeiNumber'));
                    // });
                    await DBProvider.db.borrarTodoProducto();
                    await DBProvider.db.borrarTodoCliente();
                    await Navigator.pushNamed(context, '/cliente');
                  }),
            ),
            // ...textWidgets
          ],
        ),
      ),
    ));
  }
}
