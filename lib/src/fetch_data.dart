import 'dart:async';
import 'package:http/http.dart' as http;

const int httpOk = 200;

Future<NumberInfo> fetchNumberInfo(int number) async {
  final response = await http.get(Uri.parse('http://numbersapi.com/$number'));

  if (response.statusCode == httpOk) {
    return NumberInfo(number: number, info: response.body);
  } else {
    throw Exception('Failed to load NumberInfo');
  }
}

Future<NumberInfo> fetchRandomNumberInfo() async {
  final response = await http.get(
    Uri.parse('http://numbersapi.com/random/math'),
  );

  if (response.statusCode == httpOk) {
    String info = response.body;
    RegExp exp = RegExp(r'\d+');
    int number = int.tryParse(exp.firstMatch(info)![0] ?? '') ?? 0;
    return NumberInfo(number: number, info: info);
  } else {
    throw Exception('Failed to load NumberInfo');
  }
}

class NumberInfo {
  final int number;
  final String info;

  const NumberInfo({required this.number, required this.info});
}
