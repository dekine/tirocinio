import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen(
      {Key? key, required this.setFilters, required this.currentFilters})
      : super(key: key);

  static const routeName = '/filters';

  final Function setFilters;
  final Map<String, bool> currentFilters;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  late bool _glutenFree;
  late bool _vegan;
  late bool _vegetarian;
  late bool _lactoseFree;

  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten']!;
    _vegan = widget.currentFilters['vegan']!;
    _vegetarian = widget.currentFilters['vegetarian']!;
    _lactoseFree = widget.currentFilters['lactose']!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () => widget.setFilters({
              'gluten': _glutenFree,
              'lactose': _lactoseFree,
              'vegan': _vegan,
              'vegetarian': _vegetarian,
            }),
          )
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(children: <Widget>[
        Container(
          padding: const EdgeInsets.all(20),
          child: Text(
            'Adjust your meal selection.',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Expanded(
            child: ListView(
          children: <Widget>[
            SwitchListTile(
                title: const Text('Gluten-free'),
                subtitle: const Text('Only include gluten-free meals.'),
                value: _glutenFree,
                onChanged: (newVal) => setState(() => _glutenFree = newVal)),
            SwitchListTile(
                title: const Text('Vegan'),
                subtitle: const Text('Only include vegan meals.'),
                value: _vegan,
                onChanged: (newVal) => setState(() => _vegan = newVal)),
            SwitchListTile(
                title: const Text('Vegetarian'),
                subtitle: const Text('Only include vegetarian meals.'),
                value: _vegetarian,
                onChanged: (newVal) => setState(() => _vegetarian = newVal)),
            SwitchListTile(
                title: const Text('Lactose-free'),
                subtitle: const Text('Only include lactose-free meals.'),
                value: _lactoseFree,
                onChanged: (newVal) => setState(() => _lactoseFree = newVal)),
          ],
        ))
      ]),
    );
  }
}
