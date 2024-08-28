%Parte 1

casa(gryffindor).
casa(slytherin).
casa(hufflepuff).
casa(ravenclaw).

sangre(harry, mestiza).
sangre(draco, pura).
sangre(hermione, impura).
sangre(neville, pura).
sangre(luna, pura).

mago(Mago):- sangre(Mago,_).

%1
permiteEntrar(Casa, Mago):- 
    casa(Casa),
    mago(Mago),
    Casa \= slytherin.
permiteEntrar(slytherin, Mago):- 
    sangre(Mago, TipoDeSangre),
    TipoDeSangre \= impura.

%2

tieneCaracteristica(harry, coraje).
tieneCaracteristica(harry, orgullo).
tieneCaracteristica(harry, amistad).
tieneCaracteristica(harry, inteligencia).

tieneCaracteristica(draco, inteligencia).
tieneCaracteristica(draco, orgullo).

tieneCaracteristica(hermione, inteligencia).
tieneCaracteristica(hermione, orgullo).
tieneCaracteristica(hermione, responsabilidad).

tieneCaracteristica(neville, responsabilidad).
tieneCaracteristica(neville, coraje).
tieneCaracteristica(neville, amistad).

tieneCaracteristica(luna, amistad).
tieneCaracteristica(luna, inteligencia).
tieneCaracteristica(luna, responsabilidad).




caracteristicaBuscada(gryffindor, coraje).
caracteristicaBuscada(slytherin, orgullo).
caracteristicaBuscada(slytherin, inteligencia).
caracteristicaBuscada(ravenclaw, inteligencia).
caracteristicaBuscada(ravenclaw, responsabilidad).
caracteristicaBuscada(hufflepuff, amistad).

tieneCaracterApropiado(Mago, Casa):-
    casa(Casa),
    mago(Mago),
    forall(caracteristicaBuscada(Casa, Caracteristica), tieneCaracteristica(Mago, Caracteristica)).


%3

odiariaEntrar(harry, slytherin).
odiariaEntrar(draco, hufflepuff).

puedeQuedarSeleccionadoPara(Mago, Casa):-
    tieneCaracterApropiado(Mago, Casa),
    permiteEntrar(Casa, Mago),
    not(odiariaEntrar(Mago, Casa)).
puedeQuedarSeleccionadoPara(hermione, gryffindor).


%4
cadenaDeAmistades(Magos):-
    todosAmistosos(Magos),
    cadenaDeCasas(Magos).

todosAmistosos(Magos):-
    forall(member(Mago, Magos), amistoso(Mago)).

amistoso(Mago):- tieneCaracteristica(Mago, amistad).

cadenaDeCasas([Mago1, Mago2 | MagosSiguientes]):-
    puedeQuedarSeleccionadoPara(Mago1, Casa),
    puedeQuedarSeleccionadoPara(Mago2, Casa),
    cadenaDeCasas([Mago2 | MagosSiguientes]).
cadenaDeCasas([_]).
cadenaDeCasas([]).


%PArte 2 Elipsis
%1

hizo(harry, fueraDeCama).
hizo(hermione, irA(tercerPiso)).
hizo(hermione, irA(seccionRestringida)).
hizo(harry, irA(bosque)).
hizo(harry, irA(tercerPiso)).
hizo(draco, irA(mazmorras)).
hizo(ron, buenaAccion(50, ganarAlAjedrezMagico)).
hizo(hermione, buenaAccion(50, salvarASusAmigos)).
hizo(harry, buenaAccion(60, ganarleAVoldemort)).
hizo(cedric, buenaAccion(100, ganarAlquidditch)).
hizo(hermione, responderPregunta(dondeSeEncuentraUnBezoar, 20, snape)).
hizo(hermione, responderPregunta(comoHacerLevitarUnaPluma, 25, flitwick)).


%1a
hizoAlgunaAccion(Mago):- hizo(Mago,_).

hizoAlgoMalo(Mago):- 
    hizo(Mago, Accion),
    puntajeQueGenera(Accion, Puntaje),
    Puntaje < 0.

esBuenAlumno(Mago):-
    hizoAlgunaAccion(Mago),
    not(hizoAlgoMalo(Mago)).

puntajeQueGenera(fueraDeCama, -50).  %Es polimorfico ya que actua segun las acciones que existen el predicado puntajeQueGenera
puntajeQueGenera(irA(Lugar), PuntajeQueResta):- 
    lugarProhibido(Lugar, Puntos),
    PuntajeQueResta is Puntos * -1.
puntajeQueGenera(buenaAccion(Puntaje,_), Puntaje).

puntajeQueGenera(responderPregunta(_, Dificultad, snape), Puntos):- Puntos is Dificultad // 2. %// es division entera
puntajeQueGenera(responderPregunta(_, Dificultad, Profesor), Dificultad):- Profesor \= snape.

lugarProhibido(bosque, 50).
lugarProhibido(seccionRestringida, 10).
lugarProhibido(tercerPiso, 75).

%1b

esRecurrente(Accion):-
    hizo(Mago, Accion),
    hizo(OtroMago, Accion),
    Mago \= OtroMago.

%2

esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).
esDe(cedric, hufflepuff).


puntajeTotalDeCasa(Casa, PuntajeTotal):-
    esDe(_, Casa),
    findall(Puntos,
    (esDe(Mago, Casa), puntosQueObtuvo(Mago, _, Puntos)),
    ListaPuntos),
    sum_list(ListaPuntos, PuntajeTotal).

puntosQueObtuvo(Mago, Accion, Puntos):-
    hizo(Mago, Accion),
    puntajeQueGenera(Accion, Puntos).

%3
casaGanadora(Casa):-
    puntajeTotalDeCasa(Casa, PuntajeMayor), % aca digo que el puntaje de aca es amyor
    forall((puntajeTotalDeCasa(OtraCasa, PuntajeMenor), OtraCasa \= Casa),  PuntajeMayor > PuntajeMenor).

%casaGanadora2(Casa):-
%    puntajeTotalDeCasa(Casa, PuntajeMayor),
%    not((puntajeTotalDeCasa(_ OtroPuntaje), OtroPuntaje > PuntajeMayor)).

%4   
    
