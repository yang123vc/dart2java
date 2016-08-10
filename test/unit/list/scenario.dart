int createAndOperatorAt() {
  var list = new List<int>();
  list.add(12);
  list.add(13);
  return list[0];
}

int simpleOperations() {
  var list = new List<int>();
  list.add(90);
  list.add(10);
  list.add(20);
  list.add(30);
  list[3] = 40;
  list.add(50);
  list.remove(40);
  int second = list.removeAt(1);
  int expected = second + list[0] + list[1] + list[2];
  return expected;
}

int triggerArrayGrowth() {
  // We don't have for loops yet...
  var list = new List<int>();
  list.add(1);
  list.add(2);
  list.add(3);
  list.add(4);
  list.add(5);
  list.add(6);
  list.add(7);
  list.add(8);
  list.add(9);
  list.add(10);
  list.add(11);
  list.add(12);
  list.add(13);
  list.add(14);
  list.add(15);
  list.add(16);
  list.add(17);
  list.add(18);
  return list[17];
}

class IntWrapper {
  int value;

  IntWrapper(this.value);
}

int listLiteral() {
  var list = <IntWrapper>[new IntWrapper(10), new IntWrapper(20)];
  int result = 0;

  for (int i = 0; i < list.length; i = i + 1) {
    result = result + list[i].value;
  }

  return result;
}