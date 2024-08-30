%atiende(Persona, DiaQueAtiende, HorarioInicio, HorairoFIn)
atiende(dodain, lunes, 9, 15).
atiende(dodain, miercoles, 9, 15).
atiende(dodain, viernes, 9, 15).
atiende(lucas, martes, 10, 20).
atiende(juanC, sabado, 18, 22).
atiende(juanC, domingo, 18, 22).
atiende(juanFdS, jueves, 10, 20).
atiende(juanFdS, viernes, 12, 20).
atiende(leoC, lunes, 14, 18).
atiende(leoC, miercoles, 14, 18).
atiende(martu, miercoles, 23, 24).

atiende(vale, Dia, HorarioInicio, HorairoFin):- atiende(dodain, Dia, HorarioInicio, HorairoFin).
atiende(vale, Dia, HorarioInicio, HorairoFin):- atiende(juanC, Dia, HorarioInicio, HorairoFin).

%Por principio de unverso cerrado, al decir que nadie hace el mismo horario que leoC, no tiene sentido crear la clausula, y como maiu esta pensando osaea que no confirmo nada, no lo ponemos

%2
horarioDeAtencion(Persona, Dia, HorarioPuntual):-
    atiende(Persona, Dia, HorarioInicio, HorarioFin),
    between(HorarioInicio, HorarioFin, HorarioPuntual).

%3
foreverAlone(Persona, Dia, HoraPuntual):-
    horarioDeAtencion(Dia, HoraPuntual, Persona),
    not((horarioDeAtencion(Dia, HoraPuntual, OtraPersona), OtraPersona\=Persona)).

%4

posibilidadesAtencion(Dia, Personas):-
    findall(Persona, distinct(Persona, horarioDeAtencion(Persona, Dia, _)), PersonasPosibles),
    combinar(PersonasPosibles, Personas).
  
  combinar([], []).
  combinar([Persona|PersonasPosibles], [Persona|Personas]):-combinar(PersonasPosibles, Personas).
  combinar([_|PersonasPosibles], Personas):-combinar(PersonasPosibles, Personas).

%findall, como herrameinta para poder generar un cnjunto de soluciones que satisfacen un predicado
%mecansimo de backtracking de prlog que permite encontrar todas las soluciones posibles

%5
venta(dodain, fecha(10,8), [golosinas(1200), cigarrillos([jockey]), golosinas(50)]).
venta(dodain, fecha(12,8), [bebidas(esAlcholica, 8), bebidas(noEsAlcholica, 1), golosinas(10)]).
venta(martu, fecha(12,8), [golosinas(1000), cigarrillos([chesterfield,colorado, parisiennes])]).
venta(lucas, fecha(11,8), [golosinas(600)]).
venta(lucas, fecha(18,8), [bebidas(noEsAlcholica, 2), cigarrillos([derby])]).

esSuertudo(Persona):-
    venta(Persona,_,_),
    forall(venta(Persona, _, [Venta|_]), esImportante(Venta)).

esImportante(golosinas(Valor)):- Valor > 100.
esImportante(cigarrillos(Marcas)):- length(Marcas, Cantidad),Cantidad > 2.
esImportante(bebidas(esAlcholica,_)).
esImportante(bebidas(_,Cantidad)):- Cantidad > 5.
