import 'package:flutter/material.dart';

class addNavButton extends StatelessWidget {
  const addNavButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Adicione seus gastos",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              TextFormField(),
              const SizedBox(
                height: 12,
              ),
              TextFormField(),
              const SizedBox(
                height: 12,
              ),
              TextFormField(),
              const SizedBox(
                height: 12,
              ),
              TextButton(onPressed: () {}, child: Text('Salvar'))
            ],
          ),
        ),
      ),
    );
  }
}
