import 'package:ecommerce_admin/core/constant.dart';
import 'package:flutter/material.dart';

class FavoriteFlavorsTable extends StatelessWidget {
  const FavoriteFlavorsTable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryTextStyle = Theme.of(context).textTheme.bodyLarge;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        width: double.infinity,
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          border: const TableBorder(
            top: BorderSide(color: Colors.white),
            bottom: BorderSide(color: Colors.white),
            left: BorderSide(color: Colors.white),
            right: BorderSide(color: Colors.white),
            horizontalInside: BorderSide(color: Colors.white),
          ),
          children: List.generate(
            favoriteFlavors.length,
            (index) => TableRow(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: 20.0),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(favoriteFlavors[index]['avatar']),
                    ),
                  ),
                ),
                Text(
                  favoriteFlavors[index]['label'],
                  style: primaryTextStyle,
                ),
                Text(
                  favoriteFlavors[index]['time'],
                  style: primaryTextStyle,
                ),
                Text(
                  favoriteFlavors[index]['amount'],
                  style: primaryTextStyle,
                ),
                Text(
                  favoriteFlavors[index]['status'],
                  style: primaryTextStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
