import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem({this.id, this.title, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
            imageUrl), // used NetworkImage here rather than Image.network as NetworkImage takes url directly from provider.
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: id);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                return showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Are you Sure?'),
                    content: Text('This will delete the item forever.'),
                    actions: [
                      FlatButton(
                        child: Text('YES'),
                        onPressed: () async {
                          try {
                            Navigator.of(ctx).pop(true);
                            // pop this first as await will also return a future.
                            await Provider.of<Products>(context, listen: false)
                                .deleteProduct(id);
                          } catch (error) {
                            scaffold.showSnackBar(
                              // gives error here that, Looking up a deactivated widget's ancestor is unsafe, hence take scaffold up.
                              SnackBar(
                                content: Text(
                                  'Could not delete item.',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          }
                          //Navigator.of(ctx).pop(true);
                        },
                      ),
                      FlatButton(
                        onPressed: () => Navigator.of(ctx).pop(false),
                        child: Text('NO'),
                      ),
                    ],
                  ),
                );
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
