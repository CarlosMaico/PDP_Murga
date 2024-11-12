
class Conductor {
  var property vehiculo
  var property tieneRegistro 

  method esSeguro() = tieneRegistro && vehiculo.esSeguro() 
}

class Auto {
  var property plusVelocidad 
  var property tieneRuedaAux 
  method velocidad() = 100 + plusVelocidad  
  method esSeguro() = tieneRuedaAux && self.velocidad() < 140 
}

class Moto { 
  var property velocidad //todas als variables se manejan a nivel de instancia
  var property cantEspejos

  method esSeguro() = velocidad < 160 && cantEspejos >=2 
}