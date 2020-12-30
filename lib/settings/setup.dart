part of 'settings.dart';

@immutable
class DenyListEntry extends Equatable implements _Serializable {
  final String name;
  final bool keepFirst;

  const DenyListEntry(
    this.name, {
    this.keepFirst = false,
  });

  DenyListEntry.fromMap(Map<String, dynamic> map)
      : this(
          map['name'],
          keepFirst: map['keepFirst'],
        );

  @override
  List<Object> get props => [name, keepFirst];

  @override
  String toString() {
    return name;
  }

  @override
  Map<String, dynamic> toMap() => {
        'name': name,
        'keepFirst': keepFirst,
      };
}

@immutable
class MeetingSetupSettings extends Equatable implements _Serializable {
  static const String _kKeyDenyList = 'denyList';

  final Set<DenyListEntry> denyList;

  const MeetingSetupSettings({
    this.denyList = const <DenyListEntry>{},
  });

  MeetingSetupSettings copyWith({Set<DenyListEntry> denyList}) =>
      MeetingSetupSettings(
        denyList: denyList ?? this.denyList,
      );

  MeetingSetupSettings addToDenyList(Iterable<DenyListEntry> names) {
    return copyWith(
      denyList: <DenyListEntry>{
        ...denyList,
        ...names,
      },
    );
  }

  MeetingSetupSettings.fromMap(Map<String, dynamic> map)
      : this(
          denyList: {
            for (var it in map[_kKeyDenyList]) DenyListEntry.fromMap(it)
          },
        );

  Map<String, dynamic> toMap() => {
        _kKeyDenyList: [for (var it in denyList) it.toMap()],
      };

  @override
  List<Object> get props => [denyList];
}

class MeetingSetupStore extends _SettingsStore<MeetingSetupSettings> {
  const MeetingSetupStore({
    _Deserializer<MeetingSetupSettings> deserializer,
    String boxName,
    String key,
  }) : super(
          deserializer: deserializer,
          boxName: boxName,
          key: key,
          initialValue: const MeetingSetupSettings(),
        );

  void addToDenyList(Iterable<DenyListEntry> items) {
    _set(get().addToDenyList(items));
  }
}
