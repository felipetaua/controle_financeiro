import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class addNavButton extends StatefulWidget {
  const addNavButton({super.key});

  @override
  State<addNavButton> createState() => _addNavButtonState();
}

class _addNavButtonState extends State<addNavButton> {
  TextEditingController gastosController = TextEditingController();
  TextEditingController categoriaController = TextEditingController();
  TextEditingController dataController = TextEditingController();
  DateTime selectData = DateTime.now();

  @override
  void initState() {
    dataController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    super.initState();
  }

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
              const SizedBox(
                height: 32,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(
                        FontAwesomeIcons.dollarSign,
                        size: 16,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                          borderSide: BorderSide.none)),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              TextFormField(
                controller: categoriaController,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(
                      FontAwesomeIcons.list,
                      size: 16,
                      color: Colors.grey,
                    ),
                    hintText: ('Categoria'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none)),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: dataController,
                readOnly: true,
                textAlignVertical: TextAlignVertical.center,
                onTap: () async {
                  DateTime? newDate = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      initialDate: selectData,
                      lastDate: DateTime.now().add(Duration(days: 365)));

                  if (newDate != null) {
                    setState(() {
                      dataController.text =
                          DateFormat('dd/MM/yyyy').format(newDate);
                      selectData = newDate;
                    });
                  }
                },
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(
                      FontAwesomeIcons.calendar,
                      size: 16,
                      color: Colors.grey,
                    ),
                    hintText: ('Data'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none)),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                height: kToolbarHeight,
                child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    child: const Text(
                      'Salvar',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
