// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'apk_info_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ApkInfoEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? errorMsg) errorMsg,
    required TResult Function() openFiles,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? errorMsg)? errorMsg,
    TResult? Function()? openFiles,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? errorMsg)? errorMsg,
    TResult Function()? openFiles,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MsgErrorApkInfoEvent value) errorMsg,
    required TResult Function(OpenFilesApkInfoEvent value) openFiles,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MsgErrorApkInfoEvent value)? errorMsg,
    TResult? Function(OpenFilesApkInfoEvent value)? openFiles,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MsgErrorApkInfoEvent value)? errorMsg,
    TResult Function(OpenFilesApkInfoEvent value)? openFiles,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApkInfoEventCopyWith<$Res> {
  factory $ApkInfoEventCopyWith(
          ApkInfoEvent value, $Res Function(ApkInfoEvent) then) =
      _$ApkInfoEventCopyWithImpl<$Res, ApkInfoEvent>;
}

/// @nodoc
class _$ApkInfoEventCopyWithImpl<$Res, $Val extends ApkInfoEvent>
    implements $ApkInfoEventCopyWith<$Res> {
  _$ApkInfoEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$MsgErrorApkInfoEventCopyWith<$Res> {
  factory _$$MsgErrorApkInfoEventCopyWith(_$MsgErrorApkInfoEvent value,
          $Res Function(_$MsgErrorApkInfoEvent) then) =
      __$$MsgErrorApkInfoEventCopyWithImpl<$Res>;
  @useResult
  $Res call({String? errorMsg});
}

/// @nodoc
class __$$MsgErrorApkInfoEventCopyWithImpl<$Res>
    extends _$ApkInfoEventCopyWithImpl<$Res, _$MsgErrorApkInfoEvent>
    implements _$$MsgErrorApkInfoEventCopyWith<$Res> {
  __$$MsgErrorApkInfoEventCopyWithImpl(_$MsgErrorApkInfoEvent _value,
      $Res Function(_$MsgErrorApkInfoEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorMsg = freezed,
  }) {
    return _then(_$MsgErrorApkInfoEvent(
      freezed == errorMsg
          ? _value.errorMsg
          : errorMsg // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$MsgErrorApkInfoEvent implements MsgErrorApkInfoEvent {
  const _$MsgErrorApkInfoEvent(this.errorMsg);

  @override
  final String? errorMsg;

  @override
  String toString() {
    return 'ApkInfoEvent.errorMsg(errorMsg: $errorMsg)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MsgErrorApkInfoEvent &&
            (identical(other.errorMsg, errorMsg) ||
                other.errorMsg == errorMsg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMsg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MsgErrorApkInfoEventCopyWith<_$MsgErrorApkInfoEvent> get copyWith =>
      __$$MsgErrorApkInfoEventCopyWithImpl<_$MsgErrorApkInfoEvent>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? errorMsg) errorMsg,
    required TResult Function() openFiles,
  }) {
    return errorMsg(this.errorMsg);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? errorMsg)? errorMsg,
    TResult? Function()? openFiles,
  }) {
    return errorMsg?.call(this.errorMsg);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? errorMsg)? errorMsg,
    TResult Function()? openFiles,
    required TResult orElse(),
  }) {
    if (errorMsg != null) {
      return errorMsg(this.errorMsg);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MsgErrorApkInfoEvent value) errorMsg,
    required TResult Function(OpenFilesApkInfoEvent value) openFiles,
  }) {
    return errorMsg(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MsgErrorApkInfoEvent value)? errorMsg,
    TResult? Function(OpenFilesApkInfoEvent value)? openFiles,
  }) {
    return errorMsg?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MsgErrorApkInfoEvent value)? errorMsg,
    TResult Function(OpenFilesApkInfoEvent value)? openFiles,
    required TResult orElse(),
  }) {
    if (errorMsg != null) {
      return errorMsg(this);
    }
    return orElse();
  }
}

abstract class MsgErrorApkInfoEvent implements ApkInfoEvent {
  const factory MsgErrorApkInfoEvent(final String? errorMsg) =
      _$MsgErrorApkInfoEvent;

  String? get errorMsg;
  @JsonKey(ignore: true)
  _$$MsgErrorApkInfoEventCopyWith<_$MsgErrorApkInfoEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OpenFilesApkInfoEventCopyWith<$Res> {
  factory _$$OpenFilesApkInfoEventCopyWith(_$OpenFilesApkInfoEvent value,
          $Res Function(_$OpenFilesApkInfoEvent) then) =
      __$$OpenFilesApkInfoEventCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OpenFilesApkInfoEventCopyWithImpl<$Res>
    extends _$ApkInfoEventCopyWithImpl<$Res, _$OpenFilesApkInfoEvent>
    implements _$$OpenFilesApkInfoEventCopyWith<$Res> {
  __$$OpenFilesApkInfoEventCopyWithImpl(_$OpenFilesApkInfoEvent _value,
      $Res Function(_$OpenFilesApkInfoEvent) _then)
      : super(_value, _then);
}

/// @nodoc

class _$OpenFilesApkInfoEvent implements OpenFilesApkInfoEvent {
  const _$OpenFilesApkInfoEvent();

  @override
  String toString() {
    return 'ApkInfoEvent.openFiles()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$OpenFilesApkInfoEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? errorMsg) errorMsg,
    required TResult Function() openFiles,
  }) {
    return openFiles();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? errorMsg)? errorMsg,
    TResult? Function()? openFiles,
  }) {
    return openFiles?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? errorMsg)? errorMsg,
    TResult Function()? openFiles,
    required TResult orElse(),
  }) {
    if (openFiles != null) {
      return openFiles();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MsgErrorApkInfoEvent value) errorMsg,
    required TResult Function(OpenFilesApkInfoEvent value) openFiles,
  }) {
    return openFiles(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MsgErrorApkInfoEvent value)? errorMsg,
    TResult? Function(OpenFilesApkInfoEvent value)? openFiles,
  }) {
    return openFiles?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MsgErrorApkInfoEvent value)? errorMsg,
    TResult Function(OpenFilesApkInfoEvent value)? openFiles,
    required TResult orElse(),
  }) {
    if (openFiles != null) {
      return openFiles(this);
    }
    return orElse();
  }
}

abstract class OpenFilesApkInfoEvent implements ApkInfoEvent {
  const factory OpenFilesApkInfoEvent() = _$OpenFilesApkInfoEvent;
}

/// @nodoc
mixin _$ApkInfoState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function(List<ApkInfo>? listInfo) load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function(List<ApkInfo>? listInfo)? load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(List<ApkInfo>? listInfo)? load,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ApkInfoInitial value) init,
    required TResult Function(ApkInfoLoad value) load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ApkInfoInitial value)? init,
    TResult? Function(ApkInfoLoad value)? load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ApkInfoInitial value)? init,
    TResult Function(ApkInfoLoad value)? load,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApkInfoStateCopyWith<$Res> {
  factory $ApkInfoStateCopyWith(
          ApkInfoState value, $Res Function(ApkInfoState) then) =
      _$ApkInfoStateCopyWithImpl<$Res, ApkInfoState>;
}

/// @nodoc
class _$ApkInfoStateCopyWithImpl<$Res, $Val extends ApkInfoState>
    implements $ApkInfoStateCopyWith<$Res> {
  _$ApkInfoStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ApkInfoInitialCopyWith<$Res> {
  factory _$$ApkInfoInitialCopyWith(
          _$ApkInfoInitial value, $Res Function(_$ApkInfoInitial) then) =
      __$$ApkInfoInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ApkInfoInitialCopyWithImpl<$Res>
    extends _$ApkInfoStateCopyWithImpl<$Res, _$ApkInfoInitial>
    implements _$$ApkInfoInitialCopyWith<$Res> {
  __$$ApkInfoInitialCopyWithImpl(
      _$ApkInfoInitial _value, $Res Function(_$ApkInfoInitial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ApkInfoInitial implements ApkInfoInitial {
  const _$ApkInfoInitial();

  @override
  String toString() {
    return 'ApkInfoState.init()';
  }

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function(List<ApkInfo>? listInfo) load,
  }) {
    return init();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function(List<ApkInfo>? listInfo)? load,
  }) {
    return init?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(List<ApkInfo>? listInfo)? load,
    required TResult orElse(),
  }) {
    if (init != null) {
      return init();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ApkInfoInitial value) init,
    required TResult Function(ApkInfoLoad value) load,
  }) {
    return init(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ApkInfoInitial value)? init,
    TResult? Function(ApkInfoLoad value)? load,
  }) {
    return init?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ApkInfoInitial value)? init,
    TResult Function(ApkInfoLoad value)? load,
    required TResult orElse(),
  }) {
    if (init != null) {
      return init(this);
    }
    return orElse();
  }
}

abstract class ApkInfoInitial implements ApkInfoState {
  const factory ApkInfoInitial() = _$ApkInfoInitial;
}

/// @nodoc
abstract class _$$ApkInfoLoadCopyWith<$Res> {
  factory _$$ApkInfoLoadCopyWith(
          _$ApkInfoLoad value, $Res Function(_$ApkInfoLoad) then) =
      __$$ApkInfoLoadCopyWithImpl<$Res>;
  @useResult
  $Res call({List<ApkInfo>? listInfo});
}

/// @nodoc
class __$$ApkInfoLoadCopyWithImpl<$Res>
    extends _$ApkInfoStateCopyWithImpl<$Res, _$ApkInfoLoad>
    implements _$$ApkInfoLoadCopyWith<$Res> {
  __$$ApkInfoLoadCopyWithImpl(
      _$ApkInfoLoad _value, $Res Function(_$ApkInfoLoad) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listInfo = freezed,
  }) {
    return _then(_$ApkInfoLoad(
      listInfo: freezed == listInfo
          ? _value._listInfo
          : listInfo // ignore: cast_nullable_to_non_nullable
              as List<ApkInfo>?,
    ));
  }
}

/// @nodoc

class _$ApkInfoLoad implements ApkInfoLoad {
  const _$ApkInfoLoad({final List<ApkInfo>? listInfo}) : _listInfo = listInfo;

  final List<ApkInfo>? _listInfo;
  @override
  List<ApkInfo>? get listInfo {
    final value = _listInfo;
    if (value == null) return null;
    if (_listInfo is EqualUnmodifiableListView) return _listInfo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ApkInfoState.load(listInfo: $listInfo)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApkInfoLoadCopyWith<_$ApkInfoLoad> get copyWith =>
      __$$ApkInfoLoadCopyWithImpl<_$ApkInfoLoad>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function(List<ApkInfo>? listInfo) load,
  }) {
    return load(listInfo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function(List<ApkInfo>? listInfo)? load,
  }) {
    return load?.call(listInfo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(List<ApkInfo>? listInfo)? load,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(listInfo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ApkInfoInitial value) init,
    required TResult Function(ApkInfoLoad value) load,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ApkInfoInitial value)? init,
    TResult? Function(ApkInfoLoad value)? load,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ApkInfoInitial value)? init,
    TResult Function(ApkInfoLoad value)? load,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class ApkInfoLoad implements ApkInfoState {
  const factory ApkInfoLoad({final List<ApkInfo>? listInfo}) = _$ApkInfoLoad;

  List<ApkInfo>? get listInfo;
  @JsonKey(ignore: true)
  _$$ApkInfoLoadCopyWith<_$ApkInfoLoad> get copyWith =>
      throw _privateConstructorUsedError;
}
