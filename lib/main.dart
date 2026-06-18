import 'models/animal.dart';
import 'models/perro.dart';
import 'models/gato.dart';

void main() {
  // Lista de tipo padre que almacena objetos hijos (POLIMORFISMO)
  List<Animal> animales = [
    Perro('Toby', 2),
    Gato('Luna', 3),
  ];

  for (Animal animal in animales) {
    // Ejecución dinámica: cada objeto usa SU PROPIA versión de hacerSonido()
    animal.hacerSonido();

    // CASTING con is / as
    if (animal is Perro) {
      (animal as Perro).buscarPelota();
    } else if (animal is Gato) {
      (animal as Gato).ronronear();
    }
  }

  // --- Parámetros posicionales vs nombrados ---
  Animal mascota = animales[0];

  // Posicionales: el orden importa, no se pueden omitir
  mascota.describir('café', 12);

  // Nombrados: el orden no importa, se identifican por nombre
  mascota.registrarVisita(veterinaria: 'VetCare', motivo: 'vacunación');
  mascota.registrarVisita(veterinaria: 'VetCare'); // 'motivo' usa su valor por defecto

  // COMPARACIÓN:
  // - describir(color, peso)      -> posicionales: hay que respetar el orden y pasar ambos valores.
  // - registrarVisita(...)        -> nombrados: se puede omitir 'motivo' y el orden no afecta el resultado.
}