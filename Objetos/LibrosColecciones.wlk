
object andy {
    const property librosLeidos = [harryPotter,elSenorDeLosAnillo,elPrincipito,losJuegosDelHambre,venasAbiertas,rayuela] //2

    method primerLibroLeido() = librosLeidos.first()

    method ultimoLibroLeido() = librosLeidos.last()

    method cantLibrosLeido () = librosLeidos.size()

    method olvidarPrimerLibroLeido() {
        librosLeidos.remove(self.primerLibroLeido())
    }

    method olvidaUnLibro(unLibro) {
      librosLeidos.remove(unLibro)
    }

    method mejorLibroLeido() = librosLeidos.max({unLibro => unLibro.valoracion()})

    method peorLibroLeido() = librosLeidos.min({unLibro => unLibro.valoracion()})

    method buenosLibrosLeidos() = librosLeidos.filter({unLibro => unLibro.valoracion()>12}) 

    method malosLibrosLeidos() = librosLeidos.removeAllSuchThat({unLibro => unLibro.valoracion()<=7})

    method promedioDeLibrosLeidos() = librosLeidos.sum({unLibro=>unLibro.valoracion()}) / self.cantLibrosLeido() 

    method libroLeidoConValoracionMayorA(valoracion) = librosLeidos.find({unLibro => unLibro.valoracion()> valoracion})

}

object harryPotter{
    var property lectores = 10500156

    method valoracion() = lectores/1000000
}

object elSenorDeLosAnillo{
    var property cantPaginas = 450

    method valoracion() = cantPaginas / 45 
}

object elPrincipito {

    method valoracion() = 50
}

object losJuegosDelHambre {
    var property votosPositvos = 1600200
    var property votosNegativos = 300600
    
    method coeficiente() = votosPositvos - votosNegativos

    method valoracion() {
        if (self.coeficiente() > 0){
            return self.coeficiente()/1000000
        }
        return 0
    }
}

object venasAbiertas{
    const property publciaionAnio = 1971 

    method valoracion() = self.cantAniosPublicado()/3

    method cantAniosPublicado() {
        const fechaHoy = new Date()
        return fechaHoy.year() - publciaionAnio
    }
}

object rayuela {
    const property titulo = "Rayuela"

    method valoracion() {
        return self.cantLetrasTitulo()*2
    } 

    method cantLetrasTitulo() = titulo.size()
    
}