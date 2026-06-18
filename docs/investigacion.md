# Investigación: Sobreescritura de Métodos, Polimorfismo y Parámetros en Dart

**Autor:** Juan Romero
**Programa:** Servicio Nacional de Aprendizaje (SENA)
**Curso:** Programación Orientada a Objetos en Dart y Flujo de Trabajo en GitHub

## Introducción

La Programación Orientada a Objetos (POO) es uno de los paradigmas más utilizados en el desarrollo de software actual, y Dart, el lenguaje base de Flutter, lo implementa de forma completa. Este documento desarrolla tres conceptos fundamentales de la POO en Dart: la sobreescritura de métodos mediante la anotación `@override`, el polimorfismo a través de la herencia y el casting de tipos, y el uso de parámetros posicionales, nombrados y opcionales.

## 1. Sobreescritura de Métodos

### 1.1 ¿Qué es?

La sobreescritura de métodos (*method overriding*) ocurre cuando una clase hija redefine un método ya declarado en su clase padre, conservando el mismo nombre y la misma firma, pero proporcionando una implementación distinta. En Dart, una subclase puede sobreescribir métodos de instancia, getters, setters y operadores heredados de su superclase (Dart, 2025).

### 1.2 ¿Para qué sirve?

Permite que cada subclase adapte el comportamiento heredado a sus propias necesidades sin modificar el código de la clase padre. Esto favorece la reutilización de código: la lógica común permanece en la superclase, y cada subclase solo ajusta lo que la diferencia. Además, es la base que hace posible el polimorfismo.

### 1.3 Uso de `@override` en Dart

`@override` es una anotación que indica de forma explícita que un miembro está sobreescribiendo intencionalmente un miembro heredado. Su propósito es ayudar al analizador de Dart a detectar errores: si la superclase cambia o elimina el miembro que se pretende sobreescribir, el analizador puede advertir que la anotación ya no corresponde a nada. Su uso es opcional en el lenguaje, pero se recomienda como buena práctica (Dart, 2025).

### 1.4 Ejemplo funcional

```dart
class Animal {
  void hacerSonido() {
    print('Sonido genérico de animal');
  }
}

class Perro extends Animal {
  @override
  void hacerSonido() {
    print('El perro dice: ¡Guau!');
  }
}

void main() {
  Animal miAnimal = Perro();
  miAnimal.hacerSonido(); // El perro dice: ¡Guau!
}
```

Aunque `miAnimal` está declarada de tipo `Animal`, al ejecutarse el programa se invoca la versión definida en `Perro`, porque Dart resuelve el método según el tipo real del objeto en tiempo de ejecución.

## 2. Polimorfismo

### 2.1 Concepto

El polimorfismo es la capacidad que tienen objetos de distintas clases, relacionadas por herencia, de responder de manera diferente a un mismo mensaje o llamada de método, siempre que compartan una superclase común y sobreescriban el método correspondiente.

### 2.2 Variable de tipo padre que almacena objetos hijos

Dart permite declarar una variable (o un elemento de una lista) con el tipo de la clase padre y asignarle una instancia de cualquiera de sus clases hijas, porque toda subclase es a su vez un subtipo de su superclase. Esto permite construir, por ejemplo, una `List<Animal>` que contenga simultáneamente objetos `Perro` y `Gato`, tratándolos de manera uniforme.

### 2.3 Ejecución dinámica de métodos

Cuando se invoca un método sobre una variable de tipo padre que en realidad contiene un objeto de una clase hija, Dart ejecuta la versión sobreescrita correspondiente al tipo real del objeto, no la de la superclase. Este mecanismo se conoce como enlace dinámico o despacho en tiempo de ejecución, y es la manifestación concreta del polimorfismo.

### 2.4 Casting en Dart: `is` y `as`

Dart incluye operadores de prueba de tipo para verificar y convertir el tipo de un objeto en tiempo de ejecución. El operador `is` evalúa si un objeto pertenece a un tipo determinado y devuelve un booleano (`is!` comprueba lo contrario). El operador `as` realiza una conversión explícita (casting) hacia un tipo específico, y lanza una excepción si la conversión no es válida (Dart, 2026a). Son útiles dentro de jerarquías polimórficas cuando se necesita acceder a un miembro que solo existe en una subclase concreta.

### 2.5 Ejemplo práctico

```dart
class Animal {
  void hacerSonido() => print('Sonido genérico');
}

class Gato extends Animal {
  @override
  void hacerSonido() => print('El gato dice: ¡Miau!');

  void ronronear() => print('El gato está ronroneando');
}

void identificarAnimal(Animal animal) {
  animal.hacerSonido(); // polimorfismo

  if (animal is Gato) {
    // 'is' valida el tipo antes de convertir
    Gato gato = animal as Gato; // 'as' realiza el casting
    gato.ronronear();
  }
}
```

## 3. Parámetros en Dart

### 3.1 Parámetros posicionales

Son obligatorios por defecto y deben proporcionarse en el mismo orden en que fueron declarados. El compilador exige todos los argumentos posicionales requeridos en la posición correcta (Dart, 2026b).

```dart
void crear(String nombre, int edad) {
  print('$nombre tiene $edad años');
}

crear('Luna', 3); // el orden importa
```

### 3.2 Parámetros nombrados

Se declaran entre llaves `{ }` y se identifican por su nombre en la llamada, por lo que pueden pasarse en cualquier orden. Son opcionales por defecto, a menos que se marquen con `required`. Mejoran la legibilidad cuando hay varios parámetros (Dart, 2026b).

```dart
void crear({required String nombre, int edad = 1}) {
  print('$nombre tiene $edad años');
}

crear(nombre: 'Toby', edad: 2); // el orden no importa
```

### 3.3 Parámetros opcionales

Dart ofrece dos formas: posicionales opcionales (entre corchetes `[ ]`) y nombrados (opcionales por defecto entre llaves). Si un parámetro opcional no recibe un valor predeterminado, su tipo debe ser anulable, porque su valor por defecto será `null`. También puede asignarse un valor por defecto distinto de `null`, siempre que sea una constante de tiempo de compilación (Dart, 2026b).

### 3.4 Diferencias y casos de uso

La diferencia esencial es cómo se identifican: los posicionales dependen del orden, los nombrados del nombre explícito. Los posicionales son adecuados cuando hay pocos argumentos cuyo orden es evidente (por ejemplo, coordenadas x e y); los nombrados son preferibles cuando hay muchos parámetros, varios opcionales, o cuando se busca que el código sea autoexplicativo en la llamada — por eso los widgets de Flutter usan casi exclusivamente parámetros nombrados (Dart, 2026b). Dart no permite combinar, en una misma función, posicionales opcionales con nombrados: solo se puede elegir una de las dos formas para la parte opcional de la firma.

## Conclusiones

La sobreescritura de métodos, el polimorfismo y el manejo adecuado de parámetros son pilares interrelacionados de la POO en Dart. La sobreescritura permite que cada subclase personalice el comportamiento heredado; el polimorfismo aprovecha esa personalización para tratar objetos distintos de manera uniforme a través de una superclase común; y los parámetros posicionales, nombrados y opcionales determinan cómo los métodos reciben la información necesaria para ejecutarse.

## Referencias

Dart. (2025, 29 de julio). *Extend a class*. Dart.dev. https://dart.dev/language/extend

Dart. (2026a, 12 de mayo). *Operators*. Dart.dev. https://dart.dev/language/operators

Dart. (2026, 15 de mayo). *Methods*. Dart.dev. https://dart.dev/language/methods

Dart. (2026b, 26 de mayo). *Functions*. Dart.dev. https://dart.dev/language/functions