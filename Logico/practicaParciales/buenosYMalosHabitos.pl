gusto(julia, estudiar(ssoo, 2)).
gusto(julia, jugar(lol, 7)).
gusto(marcos, criticarA(nacho)).
gusto(pedro, practicarDeporte(futbol, 2)).
gusto(nacho, jugar(minecraft,6)).
gusto(nacho, jugar(lol, 6)).
gusto(nacho, criticarA(camila)).
gusto(sofia, estudiar(pdep, 3)).
gusto(sofia, jugar(minecraft,4)).
gusto(camila, estudiar(pdep, 2)).
gusto(camila, practicarDeporte(natacion, 3)).

gusto(martin, criticarA(Persona)):- gusto(Persona, jugar(_, Tiempo)), Tiempo > 4.
gusto(camila, Habito):- gusto(sofia, Habito), not(gusto(julia, Habito)).
gusto(laura, jugar(minecraft, 3)).

persona(Persona):- gusto(Persona,_).

esLaPerdicion(Persona):-
        persona(Persona),
        forall(gusto(Persona, Habito), esMalHabito(Habito)).
        

esMalHabito(jugar(_, Tiempo)):- Tiempo > 5.
esMalHabito(criticarA(OtraPersona)):- gusto(OtraPersona, estudiar(pdep,_)).


esVago(Persona):-
        persona(Persona),
        not(gusto(Persona, estudiar(_,_))),
        juegaTodosLosJuegos(Persona).

juego(jugar(Juego,_), Juego):- gusto(_, jugar(Juego,_)).

juegaTodosLosJuegos(Persona):-
        forall(juego(_, Juego), gusto(Persona, jugar(Juego,_))).

esFeliz(Persona):-
        persona(Persona),
        tiempoTotalGastado(Persona, TiempoTotal),
        TiempoTotal > 8.

tiempoTotalGastado(Persona, TiempoTotal):-
        findall(Tiempo, (gusto(Persona, Habito), tiempoDelHabito(Habito, Tiempo)), Tiempos),
        sum_list(Tiempos, TiempoTotal).
        

tiempoDelHabito(estudiar(_, Tiempo), Tiempo).
tiempoDelHabito(jugar(_, Tiempo), Tiempo).
tiempoDelHabito(criticarA(_), 1).
tiempoDelHabito(practicarDeporte(_, Tiempo), Tiempo).

tieneUnicoHabitoSaludable(Persona):-
        poseeHabitoBueno(Persona, Habito),
        not((poseeHabitoBueno(Persona, OtroHabito), OtroHabito \= Habito)).
        
poseeHabitoBueno(Persona, Habito):-
        gusto(Persona, Habito),
        esBueno(Habito).

esBueno(estudiar(_,_)).
esBueno(practicarDeporte(_,_)).

esAmigo(julia, marcos).
esAmigo(marcos, pedro).
esAmigo(julia, marcos).
esAmigo(pedro, nacho).
esAmigo(pedro, sofia).
esAmigo(sofia, camila).
esAmigo(sofia, martin).

mantenerAlejado(UnaPersona, OtraPersona):-
        persona(UnaPersona),
        persona(OtraPersona),
        not(esVago(UnaPersona)),
        not(esLaPerdicion(UnaPersona)),
        amigoIndirecto(OtraPersona, UnaPersona),
        malaInfluencia(OtraPersona).

amigoIndirecto(OtraPersona, UnaPersona):- esAmigo(OtraPersona, UnaPersona).
amigoIndirecto(OtraPersona, UnaPersona):- esAmigo(OtraPersona, UnTercero), amigoIndirecto(UnTercero, UnaPersona).

malaInfluencia(OtraPersona):- esVago(OtraPersona).
malaInfluencia(OtraPersona):- esLaPerdicion(OtraPersona).