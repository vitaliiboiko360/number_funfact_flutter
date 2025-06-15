import 'package:flutter/material.dart';
import 'package:number_funfact_flutter/src/fetch_data.dart';
import 'package:number_funfact_flutter/src/history.dart';

const int notInitialized = -1;

class NumberDetailsPage extends StatefulWidget {
  const NumberDetailsPage({
    super.key,
    this.number = notInitialized,
    this.info = '',
  });

  final int number;
  final String info;

  @override
  State<NumberDetailsPage> createState() => _NumberDetailsPageState();
}

class _NumberDetailsPageState extends State<NumberDetailsPage> {
  late Future<NumberInfo> numberInfo;
  bool isFromHistory = false;

  @override
  void initState() {
    super.initState();
    if (widget.info != '') {
      numberInfo = Future.value(NumberInfo.fromString(widget.info));
      isFromHistory = true;
      return;
    }
    if (widget.number == notInitialized) {
      numberInfo = fetchRandomNumberInfo();
    } else {
      numberInfo = fetchNumberInfo(widget.number);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text('Number Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<NumberInfo>(
              future: numberInfo,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (isFromHistory == false) {
                    saveToHistory(snapshot.data!);
                  }
                  return SizedBox(
                    width: 300,
                    child: Text(
                      snapshot.data!.info,
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class NumberDetailsArguments {
  int number;
  String info;
  NumberDetailsArguments(this.number, this.info);
}

class ExtractArgumentsForNumberDetailsPage extends StatelessWidget {
  const ExtractArgumentsForNumberDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as NumberDetailsArguments?;
    if (args != null) {
      if (args.info != '') {
        return NumberDetailsPage(number: args.number, info: args.info);
      }
      return NumberDetailsPage(number: args.number);
    }
    return NumberDetailsPage();
  }
}
