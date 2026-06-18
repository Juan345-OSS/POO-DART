# Análisis del Código — Proyecto POO en Dart

**Autor:** Juan Romero

## 1. ¿Qué hace cada clase y por qué fue diseñada así?

Las clases desarrolladas son `Animal`, `Perro` y `Gato`. `Animal` es la clase padre y contiene lo que todos los animales del programa tienen en común: los atributos `nombre` y `edad`, un método genérico `hacerSonido()`, y los métodos `describir()` y `registrarVisita()` para trabajar parámetros posicionales y nombrados. `Perro` y `Gato` heredan de `Animal` y solo agregan lo que las hace distintas: `Perro` sobreescribe `hacerSonido()` y además tiene sus propios métodos `buscarPelota()` y `ladrarFuerte()`; `Gato` sobreescribe `hacerSonido()` y tiene su propio método `ronronear()`. Se diseñaron así para reutilizar en el padre todo el código común y dejar en cada hija solo su comportamiento particular, aplicando los conceptos de herencia, sobreescritura, polimorfismo y parámetros pedidos en la guía.

## 2. ¿Qué pasaría si eliminas @override?

`@override` no es obligatorio para que la sobreescritura funcione: si el método sigue con el mismo nombre y la misma firma que el de la clase padre, el programa sigue funcionando exactamente igual aunque se quite la anotación. Lo que realmente se pierde es la verificación del compilador. Por ejemplo, si por error escribo mal el nombre del método (como `hacerSonidoo()` en vez de `hacerSonido()`) y dejo `@override`, Dart marca un error de compilación porque no encuentra nada que sobreescribir. Pero si quito `@override` y dejo ese mismo error de tipeo, el programa compila sin avisar nada, y en tiempo de ejecución termina usando el sonido genérico de `Animal` en vez del de `Perro`, porque en realidad creé un método nuevo que nadie llama. Entonces `@override` no cambia el comportamiento normal, pero sí ayuda a detectar errores a tiempo.

## 3. Explica en tus palabras cómo funciona el polimorfismo en tu código

En mi código tengo `List<Animal> animales = [Perro(...), Gato(...)]`, es decir, una lista declarada con el tipo del padre pero que guarda objetos de las clases hijas. Cuando recorro esa lista con un `for` y llamo `animal.hacerSonido()`, Dart no ejecuta el método de `Animal`, sino la versión sobreescrita que corresponde al objeto real que hay en cada posición: si es un `Perro`, suena como perro, y si es un `Gato`, suena como gato. Eso es el polimorfismo: el mismo método se comporta distinto según el objeto, y se decide en tiempo de ejecución, no según el tipo con el que declaré la variable.

## 4. ¿Dónde aplicaste casting y por qué fue necesario?

Aplico el casting dentro del `for`, en el `main`, después de validar el tipo con `is`:

```dart
if (animal is Perro) {
  (animal as Perro).buscarPelota();
  (animal as Perro).ladrarFuerte();
} else if (animal is Gato) {
  (animal as Gato).ronronear();
}
```

Fue necesario porque `buscarPelota()` y `ladrarFuerte()` no existen en `Animal`, solo en `Perro`; igual `ronronear()` solo existe en `Gato`. Como la variable `animal` está declarada de tipo `Animal`, Dart no me deja llamar directamente esos métodos exclusivos sin antes convertir (hacer casting) el objeto al tipo específico al que realmente pertenece.

## 5. ¿Qué diferencia real viste entre parámetros nombrados y posicionales?

Los parámetros posicionales son obligatorios y deben ir en el orden exacto en que los declaré; lo viví en `mascota.describir('café', 12)`, donde si cambio el orden de los valores el resultado sale mal. Los parámetros nombrados, en cambio, se declaran entre llaves `{ }` y se identifican por su nombre en la llamada, por lo que pude pasarlos en cualquier orden e incluso omitir `motivo` en `mascota.registrarVisita(veterinaria: 'VetCare')`, porque tiene un valor por defecto. Son opcionales por defecto, a menos que se marquen con `required`, y mejoran la legibilidad cuando hay varios parámetros.

## 6. Modifica el código

Modifiqué la clase `Gato` cambiando el mensaje de su método `hacerSonido()`, y modifiqué la clase `Perro` agregándole un método nuevo, `ladrarFuerte()`.

## 7. Cambia el comportamiento de una clase hija

La clase a la que le cambié el comportamiento fue `Gato`: en vez de imprimir el sonido genérico, ahora `hacerSonido()` imprime "¡Miau, dame comida!". Además le agregué a `Perro` el método `ladrarFuerte()`, y en el `main` lo llamé usando casting, junto con `buscarPelota()`.

## 8. Explica qué ocurrió

Al correr el programa, Luna (el objeto de tipo `Gato`) imprimió el nuevo mensaje "¡Miau, dame comida!" sin afectar para nada a `Animal` ni a `Perro`, lo que confirma que cada clase hija sobreescribe su propio comportamiento de forma independiente. Toby (el objeto de tipo `Perro`) ejecutó tanto `buscarPelota()` como el método nuevo `ladrarFuerte()`, lo que muestra que las clases hijas pueden tener métodos propios, exclusivos, que no existen en la clase padre ni en las demás hijas, y a los que solo se puede acceder haciendo casting.

```
[Running]
Toby (perro) dice: ¡Guau guau!
Toby está buscando la pelota
Toby está ladrando fuertísimo: ¡GUAU GUAU GUAU!
Luna (gato) dice: ¡Miau, dame comida!
Luna está ronroneando
Toby es de color café y pesa 12 kg
Toby visitó la veterinaria VetCare por: vacunación
Toby visitó la veterinaria VetCare por: chequeo general
[Done] exited with code=0
```