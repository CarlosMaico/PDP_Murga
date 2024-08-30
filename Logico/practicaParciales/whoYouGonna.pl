%herramientasRequeridas(TareaARealizar, ListaDeHerrameintasQueNEcesita)
herramientasRequeridas(ordenarCuarto, [aspiradora(100), trapeador, plumero]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]). % aspiradora potenciaminimapar la tarea

%1
%tiene(Integrante, Herrameinta)
tiene(egon, aspiradora(200)).
tiene(egon, trapeador).
tiene(peter, trapeador).
tiene(winston, varitaDeNeutrones).

integrante(Integrante):- tiene(Integrante,_).
herramienta(Herramienta):- tiene(_, Herramienta).

%2
satisfaceNecesidad(Integrante, Herramienta):-  %Aca hay polimorfismo
    tiene(Integrante, Herramienta).

satisfaceNecesidad(Integrante, aspiradora(PotenciaRequerida)):-
    tiene(Integrante, aspiradora(Potenica)),
    between(0, Potenica, PotenciaRequerida). %pongo between par ue sea inversible
 

%6
satisfaceNecesidad(Persona, ListaReemplazables):- 
    member(Herramienta, ListaReemplazables),
    satisfaceNecesidad(Persona, Herramienta).

%3
realiza(Persona, Tarea):-
    herramientasRequeridas(Tarea,_),
    tiene(Persona, varitaDeNeutrones).

realiza(Persona, Tarea):-
    tiene(Persona,_),
    herramientasRequeridas(Tarea,_),
    forall(poseeHerramientasParaTarea(Tarea, Herramienta), satisfaceNecesidad(Persona, Herramienta)).

poseeHerramientasParaTarea(Tarea, Herramienta):-
    herramientasRequeridas(Tarea, ListaHerramientas),
    member(Herramienta, ListaHerramientas).

%4
%tareaPedida(tarea, cliente, metrosCuadrados).
tareaPedida(ordenarCuarto, dana, 20).
tareaPedida(cortarPasto, walter, 50).
tareaPedida(limpiarTecho, walter, 70).
tareaPedida(limpiarBanio, louis, 15).

%precio(tarea, precioPorMetroCuadrado).
precio(ordenarCuarto, 13).
precio(limpiarTecho, 20).
precio(limpiarBanio, 55).
precio(cortarPasto, 10).
precio(encerarPisos, 7).

cliente(Cliente):- tareaPedida(_,Cliente,_).

precioACobrar(Cliente, PrecioACobrar):-
    cliente(Cliente),
    findall(Precio, calculoDePrecio(Cliente, Precio), Precios),
    sumlist(Precios, PrecioACobrar).

calculoDePrecio(Cliente, Precio):-
    tareaPedida(Tarea, Cliente, Metros),
    precio(Tarea, PrecioPorMetro),
    Precio is PrecioPorMetro * Metros.


%5
aceptaPedido(Integrante, Cliente):-
    integrante(Integrante),
    cliente(Cliente),
    forall(tareaPedida(Tarea, Cliente,_), realiza(Integrante, Tarea)),
    estaDispuestoAAceptarPedido(Integrante, Cliente).

estaDispuestoAAceptarPedido(ray,Cliente):- not(tareaPedida(limpiarTecho,Cliente,_)).
estaDispuestoAAceptarPedido(winston, Cliente):- precioACobrar(Cliente, Precio), Precio >= 500.
estaDispuestoAAceptarPedido(egon, Cliente):- not((tareaPedida(Tarea, Cliente,_), esCompleja(Tarea))).
estaDispuestoAAceptarPedido(peter,_).

esCompleja(Tarea):- 
    herramientasRequeridas(Tarea, ListaDeHerrameintasQueNEcesita), length(ListaDeHerrameintasQueNEcesita, Cantidad), Cantidad>2.
esCompleja(limpiarTecho).


%6Para slucionar solo creamo una lista auxilirar que contenga las herramientasreemplazables, y el unico cambio que habria que hacer es en
%satisface necesidad debido a que ahi se hace el tratamiento con la herramienta y ahcemos una llamada recursiva por si hay una herrameitna
%reemplazable, por lo tanto ahi es facild e icnroporar por el polimorfismo ya que va a trata tanto a los hechos sin herrameinta reemplzanbles
%como aquellos que si las tienen