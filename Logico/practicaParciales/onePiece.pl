% Relaciona Pirata con Tripulacion
tripulante(luffy, sombreroDePaja).
tripulante(zoro, sombreroDePaja).
tripulante(nami, sombreroDePaja).
tripulante(ussop, sombreroDePaja).
tripulante(sanji, sombreroDePaja).
tripulante(chopper, sombreroDePaja).
tripulante(law, heart).
tripulante(bepo, heart).
tripulante(arlong, piratasDeArlong).
tripulante(hatchan, piratasDeArlong).

% Relaciona Pirata, Evento y Monto
impactoEnRecompensa(luffy, arlongPark, 30000000).
impactoEnRecompensa(luffy, baroqueWorks, 70000000).
impactoEnRecompensa(luffy, eniesLobby, 200000000).
impactoEnRecompensa(luffy, marineford, 100000000).
impactoEnRecompensa(luffy, dressrosa, 100000000).
impactoEnRecompensa(zoro, baroqueWorks, 60000000).
impactoEnRecompensa(zoro, eniesLobby, 60000000).
impactoEnRecompensa(zoro, dressrosa, 200000000).
impactoEnRecompensa(nami, eniesLobby, 16000000).
impactoEnRecompensa(nami, dressrosa, 50000000).
impactoEnRecompensa(ussop, eniesLobby, 30000000).
impactoEnRecompensa(ussop, dressrosa, 170000000).
impactoEnRecompensa(sanji, eniesLobby, 77000000).
impactoEnRecompensa(sanji, dressrosa, 100000000).
impactoEnRecompensa(chopper, eniesLobby, 50).
impactoEnRecompensa(chopper, dressrosa, 100).
impactoEnRecompensa(law, sabaody, 200000000).
impactoEnRecompensa(law, descorazonamientoMasivo, 240000000).
impactoEnRecompensa(law, dressrosa, 60000000).
impactoEnRecompensa(bepo, sabaody, 500).
impactoEnRecompensa(arlong, llegadaAEastBlue,20000000).
impactoEnRecompensa(hatchan, llegadaAEastBlue, 3000).

%1 
participaronDelMismoEvento(Tripulacion1, Tripulacion2, Evento):-
    participoDeEvento(Tripulacion1, Evento),
    participoDeEvento(Tripulacion2, Evento),
    Tripulacion1 \= Tripulacion2.

participoDeEvento(Tripulacion, Evento):- 
    impactoEnRecompensa(Pirata,Evento, _),
    tripulante(Pirata, Tripulacion).

%2

pirataMasDestacado(Pirata, Evento):-
    impactoEnRecompensa(Pirata, Evento, Recompensa),
    not((impactoEnRecompensa(OtroPirata, Evento, OtraRecompensa), OtroPirata \= Pirata, OtraRecompensa > Recompensa)).
    
%3

pasoDesapercibido(Pirata, Evento):-
    tripulante(Pirata, Tripulacion),
    participoDeEvento(Tripulacion, Evento),
    not(impactoEnRecompensa(Pirata, Evento,_)).
    
%4
recompensaTotal(Tripulacion, RecompensaTotal):-
    tripulante(_, Tripulacion),
    findall(RecompensaAcutal, (tripulante(Pirata, Tripulacion), recompensaActual(Pirata, RecompensaAcutal)), RecompensasTripulantes),
    sum_list(RecompensasTripulantes, RecompensaTotal).

recompensaActual(Pirata, RecompensaActual):- 
    tripulante(Pirata,_),
    findall(Recompensa, impactoEnRecompensa(Pirata, _, Recompensa), RecompensasEventos),
    sum_list(RecompensasEventos, RecompensaActual).
    
%5
tripulacionTemible(Tripulacion):-
    tripulante(_, Tripulacion),
    forall(tripulante(Pirata, Tripulacion), peligroso(Pirata)).
tripulacionTemible(Tripulacion):- recompensaTotal(Tripulacion, RecompensaTotal), RecompensaTotal>500000000.

peligroso(Pirata):-
    recompensaActual(Pirata, RecompensaActual), RecompensaActual > 100000000.

%6a

peligroso(Pirata):-
    comio(Pirata, Fruta),  %este predicado comio debe ser inversible, e independientemente de la fruta deberia funcionarfr
    frutaPeligrosa(Fruta).


comio(luffy, paramecia(gomugomu)).
comio(buggy, paramecia(barabara)).
comio(law, paramecia(opeope)).
comio(chopper, zoan(hitohito, humano)).
comio(lucci, zoan(nekoneko, leopardo)).
comio(smoker, logia(mokumoku, humo)).

frutaPeligrosa(paramecia(opeope)).
frutaPeligrosa(zoan(_, Especie)):- especieFeroz(Especie).
frutaPeligrosa(logia(_, _)).

especieFeroz(lobo).
especieFeroz(leopardo).
especieFeroz(anaconda).


%7

piratasDeAsfalto(Tripulacion):-
    tripulante(_, Tripulacion),
    not((tripulante(Pirata, Tripulacion), puedeNadar(Pirata))).

puedeNadar(Persona):- not(comio(Persona, _)).