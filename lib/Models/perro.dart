import 'animal.dart';

class Perro extends Animal {
  Perro(String nombre, int edad) : super(nombre, edad);

  @override
  void hacerSonido() {
    print('$nombre (perro) dice: ¡Guau guau! y esta muerto');
  }

  void buscarPelota() {
    print('$nombre está buscando la pelota');
  }
}