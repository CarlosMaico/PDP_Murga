object yamilo {
  var calorias = 100

  method calorias() = calorias

  method calorias(caloria) {
    calorias = caloria
  }

  method comer(unChanchito) {
    calorias += unChanchito.peso()/10
  }

  method sobrePeso() = calorias > 200

  method estaSaludable() = calorias.between(20, 150) 

  method correr(tiempo) {
    calorias = calorias - (tiempo*2)
  }
}


object chanchoDeCasaDePaja {
  var peso = 100

  method peso() = peso 

}