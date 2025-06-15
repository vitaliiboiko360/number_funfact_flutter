import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:number_funfact_flutter/src/fetch_data.dart';
import 'package:number_funfact_flutter/src/number_details.dart';
import 'package:number_funfact_flutter/src/routes/routes.dart';

const String historyName = 'History';
const String historySeparator = '|||';
const int historyMaxLength = 10;
const int historyItemMaxLines = 2;

void saveToHistory(NumberInfo numberInfo) {
  String historyString = localStorage.getItem(historyName) ?? '';
  List<String> historyArrayString = historyString.split(historySeparator);
  historyArrayString.insert(0, numberInfo.toString());
  if (historyArrayString.length > historyMaxLength) {
    historyArrayString.removeRange(
      historyMaxLength - 1,
      historyArrayString.length - 1,
    );
  }
  localStorage.setItem(historyName, historyArrayString.join(historySeparator));
}

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Widget> _getHistoryItems() {
    String historyString = localStorage.getItem(historyName) ?? '';
    List<String> historyArrayString = historyString.split(historySeparator);
    List<Widget> historyItems = [];
    historyArrayString.forEach((historyItem) {
      if (historyItem == '') {
        return;
      }
      var numberInfo = NumberInfo.fromString(historyItem);
      historyItems.add(
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              numberDetailsHistorySaved,
              arguments: NumberDetailsArguments(
                numberInfo.number,
                numberInfo.info,
              ),
            );
          },
          child: SizedBox(
            width: 300,
            child: Text(
              historyItem,
              maxLines: historyItemMaxLines,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      );
    });
    return historyItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text(historyName),
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.value,
                  spacing: 10,
                  children: _getHistoryItems(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
