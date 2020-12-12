Iterable<T> removeDuplicates<T>(Iterable<T> iterable) {
  final List<T> list = iterable.toList();
  return <T>[
    for (var entry in list.asMap().entries)
      // only retain items, which have not been encountered while iterating
      if (list.sublist(0, entry.key).where((it) => entry.value == it).isEmpty)
        entry.value
  ];
}
