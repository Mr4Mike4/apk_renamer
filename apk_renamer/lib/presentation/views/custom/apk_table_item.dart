import 'package:fluent_ui/fluent_ui.dart';
import 'package:renamer_lib/model/file_info.dart';

typedef DelFileInfoCallback = void Function(FileInfo fileInfo);
typedef ChangedEnableFileInfoCallback = void Function(
    bool? checked, FileInfo fileInfo);

class ApkTableItem extends StatelessWidget {
  const ApkTableItem({
    super.key,
    required this.fileInfo,
    this.onDelete,
    this.onChangedEnable,
  });

  final FileInfo fileInfo;
  final DelFileInfoCallback? onDelete;
  final ChangedEnableFileInfoCallback? onChangedEnable;

  void _onPressed() {
    onDelete?.call(fileInfo);
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 32),
      child: Row(
        children: [
          Container(
            width: 64,
            alignment: Alignment.center,
            child: Checkbox(
              checked: fileInfo.isEnable,
              onChanged: onChangedEnable != null
                  ? (bool? checked) => onChangedEnable!(checked, fileInfo)
                  : null,
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Text(fileInfo.currentFileName),
          ),
          const SizedBox(width: 16),
          Flexible(
            fit: FlexFit.tight,
            child: Text(fileInfo.newFileName ?? ''),
          ),
          Container(
            width: 64,
            alignment: Alignment.center,
            child: IconButton(
              icon: const Icon(FluentIcons.delete, size: 18.0),
              onPressed: _onPressed,
            ),
          ),
        ],
      ),
    );
  }
}
