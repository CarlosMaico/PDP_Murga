
//lo mas importante de un objeto es la interfaz, la referecnias solo forman parte de la implementacion, por eso no es tan importante. 
//Importante siempre ver las interfazes de los objetos
class Proyecto {
    const tareas = []

    method costoTotal() = tareas.sum{tarea => tarea.costo()} 

    method diasMaximosDeAtraso() = tareas.map{tarea => tarea.diasDeAtraso()}.maxIfEmpty({0}) 

}

class Impuesto{
    var property  porcentaje 
    method calcularValor(valorBase) = valorBase* porcentaje
}
const impuestoA = new Impuesto(porcentaje = 0.03)

const impuestoB = new Impuesto(porcentaje = 0.05)

class Tarea {
    var property tiempo 
    const property complejidad = complejidadMinima  
    const impuestos = #{} 

    method costo() = self.costoBase() + self.costoPorOverhead() + self.costoPorImpuestos()
    method costoBase() = complejidad.costo(self)
    method costoPorOverhead()// mettodo abstracto es un patern es el template method  
    method costoPorImpuestos() = impuestos.sum{impuesto => impuesto.calcularValor(self.costoBase())}
    method diasDeAtraso() = complejidad.diasDeAtraso(self)


}

class TareaSimple inherits Tarea{
    var property porcentajeDeCumplimiento = 0

    method cumplir(tarea) {
      porcentajeDeCumplimiento = 100
    }
    override method costoPorOverhead() = 0
}

class TareaCompuesta inherits Tarea{
    var property subtareas = [] 

    method cumplir() {
    throw new DomainException(message = "solo se pude marcar como cumplida una tarea simple")    
      
    }
    method porcentajeDeCumplimiento() = subtareas.sum{tarea => tarea.porcentajeDeCumplimiento()} / subtareas.size()

    override method costoPorOverhead() = if (self.tieneMuchasSubtareas()) 0.04 * self.costoBase() else 0

    method tieneMuchasSubtareas() = subtareas.size() > 3 
}


class Complejidad{
    method costo(tarea) = tarea.tiempo()*25

    method diasDeAtraso(tarea)  
}
object complejidadMinima inherits Complejidad{  
    override method diasDeAtraso(_) = 5
}
object complejidadMedia inherits Complejidad{  //si hay estado necesito clase , aca como no lo tiene son objetos
    override method costo(tarea) = super(tarea) * 1.05 

    override method diasDeAtraso(tarea) = tarea.tiempo() * 0.1
}
object complejidadMaxima inherits Complejidad{
    override method costo(tarea) = super(tarea) * 1.07 + self.costoExtra(tarea)

    method costoExtra(tarea) = 0.max(tarea.tiempo()-10) * 10 

    override method diasDeAtraso(tarea) = tarea.tiempo() * 0.2 + 8 
}

