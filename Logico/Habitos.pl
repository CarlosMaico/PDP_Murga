%gusto(Persona, Habito).

gusto(maico, jugar(lol, 8)).
gusto(maico, jugar(minecraft, 8)).

persona(Persona):- gusto(Persona, _).
habito(Habito):- gusto(_,Habito).

juego(jugar(Juego, _), Juego):- gusto(_,jugar(Juego,_)).

esVago(Persona):-
    persona(Persona),
    not(gusto(Persona, estudiar(_,_))),
    juegaTodosLosJuegos(Persona).

juegaTodosLosJuegos(Persona):-
    forall((gusto(Persona, Habito), juego(Habito, Juego)), loJuega(Persona, Juego)).

loJuega(_, lol).
loJuega(_, minecraft).
    