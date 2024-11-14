object julieta {
  var property tickets = 15
  var cansancio = 0
  
  method punteria() = 20 
  method fuerza() = 80 - cansancio 

  method jugar(juego) {
    tickets = tickets + juego.ticketsGanados(self)
    cansancio = cansancio + juego.cansancioQueProduce()
  } 

  method puedeCanjear(premio) = tickets > premio.costo()
}

object tiroAlBlanco {
  method ticketsGanados(jugador) = (jugador.punteria()/10).roundUp()
  method cansancioQueProduce() = 3
}

object pruebaDeFuerza {
  method ticketsGanados(jugador)= if(jugador.fuerza()>75) 20 else 0
  method cansancioQueProduce()  = 8
}

object ruedaDeLaFortuna {
  var property aceitada = true 
  method ticketsGanados(_) = 0.randomUpTo(20).roundUp()
  method cansancioQueProduce() = if(aceitada) 0 else 1
}

object ositoDePeluche {
  method costo() = 45 
}

object taladro {
  var property costo = 200
}

object gerundio {

  method jugar(juego) {} //tiene que entder el emsnaje por el plimorfismo para los juegos ya que estse es una persona
  method puedeCanjear(premio) = true
}