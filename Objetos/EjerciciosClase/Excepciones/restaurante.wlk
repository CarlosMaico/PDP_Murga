class Cliente {
  var property tipoCliente 
  var property salario

  method monotTotalAPagar(unMonto) {
    return unMonto + tipoCliente.propinaSegunElMonto(unMonto, self)
  }  
}

object comun {
  method propinaSegunElMonto(unMonto,_) = unMonto*0.1 
}

object comedido {
  var property montoMaximo =10
  method propinaSegunElMonto(unMonto,_) = montoMaximo.min(unMonto*0.2) 

}

object amarrete {
  method propinaSegunElMonto(unMonto,_) = 0 
}

object segunSuSalario {
  method propinaSegunElMonto(_, unCliente) = unCliente.salario() * 0.01 
}