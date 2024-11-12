object ash {
  const property pokebola = [charizard, pikachu, psyduck, blastoise]

  method capturar(unPokemon) {
    pokebola.add(unPokemon)
  }
  
  method esGroso() = pokebola.all({unPokemon => unPokemon.nivel() > 100})
  method pokemonPreferido() = pokebola.max({unPokemon => unPokemon.ataqueMasPotente()}) 
  method pokemonesPulenta() = pokebola.filter({unPokemon => unPokemon.esPulenta()}) 

}

object charizard {
  var property tipoPokemon = "fuego" 
  var property ataque = lanzallamas

  method aprenderAtaque(unAtaque) {
    ataque = unAtaque
  }
  method nivel() = ataque.potencia() 
  
  method ataqueMasPotente() = self.nivel() 

  method esPulenta() = false
}
object lanzallamas {
  var property potencia  = 5 
}

object pikachu {
  var property tipo = "agua"
  const ataques = [agilidad, trueno, colaDeHierro]

  method aprenderAtaque(unAtaque) {
    ataques.add(unAtaque)
  }

  method nivel() = ataques.sum({ataque => ataque.potencia()})

  method ataqueMasPotente() = self.mejorAtaque().potencia()

  method mejorAtaque() = ataques.max({unAtaque => unAtaque.potencia()}) 

  method esPulenta() = true
}

object agilidad {
  var property potencia = 10 
}
object trueno {
  var property potencia = 12 
}
object colaDeHierro {
  var property potencia = 14 
}

object psyduck {
  var property tipo = "agua"
  //no teine atques etnonce no lo pongo directamente
  method aprenderAtaque(unAtaque) {
    //vacio por que no hace nada, solo teineq ue entender el mensaje
  } 
  method nivel() = 0 

  method ataqueMasPotente() = 0 
  
  method esPulenta() = false
}

object blastoise {
  var property tipo = "agua"
  var property ataquePrincipal = hidroBomba
  var property ataqueDeReserva = rayoDeHielo

  method aprenderAtaque(unAtaque) {
    ataqueDeReserva = ataquePrincipal
    ataquePrincipal = unAtaque
  }  
  method nivel() = ataquePrincipal.potencia()+ataqueDeReserva.potencia() 

  method ataqueMasPotente() = self.mejorAtaque().potencia()

  method mejorAtaque() {
    if(ataquePrincipal.potencia()> ataqueDeReserva.potencia()){
        return ataquePrincipal
    }
    else return ataqueDeReserva
  } 
  
  method esPulenta() = false
}

object hidroBomba {
  var property potencia = 10 
}
object rayoDeHielo {
  const property potencia = 1
}