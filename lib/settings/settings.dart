import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'setup.dart';

typedef _Deserializer<T> = T Function(Map<String, dynamic> map);

abstract class _Serializable {
  Map<String, dynamic> toMap();
}

abstract class _SettingsStore<T extends _Serializable> {
  final _Deserializer<T> _deserializer;
  final String _boxName;
  final String _key;
  final T _initialValue;

  Box get _box => Hive.box(_boxName);

  const _SettingsStore({
    @required String boxName,
    @required _Deserializer<T> deserializer,
    @required T initialValue,
    @required String key,
  })  : _deserializer = deserializer,
        _boxName = boxName,
        _key = key,
        _initialValue = initialValue;

  T get() {
    final stored = _box.get(_key);
    if (stored == null) {
      return _initialValue;
    }
    return _deserializer(stored);
  }

  void _set(T value) {
    _box.put(_key, value.toMap());
  }
}

class SettingsRepository {
  final MeetingSetupStore meetingSetup = MeetingSetupStore(
    boxName: 'settings',
    key: 'meetingSetup',
    deserializer: (map) => MeetingSetupSettings.fromMap(map),
  );
}
