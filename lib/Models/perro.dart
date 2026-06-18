import 'animal.dart';

class Perro extends Animal {
  Perro(String nombre, int edad) : super(nombre, edad);

  @override
  void hacerSonido() {
    print('$nombre (perro) dice: ¡Guau guau!');
  }

  void buscarPelota() {
    print('$nombre está buscando la pelota');
  }

  void ladrarFuerte() {
    print('$nombre está ladrando fuertísimo: ¡GUAU GUAU GUAU!');
  }
}