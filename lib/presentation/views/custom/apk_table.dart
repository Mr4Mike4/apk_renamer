import 'package:fluent_ui/fluent_ui.dart';

import '../../../data/model/file_info.dart';
import '../../../localizations.dart';
import 'apk_table_header.dart';
import 'apk_table_item.dart';

class ApkTable extends StatefulWidget {
  const ApkTable({super.key, this.listInfo});

  final List<FileInfo>? listInfo;

  @override
  State<ApkTable> createState() => _ApkTableState();
}

class _ApkTableState extends State<ApkTable> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final FluentThemeData theme = FluentTheme.of(context);
    final S = AppLocal.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      clipBehavior: Clip.hardEdge,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(
            color: theme.resources.controlStrokeColorDefault,
            width: 1.0,
            style: BorderStyle.solid,
          ),
          color: theme.resources.controlFillColorDefault,
        ),
        child: Column(
          children: [
            ApkTableHeader(
              currentFileName: S.table_column_name,
              newFileName: S.table_column_new_name,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.listInfo?.length??0,
                controller: _scrollController,
                itemBuilder: (context, index) {
                  final item = widget.listInfo![index];
                  return ApkTableItem(
                    fileInfo: item,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<TableRow> _rows(FluentThemeData theme, AppLocalizations S) {
    final rowList = <TableRow>[];
    rowList.add(TableRow(
      children: <Widget>[
        const SizedBox(),
        TableCell(
          child: Text(
            S.table_column_name,
            style: theme.typography.bodyStrong,
          ),
        ),
        TableCell(
          child: Text(
            S.table_column_new_name,
            style: theme.typography.bodyStrong,
          ),
        ),
      ],
    ));
    widget.listInfo?.forEach((e) {
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
