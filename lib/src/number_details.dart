import 'package:flutter/material.dart';
import 'package:number_funfact_flutter/src/fetch_data.dart';

const int notInitialized = -1;

class NumberDetailsPage extends StatefulWidget {
  const NumberDetailsPage({super.key, this.number = notInitialized});

  final int number;

  @override
  State<NumberDetailsPage> createState() => _NumberDetailsPageState();
}

class _NumberDetailsPageState extends State<NumberDetailsPage> {
  late Future<NumberInfo> numberInfo;

  @override
  void initState() {
    super.initState();
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

  NumberDetailsArguments(this.number);
}

class ExtractArgumentsForNumberDetailsPage extends StatelessWidget {
  const ExtractArgumentsForNumberDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as NumberDetailsArguments?;
    if (args != null) {
      return NumberDetailsPage(number: args.number);
    }
    return NumberDetailsPage();
  }
}
