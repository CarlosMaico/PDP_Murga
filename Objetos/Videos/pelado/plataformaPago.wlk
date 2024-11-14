class Contenido{
    const property titulo
    var property vistas = 0
    var property ofensivo = false
    var property monetizacion

    method monetizacion(nuevaMonetizacion) {
        if(!nuevaMonetizacion.puedeAplicarseA(self)){
            throw new DomainException(message = "El contenido no soporta la forma de moentizacion")
        }
        monetizacion = nuevaMonetizacion
    }

    method initizalize() {
        if(!monetizacion.puedeAplicarseA(self))
            throw new DomainException(message = "El contenido no soporta la forma de moentizacion")   
    } 

    method recaudacion() = monetizacion.recaudacionDe(self)  //aca se trata inditnttmante a cada monetizacion por eso el polimorfismo

    method esPopular() 
    method recaudacionMaximaParaPublicidad() 
    method puedeVenderse() = self.esPopular()
 
    method puedeAlquilarse() 
}

class Video inherits Contenido{
    override method esPopular() = vistas > 10000 

    override method recaudacionMaximaParaPublicidad() = 10000

    override method puedeAlquilarse() = true 
}

const tagsDeModa = ["objetos", "pdep", "serPeladoHoy"]

class Imagen inherits Contenido{
    const property tags = [] 

    override method esPopular() = tagsDeModa.all({tag => tags.contains(tag)})
    override method recaudacionMaximaParaPublicidad() = 400 
    override method puedeAlquilarse() = false 
}

//monetizacion

object publicidad {
    method recaudacionDe(contenido) = (0.05 * contenido.vistas() + if(contenido.esPopular()) 2000 else 0).min(contenido.recaudacionMaximaParaPublicidad())  

    method puedeAplicarseA(contenido) = !contenido.ofensivo() 
}

class Donacion{
    var property donaciones = 0

    method recaudacionDe(contenido) = donaciones
    method puedeAplicarseA(contenido) = true
}

class Descarga{
    const property precio 
    // puedo usar initialize para qhacer ea validacion de menor a 5

    method recaudacionDe(contenido) = contenido.vistas() * precio
    method puedeAplicarseA(contenido) = contenido.puedeVenderse()
}

class Alquiler inherits Descarga{
    override method precio() = 1.max(super())

    override method puedeAplicarseA(contenido) = super(contenido) && contenido.puedeAlquilarse() 
}

//usuarios

object usuarios {
    const property todosLosUsuarios = []

    method emailsDeUsuariosRicos() = 
        todosLosUsuarios.filter({usuario => usuario.verificado()}).sortedBy({uno, otro => uno.saldoTotal() > otro.saldoTotal()}.take(100)).map({usuario => usuario.email()}) 

    method cantidadDeSuperUsuarios() = todosLosUsuarios.count({usuario => usuario.esSuperUsuario()})  
    
       
}


class Usuario {
    const property nombre
    const property email
    var property verificado = false
    const contenidos = []

    method saldoTotal() = contenidos.sum({contenido => contenido.recaudacion()})   //trata a cada contenido indistintamnete ahi el polimorfismo aplica

    method esSuperUsuario() = contenidos.count({contenido => contenido.esPopular()}) > 10 

    method publicar(contenido){
        contenidos.add(contenido)
    } 

}


//un nuevo contenido es muy facil de agregarlo
//permitir cambiar el tipo de un contenido, osea de imagen a video, al tener herencia es mas complejo, debido a que en herencia es mas duro
//al agregar una verificacion fallida,e smas complicada


//cada ves que se manda un mensaje hay polimorfis, el saldo total se ua polimorfismo ya que hace el saldo total lo calcula cada contenido, tambien en la recaudacion