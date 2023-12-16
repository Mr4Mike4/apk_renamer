import 'dart:async';

import 'package:apk_renamer/internal/localiz.dart';
import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:parser_apk_info/repository/aapt_util.dart';

import '../../../data/repository/preferences_repository.dart';
import '../../../logger.dart';

part 'settings_bloc.freezed.dart';
part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc(this._pref) : super(const SettingsState.initial()) {
    on<_LoadSettingsEvent>(_onLoadSettingsEvent);
    on<_SelectAaptPathSettingsEvent>(_onSelectAaptPathSettingsEvent);
    on<_SaveSettingsEvent>(_onSaveSettingsEvent);
    Localiz.l10n.then((l10n) {
      _S = l10n;
    });
  }

  final PreferencesRepository _pref;
  late final AppLocalizations _S;

  FutureOr<void> _onLoadSettingsEvent(
      _LoadSettingsEvent event, Emitter<SettingsState> emit) async {
    logger.d('_LoadSettingsEvent');
    final aaptPath = await _pref.getAaptPath();
    emit.call(SettingsState.load(
      aaptPath: aaptPath ?? '',
    ));
  }

  FutureOr<void> _onSelectAaptPathSettingsEvent(
      _SelectAaptPathSettingsEvent event, Emitter<SettingsState> emit) async {
    logger.d('_SelectAaptPathSettingsEvent');
    final aaptDirPath = await FilePicker.platform.getDirectoryPath(
      dialogTitle: _S.settings_select_aapt_path,
      lockParentWindow: true,
    );
    final aaptPath = await AaptUtil.getAaptApp(aaptDirPath);
    if (aaptPath != null) {
      logger.d('_SelectAaptPathSettingsEvent >> $aaptPath');
      emit.call(SettingsState.selectAaptPath(
        aaptPath: aaptPath,
      ));
    } else {
      logger.d('_SelectAaptPathSettingsEvent >> no select');
      emit.call(SettingsState.error(
        error: _S.error_aapt_path,
      ));
    }
  }

  FutureOr<void> _onSaveSettingsEvent(
      _SaveSettingsEvent event, Emitter<SettingsState> emit) async {
    final aaptPath = event.aaptPath;
    logger.d('_SaveSettingsEvent >> $aaptPath');
    await _pref.setAaptPath(aaptPath);
    emit.call(const SettingsState.success());
  }
}
