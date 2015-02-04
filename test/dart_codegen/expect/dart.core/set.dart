part of dart.core;

abstract class Set<E> extends IterableBase<E> implements EfficientLength {
  factory Set() = LinkedHashSet<E>;
  factory Set.identity() = LinkedHashSet<E>.identity;
  factory Set.from(Iterable elements) = LinkedHashSet<E>.from;
  Iterator<E> get iterator;
  bool contains(Object value);
  bool add(E value);
  void addAll(Iterable<E> elements);
  bool remove(Object value);
  E lookup(Object object);
  void removeAll(Iterable<Object> elements);
  void retainAll(Iterable<Object> elements);
  void removeWhere(bool test(E element));
  void retainWhere(bool test(E element));
  bool containsAll(Iterable<Object> other);
  Set<E> intersection(Set<Object> other);
  Set<E> union(Set<E> other);
  Set<E> difference(Set<E> other);
  void clear();
  Set<E> toSet();
}
