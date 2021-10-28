import 'dart:collection';

void main() {
  Queue numQ = new Queue();
  numQ.addAll([100, 200, 300]);
  numQ.add(400);
  numQ.removeFirst();
  Iterator i = numQ.iterator;

  while (i.moveNext()) {
    print(i.current);
  }
}
