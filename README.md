# exercici5

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# Exercici6

EJERCICIO 6 – JUEGO DE PRUEBAS FUNCIONALES

¿Qué es Gherkin?

Gherkin es un lenguaje que permite definir pruebas funcionales usando lenguaje natural estructurado con las palabras clave: Given, When, Then. Sirve para describir el comportamiento esperado de una aplicación desde el punto de vista del usuario.



Feature: Cámara

Scenario: Hacer una foto correctamente
  Given que la aplicación está abierta
  When el usuario pulsa el botón de hacer foto
  Then se guarda una imagen en el dispositivo

Scenario: Error sin permisos
  Given que la aplicación no tiene permisos de cámara
  When el usuario intenta hacer una foto
  Then aparece un mensaje de error

Scenario: Guardado en galería
  Given que se ha hecho una foto
  When el usuario abre la galería
  Then la imagen aparece guardada correctamente


Feature: Reproductor multimedia

  Scenario: Reproducir audio
  Given que hay un archivo cargado
  When el usuario pulsa play
  Then el audio se reproduce

Scenario: Pausar audio
  Given que el audio está en reproducción
  When el usuario pulsa pause
  Then el audio se detiene

Scenario: Archivo no válido
  Given que el archivo no es compatible
  When el usuario intenta reproducirlo
  Then aparece un error


Feature: Cálculo de camisetas

  Scenario: Precio sin descuento
  Given que el usuario introduce 2 camisetas talla M
  When no selecciona descuento
  Then se muestra el precio total

Scenario: Descuento del 10%
  Given que el usuario introduce 3 camisetas talla L
  When selecciona descuento del 10%
  Then el precio final tiene un 10% de descuento

Scenario: Descuento de 20€
  Given que el precio supera 100€
  When selecciona descuento tipo 2
  Then se descuentan 20€ del total

Scenario: Datos incompletos
  Given que no hay talla seleccionada
  When el usuario introduce cantidad
  Then no se muestra el precio


RESULTADOS DE LAS PRUEBAS

Número total de pruebas: 10
Pruebas correctas (OK): 10
Pruebas incorrectas (KO): 0
Porcentaje de éxito: 100%



# Exercici7

EJERCICIO 7 – Clasificación de pruebas

Pruebas de integración
- Hacer una foto (interacción entre hardware y aplicación)
- Reproducir audio (interacción entre interfaz y sistema multimedia)

Pruebas de regresión
- Recalcular precio tras modificar descuentos
- Volver a reproducir audio después de cambios en el código

Pruebas funcionales
- Calcular precio correctamente
- Pausar audio


+ Nuevas pruebas añadidas

Rendimiento
- La aplicación se inicia en menos de 2 segundos
- El audio empieza en menos de 1 segundo

Carga
- Reproducir 50 audios seguidos sin errores
- Hacer 100 fotos seguidas sin fallos

Estrés
- Uso continuo durante 10 minutos
- Pulsar play/pause repetidamente muchas veces

Capacidad
- Soporta múltiples archivos de audio
- Maneja imágenes de diferentes tamaños

Seguridad
- No permite usar la cámara sin permisos
- No acepta archivos no válidos

Uso de recursos
- Uso de memoria estable
- CPU no se dispara durante reproducción


Respuesta a las preguntas:

¿Cuándo hacer pruebas funcionales?
Las pruebas funcionales deben realizarse durante el desarrollo, antes de la entrega y antes de pasar la aplicación a producción.

¿Qué porcentaje mínimo de pruebas?
Se recomienda tener entre un 80% y 90% de cobertura antes de pasar a la siguiente fase.

¿Qué hacer con los errores?
Los errores deben corregirse antes de avanzar. Después de corregirlos, se deben volver a ejecutar las pruebas para asegurar que el problema está solucionado.