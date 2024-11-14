//modelando con composison si quiero cambias el aspecto, solo puedo modificar el estado interno

//Personajes

class Personaje{
    const property fuerza = 100
    const property inteligencia = 100
    var rol 

    method potencialOfensivo() = fuerza*10 + rol.potencialOfensivoExtra()  //con tal de que entidnan potencialFOensivoextra ya tengo el rol, soll deben entender ese mesnaje
    method esGroso() = self.esInteligente() || self.esGrosoParaSuRol()

    method esInteligente()
    method esGrosoParaSuRol() = rol.esGroso(self) 
}

class Humano inherits Personaje {
    
    override method esInteligente() = inteligencia > 50 
}

class Orco inherits Personaje {
    override method potencialOfensivo() = super() * 1.1 
    override  method esInteligente() = false   
}


//Roles
object guerrero {
    method potencialOfensivoExtra() = 100  

    method esGroso(personaje) = personaje.fuerza()>50 
}
object brujo {
    method potencialOfensivoExtra() = 0
    method esGroso(personaje) = true  
} 

class Cazador {
    var mascota 

    method potencialOfensivoExtra()= mascota.potencialOfensivo()

    method esGroso(personaje) = mascota.esLongeva()
}

class Mascota {
    const fuerza
    const edad
    const tieneGarras

    method potencialOfensivo() = if(tieneGarras) fuerza*2 else fuerza 
    method esLongeva() = edad > 10 
}

//Zonas

class Ejercito {
    const property miembros = []

    method potencialOfensivo() = miembros.sum({personaje=>personaje.potencialOfensivo()})

    method invadir(zona) {
        if(zona.potencialDefensivo()<self.potencialOfensivo()){
            zona.seOcupaPor(self)
        }
    } 
}

class Zona{
    var habitantes //este habitantes es como una instancia de ejercito 

    method potencialDefensivo() = habitantes.potencialOfensivo() 
    method seOcupaPor(ejercito) {habitantes = ejercito}
}

class Aldea inherits Zona {
    const maxHabitantes  =50

    override method seOcupaPor(ejercito) {
        if(ejercito.miembros().size()>maxHabitantes){
            const nuevosHabitantes = ejercito.miembros().sortedBy{uno, otro => uno.potencialOfensivo()> otro.potencialOfensivo()}.take(10)
            super(new Ejercito(miembros = nuevosHabitantes))
            ejercito.removeAll(nuevosHabitantes)
        }
        super(ejercito)
    }  
}

class Ciudad inherits Zona{
    override method potencialDefensivo() = super() +300 

}

