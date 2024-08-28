%jugador(jugador,civilizacion, tecnologias)
jugador(ana,romanos,[herreria, forja, emplumado,laminas]).
jugador(beto,incas,[herreria, forja,fundicion]).
jugador(carola,romanos,[herreria]).
jugador(dimitri,romanos,[herreria, fundicion]).

expertoEnMetales(Jugador):- jugador(Jugador,_,Tecnologias),
    tecnologiaMetales(Tecnologias), member(fundicion,Tecnologias).
expertoEnMetales(Jugador):- jugador(Jugador,_,Tecnologias),
    tecnologiaMetales(Tecnologias), jugador(Jugador,romanos,_).

tecnologiaMetales(Tecnologias):- member(herreria,Tecnologias), member(forja,Tecnologias).

%Integrante 1
civilizacionPopular(Civilizacion):- jugador(_,Civilizacion,_),
    findall(Jugador, jugador(Jugador,Civilizacion,_), Jugadores), length(Jugadores, Cantidad), Cantidad>1.

%Unidades
jugador(ana, [jinete(caballo), piquero(1, conEscudo), piquero(2,sinEscudo)]).
jugador(beto, [campeon(100), campeon(80) ,piquero(1, conEscudo), jinete(camello)]).
jugador(carola, [piquero(3,sinEscudo), piquero(2,conEscudo)]).

vidaDeUnidad(jinete(caballo), 90).
vidaDeUnidad(jinete(camello), 80).
vidaDeUnidad(campeon(Vida), Vida).
vidaDeUnidad(piquero(1, sinEscudo), 50).
vidaDeUnidad(piquero(2, sinEscudo), 65).
vidaDeUnidad(piquero(3, sinEscudo), 70).
vidaDeUnidad(piquero(NivelEscudo, conEscudo), VidaConEscudo):-
    vidaDeUnidad(piquero(NivelEscudo, sinEscudo), Vida),
    VidaConEscudo is (Vida * 1.1).


%Integrante 1
sobreviveAUnAsedio(Jugador):- jugador(Jugador, Unidades),
    findall(1, member(piquero(_,escudo), Unidades), Escudos),
    findall(1, member(piquero(_,sinEscudo), Unidades), SinEscudos),    
    length(Escudos,CantidadEscudos),
    length(SinEscudos,CanidadSinEscudos),
    CantidadEscudos > CanidadSinEscudos.

% Definición del árbol de tecnologías
tecnologia(herreria, emplumado).
tecnologia(emplumado, punzon).
tecnologia(herreria, forja).
tecnologia(forja, fundicion).
tecnologia(fundicion, horno).
tecnologia(herreria, laminas).
tecnologia(laminas, malla).
tecnologia(malla, placas).

tecnologia(molino, collera).
tecnologia(collera, arado).


% Regla que verifica si una tecnología depende de otra directamente
depende_de(Tec1, Tec2) :-
    tecnologia(Tec1, Tec2).

% Regla que verifica si una tecnología depende de otra indirectamente
depende_de(Tec1, Tec3) :-
    tecnologia(Tec1, Tec2), 
    depende_de(Tec2, Tec3).

% Regla que verifica si una tecnología puede ser desarrollada dada una lista de tecnologías desarrolladas
/*puede_desarrollar(Tec, Desarrolladas) :-
    not(member(Tec, Desarrolladas)), % La tecnología no debe estar ya desarrollada
    forall(depende_de(TecPrevia, Tec), member(TecPrevia, Desarrolladas)).
*/
% Regla que verifica si un jugador puede desarrollar una tecnología
puede_desarrollar_jugador(Jugador, Tec) :-
    jugador(Jugador, _, Desarrolladas),
    depende_de(Tec,_),
    depende_directa_o_indirectamente(Tec, Desarrolladas),
    not(member(Tec, Desarrolladas)).

% Regla que verifica si todas las dependencias de una tecnología están en la lista de desarrolladas
depende_directa_o_indirectamente(Tec, Desarrolladas) :-
    forall(depende_de(TecPrevia, Tec), member(TecPrevia, Desarrolladas)).

/*
% Regla que verifica si una tecnología depende de otra directa o indirectamente
depende_de(TecBase, TecDep) :-
    tecnologia(TecBase, TecDep).
depende_de(TecBase, TecDep) :-
    tecnologia(TecBase, Intermedia),
    depende_de(Intermedia, TecDep).

% Regla que obtiene todas las dependencias de una tecnología
todas_las_dependencias(Tec, Dependencias) :-
    findall(Dep, depende_de(Dep, Tec), DependenciasUnicas),
    list_to_set(DependenciasUnicas, Dependencias). % Elimina duplicados

puede_desarrollar_tecnologia(Jugador, Tec) :-
    todas_las_dependencias(Tec, Dependencias),
    jugador(Jugador, TecnologiasDesarrolladas),
    subset(Dependencias, TecnologiasDesarrolladas).

*/