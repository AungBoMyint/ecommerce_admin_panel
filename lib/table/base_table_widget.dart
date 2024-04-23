import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:flutter/material.dart';

class BaseTable extends StatelessWidget {
  const BaseTable({
    super.key,
    required this.columnList,
    required this.rowList,
    this.flex,
    required this.actionsWidget,
  });

  final List<Widget> columnList;
  final List<List<DataCell>> rowList;
  final int? flex;
  final Widget actionsWidget;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex ?? 1,
      child: Column(
        children: [
          actionsWidget,
          Expanded(
            child: DataTable2(
              border: TableBorder.symmetric(
                  outside: BorderSide(color: Colors.grey.shade300)),
              columns: List.generate(
                columnList.length,
                (index) => DataColumn2(
                  onSort: (v, b) => {},
                  /* fixedWidth: index == 2 ? 200 : null, */
                  size: (index == 0) ? ColumnSize.S : ColumnSize.L,
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
            ).withMargin(20, 20),
          ),
        ],
      ),
    );
  }
}
