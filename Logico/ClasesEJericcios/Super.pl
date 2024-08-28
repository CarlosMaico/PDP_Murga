%primeraMarca(Marca)
primeraMarca(laSerenisima).
primeraMarca(gallo).
primeraMarca(vienisima).

%precioUnitario(Producto, Precio)
precioUnitario(arroz(gallo), 25.10).
precioUnitario(lacteo(laSerenisima, leche), 6.00).
precioUnitario(lacteo(laSerenisima, crema), 4.00).
precioUnitario(lacteo(gandara, queso(gouda)), 13.00).
precioUnitario(lacteo(vacalin, queso(mozzarella)), 12.50).
precioUnitario(salchichas(vienisima, 12), 9.80).
precioUnitario(salchichas(vienisima, 6), 5.80).
precioUnitario(salchichas(granjaDelSol, 8), 5.10).
precioUnitario(salchichas(laSerenisima, 8), 5.10).

%descuento(Producto, Descuento)
descuento(lacteo(laSerenisima, leche), 0.20).
descuento(lacteo(laSerenisima, crema), 0.70).
descuento(lacteo(gandara, queso(gouda)), 0.70).
descuento(lacteo(vacalin, queso(mozxarella)), 0.20).

%1
descuento(arroz(Marca), 1.50):- producto(arroz(Marca)). 
descuento(salchichas(Marca,Cantidad), 0.50):- producto(salchichas(Marca,Cantidad)), Marca \= vienisima.
descuento(lacteo(Marca, leche), 2):- producto(lacteo(Marca, leche)).
descuento(lacteo(Marca, queso(Tipo)), 2):- producto(lacteo(Marca, queso(Tipo))), primeraMarca(Marca).
descuento(Producto, Descuento):-mayorPrecio(Producto, Precio), Descuento is Precio* 0.05.

producto(Producto):- precioUnitario(Producto, _).

%compro(Cliente, Producto, Cantidad)
compro(juan, lacteo(laSerenisima, crema), 2).
compro(maico, salchichas(laSerenisima, 8), 1).


cliente(Cliente):- compro(Cliente,_,_).

mayorPrecio(Producto, PrecioMax):- 
    precioUnitario(Producto, PrecioMax), 
    forall(precioUnitario(_, OtroPrecio), PrecioMax >= OtroPrecio).% Encontramos el producto con MAYOR Precio


%2
esCompradorCompulsivo(Cliente):-
    cliente(Cliente),
    forall(compro(Cliente, Producto,_), (productoDePrimera(Producto), descuento(Producto,_))).

productoDePrimera(arroz(Marca)):- primeraMarca(Marca).
productoDePrimera(lacteo(Marca,_)):- primeraMarca(Marca).
productoDePrimera(salchichas(Marca,_)):- primeraMarca(Marca).

%3

productoDesconotado(Producto, PrecioConDescuento):-
    precioUnitario(Producto, PrecioOriginal),
    descuento(Producto, Descuento),
    PrecioConDescuento is PrecioOriginal -Descuento.

compraTotal(Producto, Cantidad, PrecioFinal):-
    productoDesconotado(Producto, PrecioConDescuento), 
    PrecioFinal is PrecioConDescuento* Cantidad. 

totalAPagar(Cliente, Total):-
    cliente(Cliente),
    findall(PrecioFinal,(compro(Cliente, Producto, Cantidad), compraTotal(Producto, Cantidad, PrecioFinal)) , PreciosFinales),
    sum_list(PreciosFinales, Total).

%4
%dueño(MarcaPadre, Marca)
dueno(laSerenisima, gandara).
dueno(gandara,vacalin).

esPropiedadDe(Marca, OtraMarca):- dueno(Marca, OtraMarca).
esPropiedadDe(Marca, OtraMarca):- dueno(Marca, Tercero), esPropiedadDe(Tercero, OtraMarca).


%marca(Producto, Marca)
marca(arroz(Marca), Marca):- descuento(arroz(Marca),_).
marca(lacteo(Marca,_), Marca):- descuento(lacteo(Marca,_),_).
marca(salchichas(Marca,_), Marca):- descuento(salchichas(Marca,_),_).

clienteFiel(Cliente, Marca):-
    cliente(Cliente),
    marca(_, Marca),
    not((compro(Cliente, Producto,_), marca(Producto, OtraMarca), OtraMarca \= Marca )).

clienteFiel(Cliente, Marca):-
    cliente(Cliente),
    marca(_,Marca),
    compro(Cliente, Producto,_),
    marca(Producto, OtraMarca),
    esPropiedadDe(Marca, OtraMarca).    

%5
provee(Marca, Productos):-
    marca(_,Marca),
    findall(Producto, (producto(Producto), marca(Producto, Marca)), Productos).

provee(Marca, Productos):-
    marca(_,Marca),
    findall(Producto, (producto(Producto), marca(Producto, OtraMarca), esPropiedadDe(Marca, OtraMarca) ), Productos).

