/* import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class TableWidget extends StatelessWidget {
  final List<Widget> columnList;
  final List<List<DataCell>> rowList;
  const TableWidget({
    super.key,
    required this.columnList,
    required this.rowList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DataTable2(
        minWidth: 200,
        border: TableBorder.symmetric(
            outside: BorderSide(color: Colors.grey.shade300)),
        columns: List.generate(
          columnList.length,
          (index) => DataColumn2(
            onSort: (v, b) => {},
            fixedWidth: index == 2 ? 200 : null,
            size: (index == 0 || index == 1) ? ColumnSize.S : ColumnSize.L,
            label: columnList[index],
          ), /* columnList
            .map(
              (e) => DataColumn2(
                size: ColumnSize.L,
                label: e,
              ),
            )
            .toList( */
        ),
        rows: List.generate(
            rowList.length,
            (index) => DataRow2(
                specificRowHeight: 85,
                color: (index % 2 == 0)
                    ? MaterialStateProperty.all(Colors.grey.shade100)
                    : MaterialStateProperty.all(Colors.white),
                cells: rowList[
                    index])), /* [
            DataRow(cells: [
              DataCell(
                Checkbox(
                  value: false,
                  onChanged: (v) {},
                ),
              ),
            ]),
          ], */
      ),
    );
  }
}
 */