import 'package:app_pizzeria/providers/menu_provider.dart';
import 'package:app_pizzeria/widget/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:app_pizzeria/widget/menu_widget/categories_buttons_tab.dart';
import 'package:app_pizzeria/widget/menu_widget/search_result.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key, required this.selectedCategory});
  final Categories selectedCategory;

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  Categories currentCategory = Categories.pizze;
  SearchResult? result;

  @override
  void initState() {
    super.initState();
    result = SearchResult(name: "", category: currentCategory);
    currentCategory = widget.selectedCategory;
  }

  void changeCategory(Categories category) {
    setState(() {
      currentCategory = category;
      result = SearchResult(
        name: "",
        category: currentCategory,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 30),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              color: Theme.of(context).primaryColor),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 30.0, 20.0, 0.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Menu",
                    style: Theme.of(context).textTheme.titleLarge,
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
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: Stack(
            children: [
              Positioned.fill(
                top: 0,
                child: Container(
                    padding: const EdgeInsets.fromLTRB(10.0, 25.0, 20.0, 0.0),
                    child: ListView(
                        children: Provider.of<MenuProvider>(context)
                            .menu
                            .where((element) =>
                                element.category == currentCategory)
                            .map(
                              (e) => MenuItem(
                                dataItem: e,
                                icon: Icon(
                                  Icons.add_shopping_cart,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            )
                            .toList())),
              ),
              CategoriesButton(currentCategory, changeCategory),
            ],
          ),
        ),
      ],
    );
  }

  void _showModal(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      context: context,
      builder: (context) {
        //3
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return DraggableScrollableSheet(
                  expand: false,
                  builder: (BuildContext context,
                      ScrollController scrollController) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: SearchBar(
                                  leading: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Icon(Icons.search),
                                  ),
                                  hintText: "Cerca quello che vuoi ordinare",
                                  onChanged: (value) {
                                    setState(() {
                                      result = SearchResult(
                                        name: value,
                                        category: currentCategory,
                                      );
                                    });
                                  },
                                ),
                              ),
                              IconButton(
                                  icon: const Icon(Icons.close),
                                  color: const Color(0xFF1F91E7),
                                  onPressed: () {
                                    setState(() {
                                      Navigator.of(context).pop();
                                    });
                                  }),
                            ],
                          ),
                          Expanded(
                            child: result!,
                          ),
                        ],
                      ),
                    );
                  });
            }),
          ),
        );
      },
    ).whenComplete(() {
      setState(() {
        result = SearchResult(
          name: "",
          category: currentCategory,
        );
      });
    });
  }
}
