class BarcoPirata{
    var property mision  
    const property capacidad
    const property tripulantes = #{}  
    
    method mision(nuevaMision) {  //puedo hacer un nuevo set ademas de haber echo el property
        mision = nuevaMision
        const piratasQueNoSirven = tripulantes.filter({pirata => not nuevaMision.esUtil(pirata)})
        tripulantes.removeAll(piratasQueNoSirven)
    }
    method puedeSerSaqueadoPor(pirata) = pirata.pasadoDeGrogXD()
    method puedeFormarParteDeTripulacion(pirata) = self.hayLugar() && mision.esUtil(pirata)  //Sonde consulta los de igual

    method hayLugar() = capacidad > self.cantidadDeTripulantes()
    method cantidadDeTripulantes() = tripulantes.size() 

    method incorporarATripulacion(pirata){  //estos son de efecto
        if(not self.puedeFormarParteDeTripulacion(pirata)){
            self.error("no se puede subir al barco")
        }
        tripulantes.add(pirata)
    }

    method esVulnerable(barco) = barco.cantidadDeTripulantes()/2 >= self.cantidadDeTripulantes()  

    method esTemible() = self.puedeRealizarMision() && tripulantes.filter({pirata => mision.esUtil(pirata)}).size() > 5  

    method puedeRealizarMision() = mision.puedeSerRealizadaPor(self) 
    
    //TODO
    method superaPorcentajeDeOcupacion(porcentaje) = self.cantidadDeTripulantes() >= capacidad*porcentaje/100
    method tieneItem(item) = tripulantes.any({tripulante => tripulante.tieneItem(item)})
    method tripulacionPasadaDeGrogXD()  = tripulantes.all({tripulante => tripulante.pasadoDeGrgogXD()})

    method itemMasRaro() = self.items().min({item => self.cantidadDeTripualntesQuetienen(item)})
    method cantidadDeTripualntesQuetienen(item) = tripulantes.count({tripulante => tripulante.tieneItem(item)}) 

    method items() = self.tripulantes().flatMap({tripulante => tripulante.items()}) //me mapea los items que son listas pero lo separa  

    method anclarEn(ciudadCostera) {
        tripulantes.filter {tripulante => tripulante.puedePagar(ciudadCostera.cuantoCobraElGrogXD())
        }.forEach{tripulante => tripulante.tomarTragoDeGrogXD(CiudadCostera)
        }

        const elMasEbrio = self.tripulanteMasEbrio()
        tripulantes.remove(elMasEbrio)
        ciudadCostera.sumarHabitante(elMasEbrio)
    }

    method tripulanteMasEbrio() = tripulantes.max({tripulante => tripulante.ebriedad()}) 
}

class CiudadCostera{
    var property cantidadDeHabitantes = 0 
    const property cuantoCobraElGrogXD  

    method puedeSerSaqueadoPor(pirata) = pirata.ebriedad() >= 50 
    method esVulnerable(barco) =  barco.cantidadDeTripulantes() >= self.cantidadDeHabitantes() * 0.4 || barco.tripulacionPasadaDeGrogXD()

    method sumarHabitante(pirata) {
        cantidadDeHabitantes += 1
    }
}

class Pirata {
    var property monedas = 0
    const property items = []
    var property ebriedad = 0 

    method puedePagar(dinero) = monedas >= dinero
    method tomarTragoDeGrogXD(ciudad) {
        self.gastar(ciudad.cuantoCobraElGrogXD())
        ebriedad += 5
        
    } 

    method gastar(dinero) {
        if(self.puedePagar(dinero))
            monedas -= dinero
        else
            self.error("No pued pagar esa cantidad d emonedas")
    } 

    method tieneItem(item) = items.contains(item)  
    method cantidadDeItems() = items.size()
    method seAnimaASaquearA(victima) = victima.puedeSerSaqueadoPor(self) 
    method pasadoDeGrgogXD() = self.ebriedad() > 90 && self.tieneItem("botella de GrogXD") 
}

class EspiaDeLaCorono inherits Pirata{
    override method pasadoDeGrgogXD() = false
    override method seAnimaASaquearA(victima) = super(victima)  && self.tieneItem("permiso de la corona")  
}

class Mision {
  method puedeSerRealizadaPor(barco){
        return barco.superaPorcentajeDeOcupacion(90) &&  self.cumpleCondicionesParaRealizar(barco)
  } 

  method cumpleCondicionesParaRealizar(barco) =  true
}

class BusquedaDelTesoro inherits Mision{
  method esUtil(pirata) = self.tieneAlgunItemUtil(pirata) && pirata.monedas() <= 5

  method tieneAlgunItemUtil(pirata) = #{"brujula", "mapa", "botella de GrogXD"}.any({item => pirata.tieneItem(item)})

  override method cumpleCondicionesParaRealizar(barco) = barco.tieneItem("llave de cofre") 
}

class ConvertirseEnLeyenda inherits Mision{
  const property itemObligatorio  
  method esUtil(pirata) = pirata.cantidadDeItems() >= 10 && pirata.tieneItem(itemObligatorio)
}

class Saqueo inherits Mision{
    
  const property victima

  method esUtil(pirata) = pirata.monedas() < self.maximoDeMonedas() && pirata.seAnimaASaquearA(victima)

  method maximoDeMonedas() = configuracionSaqueos.maximoDeMonedas()    //creo un configuracin de saqueso ya que se debe refernciar al mismo , osea si cambio la referencia debe cambiar en todos

  override method cumpleCondicionesParaRealizar(barco) = victima.esVulnerable(barco) 
}

object configuracionSaqueos {
   var property maximoDeMonedas = 0  
}