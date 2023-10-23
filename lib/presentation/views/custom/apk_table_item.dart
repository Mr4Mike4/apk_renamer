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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: Row(
        children: [
          SizedBox(
            width: 64,
            child: Center(
              child: Checkbox(
                checked: fileInfo.isEnable,
                onChanged: onChangedEnable != null
                    ? (bool? checked) => onChangedEnable!(checked, fileInfo)
                    : null,
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Text(fileInfo.currentFileName ?? ''),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Text(fileInfo.newFileName ?? ''),
          ),
          SizedBox(
            width: 64,
            child: Center(
              child: IconButton(
                icon: const Icon(FluentIcons.delete, size: 18.0),
                onPressed: () {
                  onDelete?.call(fileInfo);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
