import "dart:collection" show Queue;

class FileryStack<T> {
  final Queue<T> _underlyingQueue;

  FileryStack() : this._underlyingQueue = Queue<T>();

  int get length => this._underlyingQueue.length;
  bool get isEmpty => this._underlyingQueue.isEmpty;
  bool get isNotEmpty => this._underlyingQueue.isNotEmpty;
  List<T> get data => this._underlyingQueue.map((e) => e).toList();

  void clear() => this._underlyingQueue.clear();

  void populate(T element, int queueSize) {
    if (isEmpty) {
      for (int i = 0; i <= queueSize; i++) {
        this.push(element);
      }
    }
  }

  T? peek() {
    if (this.isEmpty) {
      return null;
    }
    return this._underlyingQueue.last;
  }

  T pop() {
    if (this.isEmpty) {
      throw StateError("Cannot pop() on empty Filerystack.");
    }
    return this._underlyingQueue.removeFirst();
  }

  T pushAndPop(final T element) {
    this.push(element);
    return this.pop();
  }

  void push(final T element) => this._underlyingQueue.addLast(element);

  @override
  String toString() => 'FileryStack(_underlyingQueue: $_underlyingQueue)';
}
