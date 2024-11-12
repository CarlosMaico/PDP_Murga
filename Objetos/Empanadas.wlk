
object negocio {
    var disponible=50000

    method pagar(unEmpleado) {
      disponible -= unEmpleado.sueldo()
    }

    method disponible() {
      return disponible
    }
}

object galvan {
  var sueldo = 15000

  method sueldo() {
    return sueldo
  }
}

object bagorria {
  var montoEmpanada=15
  var cantidadDeEmpanadaVendida=100

  method sueldo() {
    return montoEmpanada * cantidadDeEmpanadaVendida
  }

  method venderEmpanada() {
    cantidadDeEmpanadaVendida +=1
  }
}