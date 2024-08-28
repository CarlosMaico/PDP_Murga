% festival(NombreDelFestival, Bandas, Lugar).
% Relaciona el nombre de un festival con la lista de los nombres de bandas que tocan en él y el lugar dónde se realiza.
festival(lollapalooza, [gunsAndRoses, theStrokes, ..., littoNebbia], hipodromoSanIsidro).

% lugar(nombre, capacidad, precioBase).
% Relaciona un lugar con su capacidad y el precio base que se cobran las entradas ahí.
lugar(hipodromoSanIsidro, 85000, 3000).

% banda(nombre, nacionalidad, popularidad).
% Relaciona una banda con su nacionalidad y su popularidad.
banda(gunsAndRoses, eeuu, 69420).

% entradaVendida(NombreDelFestival, TipoDeEntrada).
% Indica la venta de una entrada de cierto tipo para el festival 
% indicado.
% Los tipos de entrada pueden ser alguno de los siguientes: 
%     - campo
%     - plateaNumerada(Fila)
%     - plateaGeneral(Zona).
entradaVendida(lollapalooza, campo).
entradaVendida(lollapalooza, plateaNumerada(1)).
entradaVendida(lollapalooza, plateaGeneral(zona2)).

% plusZona(Lugar, Zona, Recargo)
% Relacion una zona de un lugar con el recargo que le aplica al precio de las plateas generales.
plusZona(hipodromoSanIsidro, zona1, 1500).


%1
itinerante(Festival):- %Aca  hago si un festival se de en mas de un lugar distinto
    festival(Festival, Bandas, UnLugar),
    festival(Festival, Bandas, OtroLugar),
    UnLugar\= OtroLugar.

%2
careta(personalFest).
careta(Festival):-
    festival(Festival,_,_),
    not(entradaVendida(Festival, campo)).

%3
nacAndPop(Festival):- 
    festival(Festival, Bandas,_),
    forall(member(Banda, Bandas), (banda(Banda, argentina, Popularidad), Popularidad > 1000)),
    not(careta(Festival)).

%4
sobrevendido(Festival):-
    festival(Festival, _, Lugar),  %Obtengo el lugar donde el festival se hizo
    lugar(Lugar, Capacidad,_),  %ME fijo cual es la capcaidad de ese lugar
    findall(Entrada, entradaVendida(Festival, Entrada), Entradas), % me fijo todas las entradas que se vendieron
    length(Entradas, Cantidad), % busco el tamaño de esa lista de entradas
    Cantidad > Capacidad.  % verifdoc que esa cantidad es amyor que la capacidad para que sea sobrevendido
    
%5  Prolog e aveces muy procedural, osea aveces el ordne importa pero si importa
recaudacionTotal(Festival, Recaudacion):-
    festival(Festival, _, Lugar),
    findall(Precio, (entradaVendida(Festival, Entrada), precio(Entrada, Lugar, Precio)), Precios), %Aca el orden importa Priemro se debe ligar la entrada si o si
    sum_list(Precios, Recaudacion).

precio(campo, Lugar, Precio):- lugar(Lugar, _, Precio).

precio(plateaGeneral(Zona), Lugar, Precio):- 
    lugar(Lugar,_,PrecioBase),
    plusZona(Lugar, Zona, Plus),
    Precio is PrecioBase + Plus.

precio(plateaNumerada(Fila), Lugar, Precio):-
    Fila =< 10,
    lugar(Lugar,_,PrecioBase),
    Precio is PrecioBase * 6.

precio(plateaNumerada(Fila), Lugar, Precio):-
    Fila > 10,
    lugar(Lugar,_,PrecioBase),
    Precio is PrecioBase * 3.


%6
delMismoPalo(UnaBanda, OtraBanda):-tocoCon(UnaBanda, OtraBanda).

delMismoPalo(UnaBanda, OtraBanda):-
    tocoCon(UnaBanda, TercerBanda), 
    banda(TercerBanda,_, PopularidadDeLaTercerBanda),  %desde aca hasta la linea 86 se puede poner enuna abstraccion
    banda(OtraBanda,_, PopularidadDeLaOtraBanda),
    PopularidadDeLaTercerBanda > PopularidadDeLaOtraBanda,
    delMismoPalo(TercerBanda, OtraBanda).  %Aca esta la recursividad


tocoCon(UnaBanda, OtraBanda):-  %Esto es inversible
    festival(_,Bandas,_),
    member(UnaBanda, Bandas),
    member(OtraBanda, Bandas),
    UnaBanda \= OtraBanda.

