import 'package:app_pizzeria/widget/categories_buttons_tab.dart';
import 'package:app_pizzeria/data/menu_items_list.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Categories currentCategory = Categories.pizza;

  void changeCategory(Categories catogry) {
    setState(() {
      currentCategory = catogry;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 30.0, 20.0, 0.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text(
              "Menu",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            //start search icon
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.black,
                  style: BorderStyle.solid,
                  width: 1.0,
                ),
              ),
              child: InkWell(
                onTap: () {
                  _showModal(context);
                },
                child: const Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Icon(Icons.search),
                ),
              ),
            )
            //end search icon
          ]),
        ),
        const SizedBox(
          height: 40,
        ),
        CategoriesButton(changeCategory),
        Expanded(
          child: Container(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
            child: ListView(
              shrinkWrap: true,
              children: items
                  .where((element) => element.category == currentCategory)
                  .toList(),
            ),
          ),
        )
      ],
    );
  }

  void _showModal(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
        ),
        context: context,
        builder: (context) {
          //3
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return DraggableScrollableSheet(
                expand: false,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      Row(children: [
                        Expanded(
                            child: TextField(
                                //controller: textController,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(8),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: const BorderSide(),
                                  ),
                                  prefixIcon: const Icon(Icons.search),
                                ),
                                onChanged: (value) {
                                  //4
                                })),
                        IconButton(
                            icon: const Icon(Icons.close),
                            color: const Color(0xFF1F91E7),
                            onPressed: () {
                              setState(() {
                                Navigator.of(context).pop();
                              });
                            }),
                      ]),
                    ]),
                  );
                });
          });
        });
  }
}

/**Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
          child: SearchBar(
            leading: const Padding(
              padding: EdgeInsets.all(5.0),
              child: Icon(Icons.search),
            ),
            trailing: [
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () {},
              ),
            ],
            hintText: "Cerca quello che vuoi ordinare",
            onTap: () {},
            onChanged: (value) {
              print(value);
            },
          ),
        ), */


        