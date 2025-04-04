import 'package:controle_financeiro/screens/add_nav/blocs/create_categorybloc/create_category_bloc.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddNavButton extends StatefulWidget {
  const AddNavButton({super.key});

  @override
  State<AddNavButton> createState() => _AddNavButtonState();
}

class _AddNavButtonState extends State<AddNavButton> {
  TextEditingController gastosController = TextEditingController();
  TextEditingController categoriaController = TextEditingController();
  TextEditingController dataController = TextEditingController();
  DateTime selectData = DateTime.now();

  bool isLoading = false;

  List<String> myCategoriesIcons = [
    'entertainment',
    'food',
    'home',
    'pet',
    'shopping',
    'tech',
    'travel'
  ];

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
                readOnly: false,
                onTap: () {},
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(
                      FontAwesomeIcons.list,
                      size: 16,
                      color: Colors.grey,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              bool isExpanded = false;
                              String iconSelected = '';
                              late Color categoryColor = Colors.white;
                              TextEditingController categoryNameController =
                                  TextEditingController();
                              TextEditingController categoryIconController =
                                  TextEditingController();
                              TextEditingController categoryColorController =
                                  TextEditingController();

                              return BlocProvider.value(
                                value: context.read<CreateCategoryBloc>(),
                                child: BlocListener<CreateCategoryBloc,
                                    CreateCategoryState>(
                                  listener: (context, state) {
                                    if (state is CreateCategorySucess) {
                                      Navigator.pop(ctx);
                                    } else if (state is CreateCategoryLoading) {
                                      setState(() {
                                        isLoading == true;
                                      });
                                    }
                                  },
                                  child:
                                      StatefulBuilder(builder: (ctx, setState) {
                                    return AlertDialog(
                                      title:
                                          const Text('Criando uma Categoria'),
                                      content: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextFormField(
                                              controller:
                                                  categoryNameController,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              decoration: InputDecoration(
                                                  isDense: true,
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  hintText: ('Nome'),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      borderSide:
                                                          BorderSide.none)),
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            TextFormField(
                                              controller:
                                                  categoryIconController,
                                              onTap: () {
                                                setState(() {
                                                  isExpanded = !isExpanded;
                                                });
                                              },
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              decoration: InputDecoration(
                                                  isDense: true,
                                                  filled: true,
                                                  suffixIcon: Icon(
                                                    CupertinoIcons.chevron_down,
                                                    size: 12,
                                                  ),
                                                  fillColor: Colors.white,
                                                  hintText: ('Icone'),
                                                  border: OutlineInputBorder(
                                                      borderRadius: isExpanded
                                                          ? const BorderRadius
                                                              .vertical(
                                                              top: Radius
                                                                  .circular(12))
                                                          : BorderRadius
                                                              .circular(12),
                                                      borderSide:
                                                          BorderSide.none)),
                                            ),
                                            isExpanded
                                                ? Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height: 200,
                                                    decoration: const BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.vertical(
                                                                bottom: Radius
                                                                    .circular(
                                                                        12))),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: GridView.builder(
                                                        gridDelegate:
                                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 3,
                                                          mainAxisSpacing: 5,
                                                          crossAxisSpacing: 5,
                                                        ),
                                                        itemCount:
                                                            myCategoriesIcons
                                                                .length,
                                                        itemBuilder:
                                                            (context, int i) {
                                                          return GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                iconSelected =
                                                                    myCategoriesIcons[
                                                                        i];
                                                              });
                                                            },
                                                            child: Container(
                                                              width: 50,
                                                              height: 50,
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      width: 3,
                                                                      color: iconSelected ==
                                                                              myCategoriesIcons[
                                                                                  i]
                                                                          ? Colors
                                                                              .green
                                                                          : Colors
                                                                              .grey),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  image: DecorationImage(
                                                                      image: AssetImage(
                                                                          'assets/categorias/${myCategoriesIcons[i]}.png'))),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ))
                                                : Container(),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            TextFormField(
                                              controller:
                                                  categoryColorController,
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (ctx2) {
                                                      return AlertDialog(
                                                        content: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            ColorPicker(
                                                              pickerColor:
                                                                  Colors.blue,
                                                              onColorChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  categoryColor =
                                                                      value;
                                                                });
                                                              },
                                                            ),
                                                            SizedBox(
                                                              width: double
                                                                  .infinity,
                                                              height: 50,
                                                              child: TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    // print(
                                                                    //     categoryColor);
                                                                    Navigator.pop(
                                                                        ctx2);
                                                                  },
                                                                  style: TextButton.styleFrom(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .black,
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(
                                                                              12))),
                                                                  child:
                                                                      const Text(
                                                                    'Salvar Cor',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        color: Colors
                                                                            .white),
                                                                  )),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    });
                                              },
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: categoryColor,
                                                  hintText: ('Cor'),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      borderSide:
                                                          BorderSide.none)),
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            SizedBox(
                                              width: double.infinity,
                                              height: kToolbarHeight,
                                              child: isLoading == true
                                                  ? const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    )
                                                  : TextButton(
                                                      onPressed: () {
                                                        // criadno o objeto categoria e POP
                                                        Category category =
                                                            Category.empty;
                                                        category.categoryId =
                                                            const Uuid().v1();
                                                        category.name =
                                                            categoryNameController
                                                                .text;
                                                        category.icon =
                                                            iconSelected;
                                                        category.color =
                                                            categoryColor
                                                                .toString();
                                                        context
                                                            .read<
                                                                CreateCategoryBloc>()
                                                            .add(CreateCategory(
                                                                category));
                                                        // Navigator.pop(context);
                                                      },
                                                      style: TextButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.black,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12))),
                                                      child: const Text(
                                                        'Salvar',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color:
                                                                Colors.white),
                                                      )),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              );
                            });
                      },
                      icon: const Icon(
                        FontAwesomeIcons.plus,
                        size: 16,
                        color: Colors.grey,
                      ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
