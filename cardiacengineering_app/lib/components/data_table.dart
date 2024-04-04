import 'package:flutter/material.dart';

class CustomDataTable extends StatelessWidget {
  final List<DataColumn> columns;
  final int rowsCount;
  final List<DataCell> Function(int index) rowCellsBuilder;

  const CustomDataTable({
    Key? key,
    required this.columns,
    required this.rowsCount,
    required this.rowCellsBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 20.0, // Adjusted column spacing
        columns: columns,
        rows: List<DataRow>.generate(
          rowsCount,
          (index) => DataRow(
            cells: rowCellsBuilder(index),
          ),
        ),
      ),
    );
  }
}
