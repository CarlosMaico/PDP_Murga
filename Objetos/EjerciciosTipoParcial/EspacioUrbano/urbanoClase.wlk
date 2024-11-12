class EspacioUrbano{
    var property superficie 
    var property valuacion
    var property tieneVallado
    const property trabajoRealizados

    method esGrande() = superficie > 50 && self.cumpleCondiciones()  //esto es usar template method queda mas limpio

    method cumpleCondiciones() //metodo abstracto

    method esEspacioVerde() = false

    method esLimpiable() = false

    method aumentarValuacion(cantidad){
        valuacion += cantidad
    }
}

class Plaza inherits EspacioUrbano {
  var property cantChanchas
  var property espacioEsparcimiento 

  override method cumpleCondiciones(){
    return cantChanchas > 2
  }

  override method esEspacioVerde() = cantChanchas == 0

  override method esLimpiable() = true
}

class Plazoleta inherits EspacioUrbano {
  var property procer 
  var property espacioSinCesped

  override method cumpleCondiciones() {
    return procer == "San Martin" &&  tieneVallado  //no l epono nada porq ue se instancia
  }  
}

class Anfiteatro inherits EspacioUrbano{
  var property capacidad
  var property tamanioEscenario

  override method cumpleCondiciones() {
    return capacidad > 500
  }       

  override method esLimpiable() = self.esGrande()
}

class Multiespacio inherits EspacioUrbano {
  const property espaciosUrbanos = []  

  override method cumpleCondiciones() {
    return espaciosUrbanos.all({unEspacion => unEspacion.esGrande()})
  }

  override method esEspacioVerde() = espaciosUrbanos.size() > 3
}

class Trabajador {
  var property profesion

  method trabajarEn(espacioUrbano) {
    profesion.realizarTrabajo(espacioUrbano, self)
  }

  method valorHora() = profesion.valorHora()
}

class Profesion{
  method realizarTrabajo(espacioUrbano, trabajador){
    self.validarTrabajoEn(espacioUrbano)
    self.realizarEfecto(espacioUrbano)
    self.registrarTrabajo(espacioUrbano, trabajador)
  }

  method valorHora() = 1000
  method realizarEfecto(espacioUrbano) {
    
  }

  method puedeRealizarTrabajoEn(espacioUrbano) 

  method registrarTrabajo(espacioUrbano, trabajador) {
    espacioUrbano.agregarTrabajo(self.nuevoTrabajo(espacioUrbano, trabajador))
  }
  method validarTrabajoEn(espacioUrbano) {
    if(!self.puedeRealizarTrabajoEn(espacioUrbano)){
        //throw new DomainException(message = "no es un trabajo compatible") //lo cambie por el doamin expection
        throw new TrabajosIncompatibles(message = "no es un trabajo compatible")
    }
  }



  method nuevoTrabajo(espacioUrbano, trabajador) {
    return new Trabajo(persona = trabajador, duracion = self.duracionTrabajo(espacioUrbano), costo = self.costoTrabajo(espacioUrbano, trabajador))
  }

  method costoTrabajo(espacioUrbano, trabajador) {
    return trabajador.valorHora() * self.duracionTrabajo(espacioUrbano)
  }

  method duracionTrabajo(espacioUrbano) 
}

class TrabajosIncompatibles inherits DomainException {
  
}




object cerrajero inherits Profesion{
    override method duracionTrabajo(espacioUrbano) {
      if(espacioUrbano.esGrande()){
        return 5
      }
      return 3
    }

    override method puedeRealizarTrabajoEn(espacioUrbano) {
      return !espacioUrbano.tieneVallado()
    }

    override method realizarEfecto(espacio){
        return espacio.tieneVallado(true)
    }
}

object jardinero inherits Profesion{
    override method duracionTrabajo(espacioUrbano) {
        return espacioUrbano.superficie()/10
    }

    override method puedeRealizarTrabajoEn(espacioUrbano) {
      return espacioUrbano.esEspacioVerde()
    }

    override method realizarEfecto(espacio){
        espacio.aumentarValuacion(espacio.valuacion()*0.1)
    }

    override method valorHora() = 2500
}

object encargado inherits Profesion{
    override method duracionTrabajo(_) {
        return 8
    }
    override method puedeRealizarTrabajoEn(espacioUrbano) {
      return espacioUrbano.esLimpiable()
    }

    override method realizarEfecto(espacio){
        espacio.aumentarValuacion(5000)
    }
}

class Trabajo{
    var property duracion
    var property persona
    var property costo
    var property fecha = new Date();  //gnera fecha con new date
}