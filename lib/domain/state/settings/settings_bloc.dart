import 'dart:async';

import 'package:apk_renamer/internal/localiz.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:renamer_lib/model/keys.dart';
import 'package:renamer_lib/repository/rename_controller.dart';

import '../../../data/model/settings_obj.dart';
import '../../../data/rename_isolate/rename_isolate.dart';
import '../../../data/repository/preferences_repository.dart';
import '../../../logger.dart';

part 'settings_bloc.freezed.dart';
part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc(this._pref, this._renameIsolate) : super(const SettingsState.initial()) {
    on<_LoadSettingsEvent>(_onLoadSettingsEvent);
    on<_SaveSettingsEvent>(_onSaveSettingsEvent);
    Localiz.l10n.then((l10n) {
      _S = l10n;
    });
  }

  final PreferencesRepository _pref;
  final RenameIsolate _renameIsolate;
  late final AppLocalizations _S;

  FutureOr<void> _onLoadSettingsEvent(
      _LoadSettingsEvent event, Emitter<SettingsState> emit) async {
    logger.d('_LoadSettingsEvent');
    final countSuffix = await _pref.getCountSuffix();
    emit.call(SettingsState.load(
      countSuffix: countSuffix ?? RenameController.defaultCountSuffix,
    ));
  }

  FutureOr<void> _onSaveSettingsEvent(
      _SaveSettingsEvent event, Emitter<SettingsState> emit) async {
    final countSuffix = event.countSuffix.trimRight();
    logger.d('_SaveSettingsEvent >> $countSuffix');
    if (countSuffix.contains(Keys2.countSuffix)) {
      await _pref.setCountSuffix(countSuffix);
      await _renameIsolate.updateSettings(SettingsObj.update(
        countSuffix: countSuffix,
      ));
      emit.call(const SettingsState.success());
    } else {
      emit.call(SettingsState.error(
        error: _S.error_suffix_not_found,
      ));
    }
  }
}
