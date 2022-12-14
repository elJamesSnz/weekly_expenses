import 'dart:io';
//flutter imports
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//3rd party imports

//my imports
import './widgets/txs_list.dart';
import './widgets/add_txs.dart';
import './widgets/chart.dart';
import './models/tx.dart';

void main() {
  //Ensuring orientation lock works in all devices
  //WidgetsFlutterBinding.ensureInitialized();
  //Locking the device orientarion.
  // SystemChrome.setPreferredOrientations(
  //   [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyExpenses',
      theme: ThemeData(
          primarySwatch: Colors.cyan,
          accentColor: Colors.amber,
          errorColor: Colors.redAccent,
          fontFamily: 'QuickSand',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              button: TextStyle(color: Colors.white)),
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold))),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  bool _chart = false;
  final List<Tx> _listTxs = [
    //Tx(id: 'Tx1', name: 'Food', amount: 299.23, date: DateTime.now()),
    //Tx(id: 'Tx2', name: 'Videogame: MW2', amount: 129.99, date: DateTime.now()),
  ];

  List<Tx> get _recentTx {
    return _listTxs.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTx(String name, double amount, DateTime date) {
    final newTx = Tx(
        id: DateTime.now().toString(), name: name, amount: amount, date: date);
    setState(() {
      //adding the element into the list
      _listTxs.add(newTx);
    });
  }

  void _deleteTx(String id) {
    setState(() {
      //removes qhere condition is met
      _listTxs.removeWhere((tx) => tx.id == id);
    });
  }

  void _modalNewTx(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          //to prevent the sheet from closing if you tap at the botom of the sheet
          onTap: () {},
          child: AddTxs(_addNewTx),
          //catch event and avoid tap
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  List<Widget> _buildLandscape(
      MediaQueryData mediaQuery, PreferredSizeWidget appBar, Widget txList) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Chart',
            style: Theme.of(context).textTheme.headline6,
          ),
          Switch.adaptive(
            value: _chart,
            onChanged: (value) {
              setState(() {
                _chart = value;
              });
            },
          ),
        ],
      ),
      _chart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  .7,
              child: Chart(_recentTx))
          : txList
    ];
  }

  List<Widget> _buildPortrait(
      MediaQueryData mediaQuery, PreferredSizeWidget appBar, Widget txList) {
    return [
      Container(
          height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) *
              .3,
          child: Chart(_recentTx)),
      txList
    ];
  }

  PreferredSizeWidget _buildAppBar() {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Expenses'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _modalNewTx(context),
                )
              ],
            ),
          )
        : AppBar(
            title: Text('Expenses'),
            actions: [
              //list-of-widgets
              IconButton(
                  onPressed: () => _modalNewTx(context), icon: Icon(Icons.add))
            ],
          ) as PreferredSizeWidget;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //print(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //to prevent asking for MediaQuery data
    final mediaQuery = MediaQuery.of(context);

    final mobileInLandscape = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = _buildAppBar();

    final txList = Container(
        height: mediaQuery.size.height -
            appBar.preferredSize.height -
            mediaQuery.padding.top * .7,
        child: TxsList(_listTxs, _deleteTx));

    final appBody = SafeArea(
      child: SingleChildScrollView(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          //spreadoperator ... in front of List to pull elements out of list
          //as single items
          if (mobileInLandscape) ..._buildLandscape(mediaQuery, appBar, txList),
          if (!mobileInLandscape) ..._buildPortrait(mediaQuery, appBar, txList),
        ]),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(child: appBody)
        : Scaffold(
            appBar: appBar,
            body: appBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _modalNewTx(context),
                  ));
  }
}
