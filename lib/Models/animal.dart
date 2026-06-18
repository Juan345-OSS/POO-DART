class Animal {
  String nombre;
  int edad;

  Animal(this.nombre, this.edad);

  void hacerSonido() {
    print('$nombre hace un sonido genérico de animal');
  }

  // Método con parámetros POSICIONALES
  void describir(String color, int peso) {
    print('$nombre es de color $color y pesa $peso kg');
  }

  // Método con parámetros NOMBRADOS
  void registrarVisita({required String veterinaria, String motivo = 'chequeo general'}) {
    print('$nombre visitó la veterinaria $veterinaria por: $motivo');
  }
}