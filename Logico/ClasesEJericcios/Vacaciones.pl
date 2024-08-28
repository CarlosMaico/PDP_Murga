%1
%seVaA(Persona, Lugar)
seVaA(dodain, pehuenia).
seVaA(dodain, sanMartin).
seVaA(dodain, esquel).
seVaA(dodain, sarmiento).
seVaA(dodain, camarones).
seVaA(dodain, playasDoradas).
seVaA(alf, bariloche).
seVaA(alf, sanMartin).
seVaA(alf, bolson).
seVaA(nico, marDelPlata).
seVaA(vale, calafate).
seVaA(vale, bolson).
seVaA(maico, pehuenia).

seVaA(martu, Lugar):- seVaA(nico, Lugar).
seVaA(martu, Lugar):- seVaA(alf, Lugar).

%Bueno el redicado es seVaA de aridad 2 que relacion la persona y el lugar de destino, cuando dicen que No saben a donde vn esntonces eso lo tomamos como false por universo cerrado no es neceseario realizar un predicado para ello

%2
%tiene(Lugar, Atraccion)

tiene(esquel, parqueNacional(losAlerces)).
tiene(esquel, excursion(trochita)).
tiene(esquel, excursion(trevelin)).
tiene(pehuenia, cerro(bateaMahuida, 2000)).
tiene(pehuenia, cuerpoDeAgua(sePesca, 14)).
tiene(pehuenia, cuerpoDeAgua(sePesca, 19)).

persona(Persona):- seVaA(Persona,_). % Generdaor

vacacionesCopadas(Persona):- 
    persona(Persona),
    forall(seVaA(Persona, Lugar), tieneAtraccionCopada(Lugar)).

tieneAtraccionCopada(Lugar):- tiene(Lugar, Atraccion), esCopada(Atraccion).   

esCopada(cerro(_, Altura)):- Altura > 2000.
esCopada(cuerpoDeAgua(sePesca,_)).
esCopada(cuerpoDeAgua(_,Temperatura)):- Temperatura > 20.
esCopada(playa(Diferencia)):- Diferencia < 5.
esCopada(excursion(Nombre)):- atom_length(Nombre, Cantidad), Cantidad > 7.
esCopada(parqueNacional(_)).
    

%3
noSeCruzaron(Uno, Otro):-
    persona(Uno),
    persona(Otro),
    Uno \= Otro,  %Siempre poner que lque sean ditinsot antes de un funcon de ordne superior
    not((seCruzaron(Uno, Otro))).

seCruzaron(Uno, Otro):- 
    seVaA(Uno, Lugar),
    seVaA(Otro, Lugar).

%4
costoDeVida(sarmiento, 100).
costoDeVida(esquel, 150).
costoDeVida(pehuenia, 180).
costoDeVida(sanMartin, 150).
costoDeVida(camarones, 135).
costoDeVida(playasDoradas, 170).
costoDeVida(bariloche, 140).
costoDeVida(calafate, 240).
costoDeVida(bolson, 145).
costoDeVida(marDelPlata, 140).

vacacionesGasolera(Persona):- 
    persona(Persona),
    forall(seVaA(Persona, Lugar), esGasolero(Lugar)).

 esGasolero(Lugar):-
    costoDeVida(Lugar, Costo), Costo < 160.   


%5
itinerario(Persona, Itinerario):- 
    persona(Persona),
    lugaresAVistar(Persona, Lugares),
    permutacion(Lugares, Itinerario).

lugaresAVistar(Persona, Lugares):-
    findall(Lugar, seVaA(Persona, Lugar), Lugares).

permutacion([],[]).
permutacion(Lugares, [Lugar|Resto]):-
    member(Lugar, Lugares),
    sacar(Lugares, Lugar, NuevaLista),
    permutacion(NuevaLista, Resto).

    
sacar([Lugar|Resto], Lugar, Resto).
sacar([Otro| Resto], Lugar, [Otro| Lista]):- 
    Otro \= Lugar,
    sacar(Resto, Lugar, Lista).