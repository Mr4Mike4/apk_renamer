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
    required TResult Function(String replacePattern) updateFilesInfo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? errorMsg)? errorMsg,
    TResult? Function()? openFiles,
    TResult? Function(String replacePattern)? updateFilesInfo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? errorMsg)? errorMsg,
    TResult Function()? openFiles,
    TResult Function(String replacePattern)? updateFilesInfo,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MsgErrorApkInfoEvent value) errorMsg,
    required TResult Function(OpenFilesApkInfoEvent value) openFiles,
    required TResult Function(UpdateFilesInfoEvent value) updateFilesInfo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MsgErrorApkInfoEvent value)? errorMsg,
    TResult? Function(OpenFilesApkInfoEvent value)? openFiles,
    TResult? Function(UpdateFilesInfoEvent value)? updateFilesInfo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MsgErrorApkInfoEvent value)? errorMsg,
    TResult Function(OpenFilesApkInfoEvent value)? openFiles,
    TResult Function(UpdateFilesInfoEvent value)? updateFilesInfo,
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
abstract class _$$MsgErrorApkInfoEventImplCopyWith<$Res> {
  factory _$$MsgErrorApkInfoEventImplCopyWith(_$MsgErrorApkInfoEventImpl value,
          $Res Function(_$MsgErrorApkInfoEventImpl) then) =
      __$$MsgErrorApkInfoEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? errorMsg});
}

/// @nodoc
class __$$MsgErrorApkInfoEventImplCopyWithImpl<$Res>
    extends _$ApkInfoEventCopyWithImpl<$Res, _$MsgErrorApkInfoEventImpl>
    implements _$$MsgErrorApkInfoEventImplCopyWith<$Res> {
  __$$MsgErrorApkInfoEventImplCopyWithImpl(_$MsgErrorApkInfoEventImpl _value,
      $Res Function(_$MsgErrorApkInfoEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorMsg = freezed,
  }) {
    return _then(_$MsgErrorApkInfoEventImpl(
      freezed == errorMsg
          ? _value.errorMsg
          : errorMsg // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$MsgErrorApkInfoEventImpl implements MsgErrorApkInfoEvent {
  const _$MsgErrorApkInfoEventImpl(this.errorMsg);

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
            other is _$MsgErrorApkInfoEventImpl &&
            (identical(other.errorMsg, errorMsg) ||
                other.errorMsg == errorMsg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMsg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MsgErrorApkInfoEventImplCopyWith<_$MsgErrorApkInfoEventImpl>
      get copyWith =>
          __$$MsgErrorApkInfoEventImplCopyWithImpl<_$MsgErrorApkInfoEventImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? errorMsg) errorMsg,
    required TResult Function() openFiles,
    required TResult Function(String replacePattern) updateFilesInfo,
  }) {
    return errorMsg(this.errorMsg);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? errorMsg)? errorMsg,
    TResult? Function()? openFiles,
    TResult? Function(String replacePattern)? updateFilesInfo,
  }) {
    return errorMsg?.call(this.errorMsg);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? errorMsg)? errorMsg,
    TResult Function()? openFiles,
    TResult Function(String replacePattern)? updateFilesInfo,
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
    required TResult Function(UpdateFilesInfoEvent value) updateFilesInfo,
  }) {
    return errorMsg(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MsgErrorApkInfoEvent value)? errorMsg,
    TResult? Function(OpenFilesApkInfoEvent value)? openFiles,
    TResult? Function(UpdateFilesInfoEvent value)? updateFilesInfo,
  }) {
    return errorMsg?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MsgErrorApkInfoEvent value)? errorMsg,
    TResult Function(OpenFilesApkInfoEvent value)? openFiles,
    TResult Function(UpdateFilesInfoEvent value)? updateFilesInfo,
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
      _$MsgErrorApkInfoEventImpl;

  String? get errorMsg;
  @JsonKey(ignore: true)
  _$$MsgErrorApkInfoEventImplCopyWith<_$MsgErrorApkInfoEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OpenFilesApkInfoEventImplCopyWith<$Res> {
  factory _$$OpenFilesApkInfoEventImplCopyWith(
          _$OpenFilesApkInfoEventImpl value,
          $Res Function(_$OpenFilesApkInfoEventImpl) then) =
      __$$OpenFilesApkInfoEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OpenFilesApkInfoEventImplCopyWithImpl<$Res>
    extends _$ApkInfoEventCopyWithImpl<$Res, _$OpenFilesApkInfoEventImpl>
    implements _$$OpenFilesApkInfoEventImplCopyWith<$Res> {
  __$$OpenFilesApkInfoEventImplCopyWithImpl(_$OpenFilesApkInfoEventImpl _value,
      $Res Function(_$OpenFilesApkInfoEventImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$OpenFilesApkInfoEventImpl implements OpenFilesApkInfoEvent {
  const _$OpenFilesApkInfoEventImpl();

  @override
  String toString() {
    return 'ApkInfoEvent.openFiles()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OpenFilesApkInfoEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? errorMsg) errorMsg,
    required TResult Function() openFiles,
    required TResult Function(String replacePattern) updateFilesInfo,
  }) {
    return openFiles();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? errorMsg)? errorMsg,
    TResult? Function()? openFiles,
    TResult? Function(String replacePattern)? updateFilesInfo,
  }) {
    return openFiles?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? errorMsg)? errorMsg,
    TResult Function()? openFiles,
    TResult Function(String replacePattern)? updateFilesInfo,
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
    required TResult Function(UpdateFilesInfoEvent value) updateFilesInfo,
  }) {
    return openFiles(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MsgErrorApkInfoEvent value)? errorMsg,
    TResult? Function(OpenFilesApkInfoEvent value)? openFiles,
    TResult? Function(UpdateFilesInfoEvent value)? updateFilesInfo,
  }) {
    return openFiles?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MsgErrorApkInfoEvent value)? errorMsg,
    TResult Function(OpenFilesApkInfoEvent value)? openFiles,
    TResult Function(UpdateFilesInfoEvent value)? updateFilesInfo,
    required TResult orElse(),
  }) {
    if (openFiles != null) {
      return openFiles(this);
    }
    return orElse();
  }
}

abstract class OpenFilesApkInfoEvent implements ApkInfoEvent {
  const factory OpenFilesApkInfoEvent() = _$OpenFilesApkInfoEventImpl;
}

/// @nodoc
abstract class _$$UpdateFilesInfoEventImplCopyWith<$Res> {
  factory _$$UpdateFilesInfoEventImplCopyWith(_$UpdateFilesInfoEventImpl value,
          $Res Function(_$UpdateFilesInfoEventImpl) then) =
      __$$UpdateFilesInfoEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String replacePattern});
}

/// @nodoc
class __$$UpdateFilesInfoEventImplCopyWithImpl<$Res>
    extends _$ApkInfoEventCopyWithImpl<$Res, _$UpdateFilesInfoEventImpl>
    implements _$$UpdateFilesInfoEventImplCopyWith<$Res> {
  __$$UpdateFilesInfoEventImplCopyWithImpl(_$UpdateFilesInfoEventImpl _value,
      $Res Function(_$UpdateFilesInfoEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? replacePattern = null,
  }) {
    return _then(_$UpdateFilesInfoEventImpl(
      replacePattern: null == replacePattern
          ? _value.replacePattern
          : replacePattern // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UpdateFilesInfoEventImpl implements UpdateFilesInfoEvent {
  const _$UpdateFilesInfoEventImpl({required this.replacePattern});

  @override
  final String replacePattern;

  @override
  String toString() {
    return 'ApkInfoEvent.updateFilesInfo(replacePattern: $replacePattern)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateFilesInfoEventImpl &&
            (identical(other.replacePattern, replacePattern) ||
                other.replacePattern == replacePattern));
  }

  @override
  int get hashCode => Object.hash(runtimeType, replacePattern);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateFilesInfoEventImplCopyWith<_$UpdateFilesInfoEventImpl>
      get copyWith =>
          __$$UpdateFilesInfoEventImplCopyWithImpl<_$UpdateFilesInfoEventImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? errorMsg) errorMsg,
    required TResult Function() openFiles,
    required TResult Function(String replacePattern) updateFilesInfo,
  }) {
    return updateFilesInfo(replacePattern);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? errorMsg)? errorMsg,
    TResult? Function()? openFiles,
    TResult? Function(String replacePattern)? updateFilesInfo,
  }) {
    return updateFilesInfo?.call(replacePattern);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? errorMsg)? errorMsg,
    TResult Function()? openFiles,
    TResult Function(String replacePattern)? updateFilesInfo,
    required TResult orElse(),
  }) {
    if (updateFilesInfo != null) {
      return updateFilesInfo(replacePattern);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MsgErrorApkInfoEvent value) errorMsg,
    required TResult Function(OpenFilesApkInfoEvent value) openFiles,
    required TResult Function(UpdateFilesInfoEvent value) updateFilesInfo,
  }) {
    return updateFilesInfo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MsgErrorApkInfoEvent value)? errorMsg,
    TResult? Function(OpenFilesApkInfoEvent value)? openFiles,
    TResult? Function(UpdateFilesInfoEvent value)? updateFilesInfo,
  }) {
    return updateFilesInfo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MsgErrorApkInfoEvent value)? errorMsg,
    TResult Function(OpenFilesApkInfoEvent value)? openFiles,
    TResult Function(UpdateFilesInfoEvent value)? updateFilesInfo,
    required TResult orElse(),
  }) {
    if (updateFilesInfo != null) {
      return updateFilesInfo(this);
    }
    return orElse();
  }
}

abstract class UpdateFilesInfoEvent implements ApkInfoEvent {
  const factory UpdateFilesInfoEvent({required final String replacePattern}) =
      _$UpdateFilesInfoEventImpl;

  String get replacePattern;
  @JsonKey(ignore: true)
  _$$UpdateFilesInfoEventImplCopyWith<_$UpdateFilesInfoEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ApkInfoState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function(List<FileInfo>? listInfo) load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function(List<FileInfo>? listInfo)? load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(List<FileInfo>? listInfo)? load,
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
abstract class _$$ApkInfoInitialImplCopyWith<$Res> {
  factory _$$ApkInfoInitialImplCopyWith(_$ApkInfoInitialImpl value,
          $Res Function(_$ApkInfoInitialImpl) then) =
      __$$ApkInfoInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ApkInfoInitialImplCopyWithImpl<$Res>
    extends _$ApkInfoStateCopyWithImpl<$Res, _$ApkInfoInitialImpl>
    implements _$$ApkInfoInitialImplCopyWith<$Res> {
  __$$ApkInfoInitialImplCopyWithImpl(
      _$ApkInfoInitialImpl _value, $Res Function(_$ApkInfoInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ApkInfoInitialImpl implements ApkInfoInitial {
  const _$ApkInfoInitialImpl();

  @override
  String toString() {
    return 'ApkInfoState.init()';
  }

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function(List<FileInfo>? listInfo) load,
  }) {
    return init();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function(List<FileInfo>? listInfo)? load,
  }) {
    return init?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(List<FileInfo>? listInfo)? load,
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
  const factory ApkInfoInitial() = _$ApkInfoInitialImpl;
}

/// @nodoc
abstract class _$$ApkInfoLoadImplCopyWith<$Res> {
  factory _$$ApkInfoLoadImplCopyWith(
          _$ApkInfoLoadImpl value, $Res Function(_$ApkInfoLoadImpl) then) =
      __$$ApkInfoLoadImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<FileInfo>? listInfo});
}

/// @nodoc
class __$$ApkInfoLoadImplCopyWithImpl<$Res>
    extends _$ApkInfoStateCopyWithImpl<$Res, _$ApkInfoLoadImpl>
    implements _$$ApkInfoLoadImplCopyWith<$Res> {
  __$$ApkInfoLoadImplCopyWithImpl(
      _$ApkInfoLoadImpl _value, $Res Function(_$ApkInfoLoadImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listInfo = freezed,
  }) {
    return _then(_$ApkInfoLoadImpl(
      listInfo: freezed == listInfo
          ? _value.listInfo
          : listInfo // ignore: cast_nullable_to_non_nullable
              as List<FileInfo>?,
    ));
  }
}

/// @nodoc

class _$ApkInfoLoadImpl implements ApkInfoLoad {
  const _$ApkInfoLoadImpl({this.listInfo});

  @override
  final List<FileInfo>? listInfo;

  @override
  String toString() {
    return 'ApkInfoState.load(listInfo: $listInfo)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApkInfoLoadImplCopyWith<_$ApkInfoLoadImpl> get copyWith =>
      __$$ApkInfoLoadImplCopyWithImpl<_$ApkInfoLoadImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function(List<FileInfo>? listInfo) load,
  }) {
    return load(listInfo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function(List<FileInfo>? listInfo)? load,
  }) {
    return load?.call(listInfo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(List<FileInfo>? listInfo)? load,
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
  const factory ApkInfoLoad({final List<FileInfo>? listInfo}) =
      _$ApkInfoLoadImpl;

  List<FileInfo>? get listInfo;
  @JsonKey(ignore: true)
  _$$ApkInfoLoadImplCopyWith<_$ApkInfoLoadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
