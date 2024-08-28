%Lsitas - Recursividad- Explosion Combinaotria
encolar(Elem, [], [Elem]).
encolar(Elem, [Cab|Cola], [Cab|Resto]):- encolar(Elem,Cola, Resto).

maximo(Lista,Maximo):- member(Maximo, Lista), 
    forall(member(OtroElem, Lista), OtroElem =< Maximo).

esCreciente([_]).
esCreciente([Elem, OtroElem|Cola]):- Elem < OtroElem, esCreciente([OtroElem|Cola]).

subListaMayoresA([],_,[]).
subListaMayoresA([Cab|Cola], Elem, [Cab|Resto]):-Cab > Elem, subListaMayoresA(Cola, Elem, Resto).
subListaMayoresA([_|Cola], Elem, Lista):- subListaMayoresA(Cola,Elem, Lista).


% Gustos cinefilos
genero(titanic,drama).
genero(gilbertGrape,drama).
genero(atrapameSiPuedes,comedia).
genero(ironMan,accion).
genero(rapidoYFurioso,accion).
genero(elProfesional,drama).

gusta(belen,titanic).
gusta(belen,gilbertGrape).
gusta(belen,elProfesional).
gusta(juan, ironMan).
gusta(pedro, atrapameSiPuedes).
gusta(pedro, rapidoYFurioso).

soloLeGustaPeliculaDeGenero(Persona,Genero):- 
    persona(Persona),
    genero(_,Genero),
    forall(gusta(Persona, Pelicula), genero(Pelicula, Genero)).

persona(Persona):- gusta(Persona,_).

peliculasQueLeGustaPorGenero(Persona,Genero,ListaPelis):-
    persona(Persona),
    genero(_,Genero),
    findall(Pelicula,gusteElGeneroDelaPeli(Persona, Genero, Pelicula) , ListaPelis).

gusteElGeneroDelaPeli(Persona,Genero,Pelicula):-gusta(Persona,Pelicula), genero(Pelicula,Genero).


%Como elegir doonde ir de vacacoines

lugar(marDelPlata, hotel(elviajante,4,1500)).
lugar(marDelPlata, hotel(casaNostra,3,1000)).
lugar(lasToninas, hotel(holydays,2,500)).
lugar(lasToninas, carpa(60)).
lugar(tandil, quinta(amanecer, pileta, 650)).
lugar(bariloche, casa(pileta, 600)).
lugar(laFlada, carpa(70)).
lugar(rosario, casa(garage, 400)).

puedeGastar(ana, 4, 10000).
puedeGastar(hernan,5,8000).
puedeGastar(mario,5,4000).

puedeIr(Persona, Lugar, Alojamiento):- puedeGastar(Persona, CantDias, SaldoDisponible), lugar(Lugar, Alojamiento),
    cumpleCondiciones(Alojamiento, MontoDiario), Total is CantDias * MontoDiario, Total =< SaldoDisponible.

cumpleCondiciones(hotel(_, CantEstrellas, MontoDia), MontoDia):- CantEstrellas > 3.
cumpleCondiciones(casa(garage, MontoDia), MontoDia).
cumpleCondiciones(quinta(_, pileta, MontoDia), MontoDia).
cumpleCondiciones(carpa(MontoDia), MontoDia).

vaAcualquierLugar(Persona):- 
    puedeGastar(Persona,_,_),
    forall(lugar(Lugar, _), puedeIr(Persona, Lugar, _)).
    

%TEG

continente(americaDelSur).
continente(americaDelNorte).
continente(asia).
continente(oceania).

estaEn(americaDelSur, argentina).
estaEn(americaDelSur, brasil).
estaEn(americaDelSur, chile).
estaEn(americaDelSur, uruguay).
estaEn(americaDelNorte, alaska).
estaEn(americaDelNorte, yukon).
estaEn(americaDelNorte, canada).
estaEn(americaDelNorte, oregon).
estaEn(asia, kamtchatka).
estaEn(asia, china).
estaEn(asia, siberia).
estaEn(asia, japon).
estaEn(oceania,australia).
estaEn(oceania,sumatra).
estaEn(oceania,java).
estaEn(oceania,borneo).

jugador(amarillo).
jugador(magenta).
jugador(negro).
jugador(blanco).

aliados(X,Y):- alianza(X,Y).
aliados(X,Y):- alianza(Y,X).
alianza(amarillo,magenta).

%el numero son los ejercitos
ocupa(argentina, magenta, 5).
ocupa(chile, negro, 3).
ocupa(brasil, amarillo, 8).
ocupa(uruguay, magenta, 5).

ocupa(alaska, amarillo, 7).
ocupa(yukon, amarillo, 1).
ocupa(canada, amarillo, 10).
ocupa(oregon, amarillo, 5).
ocupa(kamtchatka, negro, 6).
ocupa(china, amarillo, 2).
ocupa(siberia, amarillo, 5).
ocupa(japon, amarillo, 7).
ocupa(australia, negro, 8).
ocupa(sumatra, negro, 3).
ocupa(java, negro, 4).
ocupa(borneo, negro, 1).

% Usar este para saber si son limitrofes ya que es una relacion simetrica
sonLimitrofes(X, Y) :- limitrofes(X, Y).
sonLimitrofes(X, Y) :- limitrofes(Y, X).

limitrofes(argentina,brasil).
limitrofes(argentina,chile).
limitrofes(argentina,uruguay).
limitrofes(uruguay,brasil).
limitrofes(alaska,kamtchatka).
limitrofes(alaska,yukon).
limitrofes(canada,yukon).
limitrofes(alaska,oregon).
limitrofes(canada,oregon).
limitrofes(siberia,kamtchatka).
limitrofes(siberia,china).
limitrofes(china,kamtchatka).
limitrofes(japon,china).
limitrofes(japon,kamtchatka).
limitrofes(australia,sumatra).
limitrofes(australia,java).
limitrofes(australia,borneo).
limitrofes(australia,chile).

loLiquidaron(Jugador):- jugador(Jugador), not(ocupa(_, Jugador,_)).

ocupaContinente(Jugador, Continente):- jugador(Jugador), continente(Continente), forall(estaEn(Continente, Pais), ocupa(Pais, Jugador,_)).

seAtrinchero(Jugador):- jugador(Jugador), continente(Continente), forall(ocupa(Pais, Jugador,_), estaEn(Continente, Pais)).

elQueTieneMasEjercitos(Jugador, Pais):- ocupa(Pais, Jugador, CantEjercito), forall(ocupa(_,_, OtraCantEjer), CantEjercito >= OtraCantEjer).


%PArte siguiente
objetivo(amarillo, ocuparContinente(asia)).
objetivo(amarillo,ocuparPaises(2, americaDelSur)). 
objetivo(blanco, destruirJugador(negro)). 
objetivo(magenta, destruirJugador(blanco)). 
objetivo(negro, ocuparContinente(oceania)).
objetivo(negro,ocuparContinente(americaDelSur)).

cumpleObjetivos(Jugador):- jugador(Jugador),
    forall(objetivo(Jugador, Objetivo), cumpleObjetivo(Objetivo, Jugador)).

cumpleObjetivo(ocuparContinente(Continente), Jugador):- ocupaContinente(Jugador, Continente).
cumpleObjetivo(ocuparPaises(Cant, Continente), Jugador):- cantidadDePaises(Jugador,Contiene, CantPaises), CantPaises >=Cant.
cantidadDePaises(Jugador, Continente, Cant):- findall(Pais, estaOcupado(Pais, Continente, Jugador), ListaPaises), length(ListaPaises, Cant).

estaOcupado(Pais, Continente, Jugador):- ocupa(Pais, Jugador,_), estaEn(Pais, Continente).
