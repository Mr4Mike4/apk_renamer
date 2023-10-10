import 'package:fluent_ui/fluent_ui.dart';

import '../../../domain/model/file_info.dart';

class ApkTable extends StatelessWidget {
  const ApkTable({super.key, this.listInfo});

  final List<FileInfo>? listInfo;

  @override
  Widget build(BuildContext context) {
    // final FluentThemeData theme = FluentTheme.of(context);

    return Table(
      // border: TableBorder.all(),
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: const <int, TableColumnWidth>{
        0: FixedColumnWidth(64),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(),
      },
      children: _rows(),
    );
  }

  List<TableRow> _rows() {
    final rowList = <TableRow>[];
    rowList.add(const TableRow(
      decoration: BoxDecoration(),
      children: <Widget>[
        SizedBox(),
        TableCell(
          child: Text("Исходное"),
        ),
        TableCell(
          child: Text(
            "Переименовано",
          ),
        ),
      ],
    ));
    listInfo?.forEach((e) {
      rowList.add(TableRow(
        decoration: const BoxDecoration(),
        children: <Widget>[
          const TableCell(
            child: Center(
              child: Checkbox(
                checked: true,
                onChanged: null,
              ),
            ),
          ),
          TableCell(
            child: Text(e.currentFileName ?? ''),
          ),
          TableCell(
            child: Text(e.newFileName ?? ''),
          ),
        ],
      ));
    });
    return rowList;
  }
}