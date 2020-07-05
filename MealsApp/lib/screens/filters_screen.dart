import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

Widget _buildSwitchListTile(
  String title,
  bool value,
  String subTitle,
  Function setValue,
) {
  return SwitchListTile(
    title: Text(title),
    value: value,
    subtitle: Text(subTitle),
    onChanged: setValue,
  );
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _lactoseFree = false;
  var _vegetarian = false;
  var _vegan = false;

  @override
  void initState() {
    // TODO: implement initState
    _glutenFree = widget.currentFilters['gluten'];
    _lactoseFree = widget.currentFilters['lactose'];
    _vegetarian = widget.currentFilters['vegetarian'];
    _vegan = widget.currentFilters['vegan'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegetarian': _vegetarian,
                'vegan': _vegan,
              };
              widget.saveFilters(selectedFilters);
            },
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(40),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(
                  'Gluten-free',
                  _glutenFree,
                  'Only include Gluten-free meals.',
                  (newValue) => setState(() {
                    _glutenFree = newValue;
                  }),
                ),
                _buildSwitchListTile(
                  'Lactose-free',
                  _lactoseFree,
                  'Only include Lactose-free meals.',
                  (newValue) => setState(() {
                    _lactoseFree = newValue;
                  }),
                ),
                _buildSwitchListTile(
                  'Vegetarian',
                  _vegetarian,
                  'Only include Vegetarian meals.',
                  (newValue) => setState(() {
                    _vegetarian = newValue;
                  }),
                ),
                _buildSwitchListTile(
                  'Vegan',
                  _vegan,
                  'Only include Vegan meals.',
                  (newValue) => setState(() {
                    _vegan = newValue;
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
