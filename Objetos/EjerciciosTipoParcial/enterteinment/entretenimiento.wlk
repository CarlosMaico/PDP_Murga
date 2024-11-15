

object productora {
    var property impuesto = 100
  
}

class Entradas {
    var property banda 
    var property fecha  
    const property precioBase = 1000

    method precio(productora) = precioBase + productora.impuesto() 
}

class Asistente {
    var property tipoDeAbono 
    const property historialDeEntradas = [] 
    var property dineroDisponible  

    method comprar(entrada, productora){
        if(!self.puedeComprarEntrada()){
            throw new DomainException(message = "no puede comprar la entrada")
        }

        self.pagarEntrada(entrada, productora)
        historialDeEntradas.add(entrada)
    }

    method puedeComprarEntrada() = dineroDisponible > 0

    method costoEntradaConDescuentos(entrada, productora) = (entrada.precio(productora) * tipoDeAbono.descuento())/100 
    method pagarEntrada(entrada, productora){
        dineroDisponible -= self.costoEntradaConDescuentos(entrada, productora)
    }   

    method totalGastado(productora) = historialDeEntradas.sum({entrada => entrada.precio(productora)*tipoDeAbono.descuento()/100}) 
    method nombresDeLasBandas() = historialDeEntradas.map({entrada => entrada.banda().nombre()}) 
}

object fan {
    method descuento() = 0 
}

class Vip {
    var property porcentaje  
}

class Banda {
    var property nombre 
    var property tipoBanda 


    method canon() = 1000000 
    method presupuesto() = self.canon() + tipoBanda.extra()    
}

class Rock {
    var property cantSolosDeGuitarra  

    method extra() = 10000
    method popularidad() = 100 * cantSolosDeGuitarra  
}

