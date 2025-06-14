import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:number_funfact_flutter/src/number_details.dart';
import 'package:number_funfact_flutter/src/routes/routes.dart';

class HomeMenuPage extends StatefulWidget {
  const HomeMenuPage({super.key, required this.title});

  final String title;

  @override
  State<HomeMenuPage> createState() => _HomeMenuPageState();
}

class _HomeMenuPageState extends State<HomeMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[NumberInput(), GetRandomNumberButton()],
        ),
      ),
    );
  }
}

class NumberInput extends StatefulWidget {
  const NumberInput({super.key});

  @override
  State<NumberInput> createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  final textInputController = TextEditingController();
  int number = 0;

  @override
  void dispose() {
    textInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 200,
          child: TextField(
            controller: textInputController,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Enter Number',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        TextButton.icon(
          onPressed: () {
            if (textInputController.text == '') {
              return;
            }
            var number = int.tryParse(textInputController.text);
            if (number != null) {
              Navigator.pushNamed(
                context,
                numberDetailsRouteName,
                arguments: NumberDetailsArguments(number),
              );
            }
          },
          icon: const Icon(Icons.search),
          label: const Text(''),
        ),
      ],
    );
  }
}

class GetRandomNumberButton extends StatelessWidget {
  const GetRandomNumberButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, numberDetailsRouteName);
      },
      child: Text('Get Random Number'),
    );
  }
}
