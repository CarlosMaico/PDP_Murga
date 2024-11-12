object pepe {
  var categoria = 0 
  var cantFaltas = 0
  var bonoResultados = 0
  var bonoPresentismo = 0
  
  method categoria(unaCategoria) {
    categoria = unaCategoria
  }
  method categoria() = categoria 
  
  method cantFaltas(faltas) {
    cantFaltas = faltas
  }
  method cantFaltas() = cantFaltas 

  method bonoResultados(unBonoResultado) {
    bonoResultados = unBonoResultado
  }
  method bonoResultados() = bonoResultados

  method bonoPresentismo(unBonoPresentismo) {
    bonoPresentismo = unBonoPresentismo
  } 
  method bonoPresentismo() = bonoPresentismo 

  method sueldo() = categoria.neto() + bonoPresentismo.monto(cantFaltas) + bonoResultados.monto(categoria.neto())
}

object bonoPorcentajeSegunNeto {
  method monto(unNeto) = unNeto * 0.1  
}

object bonoFijo {
  method monto(_) = 800 
}

object bonoNulo {
  method monto(_) = 0 
}

object bonoPorFaltas {
  method monto(canFaltas) {
    if(canFaltas == 0){
        return 1000
    }
    if(canFaltas == 1){
        return 500
    }
    return 0
  } 
}

object bonoIndependienteDeFaltas {
  method monto(_) = 0 
}

object cadete {
  var neto = 15000

  method neto() = neto 
}

object gerente {
  var neto = 10000

  method neto() = neto 
}