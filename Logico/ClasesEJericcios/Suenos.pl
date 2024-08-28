%1
%cree(Persona, Personaje)

cree(gabriel, campanita).
cree(gabriel, magoDeOz).
cree(gabriel, cavenaghi).
cree(juan, conejoDePascua).
cree(macarena, reyesMagos).
cree(macarena, magoCapria).
cree(macarena, campanita).

quiere(gabriel, ganarLoteria([5,9])).
quiere(gabriel, futbolista(arsenal)).
quiere(juan, cantante(100000)).
quiere(macarena, cantante(10000)).

%creammos un functor por cada sueño que hay para tener un manejo independiente

%2
persona(Persona):- cree(Persona,_).

esAmbicioso(Persona):-
    persona(Persona),
    findall(DificultadSueno, dificultadDeSueno(Persona, DificultadSueno), DificultadesDeSuenos),
    sum_list(DificultadesDeSuenos, TotalSuenos),
    TotalSuenos > 20.
    

dificultadDeSueno(Persona, DificultadSueno):- 
    quiere(Persona, Deseo),
    dificultad(Deseo, DificultadSueno).

dificultad(cantante(DiscosVendidos), 6):- DiscosVendidos >= 500000.
dificultad(cantante(DiscosVendidos), 4):- DiscosVendidos < 500000. 
dificultad(ganarLoteria(NumerosApostados), DificultadSueno):- length(NumerosApostados, Cantidad), DificultadSueno is 10*Cantidad.
dificultad(futbolista(Equipo), 3):- equipoChico(Equipo).
dificultad(futbolista(Equipo), 16):- not(equipoChico(Equipo)).

equipoChico(arsenal).
equipoChico(aldosivi).

%3

tieneQuimica(Personaje, Persona):-
    cree(Persona, Personaje),
    cumpleCondicionesDeQuimica(Persona, Personaje).

cumpleCondicionesDeQuimica(Persona, campanita):-
    dificultadDeSueno(Persona, DificultadSueno),
    DificultadSueno < 5.

cumpleCondicionesDeQuimica(Persona, Personaje):-
    Personaje \= campanita,
    todosLosSuenosPuros(Persona),
    not(esAmbicioso(Persona)).

todosLosSuenosPuros(Persona):-
    forall(quiere(Persona, Sueno), esPuro(Sueno)).
    

esPuro(futbolista(_)).
esPuro(cantante(Discos)):- Discos < 200000.

%4
alegra(Personaje, Persona):-
    quiere(Persona, _),
    tieneQuimica(Personaje, Persona),
    cumpleCriterioDeAlegria(Personaje).

cumpleCriterioDeAlegria(Personaje):- not(estaEnfermo(Personaje)).
cumpleCriterioDeAlegria(Personaje):- backup(Personaje, Backup), cumpleCriterioDeAlegria(Backup).

backup(UnPersonaje, OtroPersonaje):- esAmigo(UnPersonaje, OtroPersonaje).
backup(UnPersonaje, OtroPersonaje):- esAmigo(UnPersonaje, Backup), esAmigo(Backup, OtroPersonaje).

esAmigo(campanita, reyesMagos).
esAmigo(campanita, conejoDePascua).
esAmigo(conejoDePascua, cavenaghi).

estaEnfermo(campanita).
estaEnfermo(reyesMagos).
estaEnfermo(conejoDePascua).




