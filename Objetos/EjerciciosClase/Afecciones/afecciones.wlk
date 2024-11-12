object sara {
  var peso = 55
  var vitalidad = 90
  var temperatura = 37

  method peso(unPeso) {
    peso = unPeso
  }
  method peso() = peso

  method vitalidad(unaVitalidad) {
    vitalidad = unaVitalidad
  } 
  method vitalidad() = vitalidad

  method temperatura(unaTemperatura) {
    temperatura = unaTemperatura
  } 
  method temperatura() = temperatura 

/*method afeccion(algo) = self.afeccion(algo)*/

  method modificarTemperatura(cant) {
    temperatura += cant
  }
  method modificarPeso(cant) {
    peso += cant
  }
  method modificarVitalidad(cant) {
    vitalidad += cant
  }


  method afectadoPor(algo) = algo.afectarA(self) 


}

object malaria {
  method afectarA(alguien) = alguien.modificarTemperatura(3)
}

object varicela{ 
  method afectarA(alguien) {
    alguien.modificarVitalidad(-5)
    alguien.modificarPeso(-alguien.peso()*0.1)
  }
}
object gripe {
  method afectarA(alguien) = alguien.modificarVitalidad(-alguien.vitalidad()*0.2)
}

object paracetamol {
  method afectarA(alguien) {
    if(alguien.temperatura() > 37){
        alguien.temperatura(37)
    }
  }
}

object polen {
  var gramos = 10 

  method afectarA(alguien) {
    alguien.modificarVitalidad(gramos*0.1)
  }
}

object nuez {
  method afectarA(alguien) = alguien.modificarVitalidad(alguien.vitalidad()*0.3)
}