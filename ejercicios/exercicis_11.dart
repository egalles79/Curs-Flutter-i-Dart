// exercicis_11.dart

// Jerarquia OK com a abstract classes
abstract class Animal {}

abstract class Mammal extends Animal {}
abstract class Bird extends Animal {}
abstract class Fish extends Animal {}

// Capacitats: han de ser mixins (sense constructors!)
mixin Walker {
  void walk() => print("I'm walking");
}

mixin Swimmer {
  void swim() => print("I'm swimming");
}

mixin Flyer {
  void fly() => print("I'm flying");
}

// Classes concretes combinant mixins
class Dolphin extends Mammal with Swimmer {}

class Bat extends Mammal with Walker, Flyer {}

class Cat extends Mammal with Walker {}

class Dove extends Bird with Walker, Flyer {}

class Duck extends Bird with Walker, Swimmer, Flyer {}

class Shark extends Fish with Swimmer {}

class FlyingFish extends Fish with Swimmer, Flyer {}

// Prova ràpida
void main() {
  final donald = Duck();
  donald.walk();
  donald.swim();
  donald.fly();

  final gatet = Cat();
  gatet.walk();

  final ff = FlyingFish();
  ff.swim();
  ff.fly();
}
