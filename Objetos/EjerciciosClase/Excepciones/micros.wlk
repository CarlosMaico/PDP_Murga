class Micro {
  
  var property cantidadDePasajerosSentados
  var property cantidadDePasajerosParados
  var property volumne

  const property pasajeros = []   

  method subirA(unEmpleado) {
    if(!self.hayLugar() && !unEmpleado.quiereSubirA(self)){
        throw new DomainException(message = "no puede subir al micro")
    }
    pasajeros.add(unEmpleado)
  }

  method bajaA(unEmpleado) {
    if(!self.estaEmpleado(unEmpleado)){
        throw new DomainException(message = "no esta el empleado en el micro")
    }
    pasajeros.remove(unEmpleado)
  }


  method hayLugar() = self.cantDePasajeros() < self.capacidad()

  method cantDePasajeros() = pasajeros.size() 
  method capacidad() = cantidadDePasajerosSentados + cantidadDePasajerosParados

  method estaEmpleado(unEmpleado) = pasajeros.contains(unEmpleado)   

  method puedeViajarSentado() = self.cantDePasajeros() < cantidadDePasajerosSentados 

  method lugaresLibres() = self.capacidad() - self.cantDePasajeros()

}

class Empleado {
  var property personalidad 
  method quiereSubirA(unMicro) = personalidad.quiereSubirA(unMicro)
 
}

object apurado {
  method quiereSubirA(_) = true 
}

object claustrofobico {
  method quiereSubirA(unMicro) = unMicro.volumne() > 120
}

object fiaca {
  method quiereSubirA(unMicro) = unMicro.puedeViajarSentado()
}

object moderado {
  var property cantLugaresLibres=10
  method quiereSubirA(unMicro) = cantLugaresLibres <= unMicro.lugaresLibres() 
}