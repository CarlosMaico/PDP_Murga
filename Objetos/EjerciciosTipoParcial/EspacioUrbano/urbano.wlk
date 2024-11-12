class EspacioUrbano{
    var property valuacion
    var property superficie
    var property nombre
    var property tieneVallado  

    method esGrande(){  // cambiar en es grande meter adentro el cumpleCondiciones usat template methos en ves de super templatemethos y super son distint
        self.superaLimite()
    } 

    method superaLimite() {
        superficie > 50
    }

    method modificarValuacion(cantidad) {
      valuacion += cantidad
    }
}

class Plaza inherits EspacioUrbano {
  var property cantCanchas 
  var property espacioEsparcimiento 

  override method esGrande() {
    cantCanchas > 2 && super()
  }

  method esVerde() {
    cantCanchas == 0
  }

  method esLimpiable() {
    true
  }
}

class Plazoleta inherits EspacioUrbano {
  var property procerHomenajeado
  var property espacioSinCesped  

  override method esGrande(){
    procerHomenajeado == "San Martin" && tieneVallado && super()
  } 
}

class Anfiteatro inherits EspacioUrbano{
    var property capacidad 
    var property tamanioEscenario  

    override method esGrande() {
      capacidad > 500 && super()
    }

    method esLimpiable() {
      self.esGrande()
    }
}

class MultiEspacio inherits EspacioUrbano {
  const property espaciosUrbanos = [] 

  override method esGrande() {
    espaciosUrbanos.all({espacioUrbano => espacioUrbano.esGrande()})
  }

  method esVerde() {
    espaciosUrbanos.size() >=3
  }
}


class Persona {
  var property profesion

  method trabajar(unEspacioUrbano) 

  method duracionTrabajo(unEspacioUrbano)
}

class Cerrajero{
    method trabajar(unEspacioUrbano) {
      if(!unEspacioUrbano.esVallado()){
        unEspacioUrbano.esVallado(true)
      }
    }

    method duracionTrabajo(unEspacioUrbano) {
      if(unEspacioUrbano.esGrande()){
        return 5
      }
      return 3
    }
}

class Jardinero {
  method trabajar(unEspacioUrbano) {
    if(unEspacioUrbano.esVerde()){
        unEspacioUrbano.valuacion(unEspacioUrbano.valuacion()*1.1)
    }
  }

  method duracionTrabajo(unEspacioUrbano) {
    unEspacioUrbano.superficie()/10
  }
}

class Encargado {
  var property hidrolavadora

  method trabajar(unEspacioUrbano) {
    if(unEspacioUrbano.esLimpiable()){
        unEspacioUrbano.modificarValuacion(5000)
    }
  } 

  method duracionTrabajo(_) = 8 
}




