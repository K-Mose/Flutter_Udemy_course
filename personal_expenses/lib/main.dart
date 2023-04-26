import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_expenses/widgets/chart.dart';
import 'package:personal_expenses/widgets/new_transaction.dart';
import 'package:personal_expenses/widgets/transaction_list.dart';
import './models/transaction.dart';


void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp, 
  //   DeviceOrientation.portraitDown
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
      primarySwatch: Colors.blue,
      fontFamily: 'Quicksand',
      textTheme: ThemeData.light().textTheme.copyWith(
        // 특정 테마별 스타일 지정
        titleLarge: TextStyle(
          fontFamily: "OpenSans",
          fontSize: 20,
          fontWeight: FontWeight.w700
        ),
        titleMedium: TextStyle(
          fontFamily: "Quicksand",
          fontSize: 18,
          fontWeight: FontWeight.w500
        ),
        titleSmall: TextStyle(
          fontFamily: "OpenSans",
          fontSize: 25,
          fontWeight: FontWeight.bold
        ),
      ),
      appBarTheme: AppBarTheme(
          toolbarTextStyle: ThemeData.light().textTheme.headlineLarge.copyWith(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.normal
          ),
          // AppBar title Style 1
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold
          )
        )
    );
    return MaterialApp(
      title: 'Personal Expenses',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   accentColor: Colors.amber,
      //   fontFamily: 'Quicksand'
      // ),
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          secondary: Colors.black
        ),
        // AppBar title Style 2
        // textTheme: ThemeData.light().textTheme.copyWith(
        //   titleLarge: TextStyle(
        //     fontFamily: 'OpenSans',
        //     fontSize: 22,
        //     fontWeight: FontWeight.bold
        //   )
        // )
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
// String titleInput;
final titleController = TextEditingController();

final amountController = TextEditingController();

bool _showChart = false;

final List<Transaction> _userTransaction = [
    Transaction(
      id: '1', 
      title: 'New Shoes', 
      amount: 120.0, 
      date: DateTime.now().subtract(Duration(days: 1))
    ),
    Transaction(
      id: '2', 
      title: 'Protein', 
      amount: 89.99, 
      date: DateTime.now().subtract(Duration(days: 2))
    ),
    Transaction(
      id: '4', 
      title: 'New Shoes', 
      amount: 120.0, 
      date: DateTime.now().subtract(Duration(days: 1))
    ),
    Transaction(
      id: '5', 
      title: 'Protein', 
      amount: 89.99, 
      date: DateTime.now().subtract(Duration(days: 2))
    ),
    Transaction(
      id: '6', 
      title: 'New Shoes', 
      amount: 120.0, 
      date: DateTime.now().subtract(Duration(days: 1))
    ),
    Transaction(
      id: '7', 
      title: 'Protein', 
      amount: 89.99, 
      date: DateTime.now().subtract(Duration(days: 2))
    ),
    Transaction(
      id: '8', 
      title: 'New Shoes', 
      amount: 120.0, 
      date: DateTime.now().subtract(Duration(days: 1))
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((trx) {
      return trx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7)
        )
      );
    }).toList();
  }

  void _addTransaction(String title, double amount, DateTime date) {
    setState(() {
      _userTransaction.add(
        Transaction(
          id: DateTime.now().toString(), 
          title: title, 
          amount: amount, 
          date: date
        )
      );
    });
    print(_userTransaction);
  }

  void startAddNewTrx(BuildContext context) {
    showModalBottomSheet(
      context: context, 
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(_addTransaction),
        );
      }
    );
  }

  void _deleteTrx(String id) {
    setState(() {
      _userTransaction.removeWhere((trx) => trx.id == id);
    });
  }

  List<Widget> _buildLandscapeContent(
    Widget chart, 
    Widget trxList
  ) {
    return [Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Text("Show Chart"),
      Switch(value: _showChart, onChanged: (value) {
        setState(() {
          _showChart = value;
        });
      })
    ],),
    _showChart ? 
          chart :
          trxList];
  }

  List<Widget> _buildPortaitContent(
    Widget chart, 
    Widget trxList
  ) {
    return [chart, trxList];
  }

  @override
  Widget build(BuildContext context) {
    // MediaQuery - Device에 대한 실제 크기를 가져옴 
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final double chartHeight = isLandscape ? 0.7 : 0.25;
    final double listHeight = isLandscape ? 0.8 : 0.7;

    final appBar = AppBar(
        // backgroundColor: Colors.red,
        title: Text(
          'Personal Expenses', 
          style: TextStyle(fontFamily: 'Open Sans'),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {}, 
            icon: Icon(Icons.add)
          )
        ],
      );
    final trxList = Container(
      height: (mediaQuery.size.height - 
      appBar.preferredSize.height - mediaQuery.padding.top) 
      * listHeight,
      child:TransactionList(_userTransaction, _deleteTrx)
    );
    final chart = Container(
      height: (mediaQuery.size.height - 
      appBar.preferredSize.height - mediaQuery.padding.top) 
      * chartHeight,
      child: Chart(_recentTransactions)
    );
    return Scaffold(
      appBar: appBar,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isLandscape) 
          // spread operator로 list 붙이기 
            ... _buildLandscapeContent(chart, trxList),
          if (!isLandscape) 
            ... _buildPortaitContent(chart, trxList)
        ]
      ),
      // fab 위치 설정
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // fab 아이콘 설정
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startAddNewTrx(context),
      ),
    );
  }
}
