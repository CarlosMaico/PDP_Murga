object tom {
  var energia = 0
  var posicion = 0

  method energia(unaEnergia) {
    energia = unaEnergia
  }
  
  method energia() = energia 

  method posicion(unaPosicion) {
    posicion = unaPosicion
  }

  method posicion() = posicion 

  method velocidad() = 5 +(energia/10)

  method puedeAtraparA(unRaton) = self.velocidad() > unRaton.velocidad() 

  method correrA(unRaton) {
    energia = energia - (self.consumoDeEnergia(unRaton))
    posicion = unRaton.posicion()
  }

  method consumoDeEnergia(unRaton) {
    return 0.5 * self.velocidad() * self.distanciaA(unRaton)
  }

  method distanciaA(unRaton) = (posicion - unRaton.posicion()).abs() 
}

object jerry {
  var peso = 0
  var posicion = 0

  method peso(unPeso) {
    peso = unPeso
  }

  method peso() = peso

  method posicion(unaPosicion) {
    posicion = unaPosicion
  }

  method posicion() = posicion 

  method velocidad() = 10 - (peso) 
}

object robotRaton {
  const velocidad = 8
  var posicion =0

  method posicion(unaPosicion) {
    posicion = unaPosicion
  }

  method posicion() = posicion

  method velocidad() = velocidad  
}