import 'animal.dart';

class Gato extends Animal {
  Gato(String nombre, int edad) : super(nombre, edad);

  @override
  void hacerSonido() {
    print('$nombre (gato) dice: ¡Miau!');
  }

  void ronronear() {
    print('$nombre está ronroneando');
  }
}