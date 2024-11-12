class Celular {
  var property memoria = 1000
  const property aplicaciones = []
  const property bateria = 100 

  method memoriaLibreCelular() = memoria - self.consumoAplicaciones() 

  method consumoAplicaciones() = aplicaciones.sum({unaAplicacion => unaAplicacion.consumoMemoria()})

  method consumoDeBateria() = aplicaciones.sum({unaAplicacion => unaAplicacion.consumoBateria()}) 

  method bateriaRestante() = 100 - self.consumoDeBateria() 

  method agregarAplicacion(unaAplicacion) {
    aplicaciones.add(unaAplicacion)
  }

}

class Mensajeria {
  var property memoriaBase 
  var property memoriaPorConversacion
  var property gastoBateria = 1
  var property cantConversaciones 

  method consumoMemoria() = memoriaBase + (cantConversaciones*memoriaPorConversacion)  

  method consumoBateria() = cantConversaciones * gastoBateria     
}

class Reproductor {
  var property cantElementos
  var property cantMemoriaPorElemento 
  var property maximoOcupa  
  var property consumoBateria = 2

  method consumoMemoria() = maximoOcupa.min(cantMemoriaPorElemento * cantElementos) //whats??  
}

object calculadora { //es un objeto por que la podemos tratar como unica, en vambio lo otro es como clases porq ue puede haber muchos
  var property consumoMemoria = 10 
  var property consumoBateria = 0 
}