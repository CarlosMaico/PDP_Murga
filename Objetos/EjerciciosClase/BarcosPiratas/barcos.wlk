class Barco{
 const property tripulantes = []
 var property mision

 method piratasUtilesParaMision() {
   return tripulantes.filter({untripulante => mision.esUtil(untripulante)})
 } 

}

class Mision {
    method esUtil(tripulante) {
      return tripulante.esIntrepido() && self.cumplirCondicion(tripulante)
    }

    method cumplirCondicion(tripulante) //este es el metodo abstracto, aca uso el template method 
}

class Pirata {
  var property edad
  var property temenMorir
  const property items = [] 
  var property cantMonedas = 10

  method esIntrepido() {
    return edad < 40 && !temenMorir
  }

  method cantItems() = items.size()

  //method cumplirCondicion(tripulante)  //es abstracto es un template method y ademas tengo una aprte que va cambiando por cada objeto. Uso template method en ves de usar super
}

object convertirseEnLeyenda inherits Mision {
  
  override method cumplirCondicion(tripulante) {
    return tripulante.cantItems() > 10
  }
}

object busquedaTesoro inherits Mision {
  
  override method cumplirCondicion(tripulante){
    return tripulante.tieneItem("Brujula") || tripulante.tieneItem("botellaGrog XD")
  }
}


class Saqueo inherits Mision {
  var property objetivo  
  var property cantidadNecesaria
  
  override method cumplirCondicion(tripulante){
    return tripulante.cantMonedas() <= cantidadNecesaria
  }
}