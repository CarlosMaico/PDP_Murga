class Persona {
	
	const property enfermedades = []
	var property temperatura
	var property cantCelulas
	
	
	method contraer(enfermedad){
		enfermedades.add(enfermedad)
	}
	
	method modificarTemperatura(cantidad) {
		temperatura = 45.min(cantidad + temperatura)
	}
	
	method modificarCantCelulas(cantidad) {
		cantCelulas = 0.max(cantCelulas + cantidad)
	}

	method vivirUnDia() {
		enfermedades.forEach({unEnfermedad => unEnfermedad.afectarA(self)})
	}

    method tomar(cantidad) {
      enfermedades.forEach({unaEnfermedad => unaEnfermedad.atenuar(15*cantidad)})
    }

	method estaEnComa() {
	  return temperatura == 45 || cantCelulas < 1000000
	}

	method cantCelulasAmenazadasEnfAgresivas() {
	  return self.enfermedadesAgresivas().sum({unaEnf => unaEnf.cantCelulas()})
	}

	method enfermedadesAgresivas() {
	  return enfermedades.filter({enf => enf.esAgresiva(self)})
	}
}

class Enfermedad {
	
	var property cantCelulasAfectadas
	
	method afectarA(persona)

    method atenuar(cantidad) {  //es comun para todas las enfermedades 
      cantCelulasAfectadas = 0.max(cantCelulasAfectadas - cantidad)
    }
	
}

class Infecciosa inherits Enfermedad {  //es clase abstracta
	
	
	override method afectarA(persona){ 
		persona.modificarTemperatura(cantCelulasAfectadas/1000)
	}
	
	method esAgresiva(persona) {
		return cantCelulasAfectadas > persona.cantCelulas() * 0.001
	}
	
	method reproducirse() {
		cantCelulasAfectadas *= 2
	}

}

class Autoinmune inherits Enfermedad {
	var property cantDias = 0
	
	override method afectarA(persona) {
		persona.modificarCantCelulas(-cantCelulasAfectadas);
		cantDias += 1
	}
	
	method esAgresiva(persona) = cantDias > 30
	
}

//Parte 2

class Medico inherits Persona {
    var property dosis

    method atenderA(persona) {
      persona.tomar(dosis)
    } 

    override method contraer(enfermedad) {
      super(enfermedad)
      self.atenderA(self)
    }

}

class MedicoJefe inherits Medico {
    const property subordinados = []

    override method atenderA(persona) {
      subordinados.anyOne().atenderA(persona)
    } 

    method agregarSubordinado(unSubordinado) {
      subordinados.add(unSubordinado)
    }
}

object hipotermia {
    method afectarA(persona) {
      persona.modificarTemperatura(-persona.temperatura())
    }

    method atenuar(_) { //metodo absttrracto no tienen implementacion , pero el de igual no hace nada
      //vacio
    }

    method esAgresiva() = true
}

//6 a debemos ver si la enfermedad afecta directo a la persona o a las celulas, si es o no agresiva y comom se atenua esa enfermedad
// 6 b todas las enfemedades matan las celulas que afecta, todo lo comun lo tendira en enfermedad  y cuanot a lo autoinmune ara una redefincion  de lo que se necesita
//6 c crear una clase afectar como autoinme y como infecciosa