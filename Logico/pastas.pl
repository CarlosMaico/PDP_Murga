
/*
%HEchos
pastas(ravioles).
pastas(fideos).
pastas(sorrentions).
pastas(fetuccini).

%Preguntas a la base de conociemitnos
%1 - pregutnas individules  2- Existe alguna  3- Consulta tipo existencial(me devuleve los que son pasatas con el nombre) 

plato(ravioles,fileto).
plato(ravioles,bolognes).
plato(sorrentions,cuatroQuesos).
plato(fetuccini,pesto).
plato(fetuccini,bolognes).
plato(fetuccini,fileto).


%Reglas
mortal(Peresona) :-humano(Peresona).
humano(socrates).
humano(platon).

%Predicados

programaEn(nahuel,java).
programaEn(juan,haskell).
programaEn(juan,ruby).
programaEn(caro,haskell).
programaEn(caro,scala).
programaEn(caro,java).

personaImprescendivble(Persona):-
    programaEn(Persona, Lenguaje),  %Unifica generador
    not(
        (programaEn(OtraPersona, Lenguaje),
        Persona \= OtraPersona)
    ).

*/
%quedaEn(Lugar, Lugar)  %plantear lo que uno sabe y dejar que el motro actue
quedaEn(venezuela, america).
quedaEn(argentina, america).
quedaEn(patagonia, argentina).
quedaEn(aula522, utn).
quedaEn(utn, buenosAires).
quedaEn(buenosAires, argentina).

nacioEn(dani, buenosAires).
nacioEn(alf, buenosAires).
nacioEn(nico, buenosAires).

lugarTorneo(primeraDivision, buenosAires).

%hizoTarea(Persona, Tarea, Fecha)
hizoTarea(dani, tomarExamen(paradigmaLogico, aula522), fecha(10,8,2023)).
hizoTarea(dani, hizoGol(primeraDivision), fecha(10,8,2023)).
hizoTarea(alf, discurso(utn, 0), fecha(11,8,2023)).

%1
nuncaSalioDeCasa(Persona):-
    nacioEn(Persona, Lugar),
    hizoTarea(Persona, _,_),
    forall(tareaEnLugar(Persona, OtroLugar), pertenece(OtroLugar, Lugar)).

tareaEnLugar(Persona, Lugar):-
    hizoTarea(Persona, Tarea,_),
    lugarTarea(Tarea, Lugar).

pertenece(Lugar, OtroLugar):- quedaEn(Lugar, OtroLugar).
pertenece(Lugar, OtroLugar):- quedaEn(Lugar, Lugar2), pertenece(Lugar2, OtroLugar).

lugarTarea(tomarExamen(_,Lugar), Lugar).  %polimorfismo para tomar el lugar
lugarTarea(hizoGol(Torneo), Lugar):- lugarTorneo(Torneo, Lugar).
lugarTarea(discurso(Lugar,_), Lugar).



%2
esEstresante(Tarea):-
    hizoTarea(_,Tarea,_),
    lugarTarea(Tarea, Lugar),
    pertenece(Lugar, argentina),
    cumpleCondicionEstresante(Tarea).

cumpleCondicionEstresante(tomarExamen(Tema,_)):- esComplejo(Tema).  %Cumple polimorifosmo para verificar si esa tarea es estresante , el polimorfismo le da a cada tipo un trtamiento particular
cumpleCondicionEstresante(discurso(_, Expectadores)):- Expectadores >3000.
cumpleCondicionEstresante(hizoGol(_)).

esComplejo(paradigmaLogico).
esComplejo(paradigmaFuncional).
esComplejo(fisicaII).

%3 
trabajador(Persona):- hizoTarea(Persona,_,_).

calificaionTrabajador(Persona, Calificacion):-
    trabajador(Persona),
    calificacionSegun(Persona, Calificacion).

calificacionSegun(Persona, zen):-   %Aca se usa pattern matchin porque no hya tipos diferentes
    forall(hizoTarea(Persona, Tarea,_), not(esEstresante(Tarea))).
    
calificacionSegun(Persona, locos):-
    forall(hizoTarea(Persona, Tarea, fecha(_,_, 2023)), esEstresante(Tarea)).

calificacionSegun(Persona, sabios):-
    realizoTareaEstresante(Persona, Tarea),
    not((realizoTareaEstresante(Persona, OtraTarea), OtraTarea \= Tarea)).

realizoTareaEstresante(Persona, Tarea):-
    hizoTarea(Persona, Tarea,_),
    esEstresante(Tarea).

%4
elMasChapita(Persona):-
    cantidadTareasEstresantes(Persona, CantidadMax),
    forall(cantidadTareasEstresantes(_, OtraCantidad), CantidadMax >= OtraCantidad).

cantidadTareasEstresantes(Persona, Cantidad):-
    trabajador(Persona), %Poner el trabajaddor aca como generador porque luego lo uso en el forall del mas chapita 
    findall(Tarea, realizoTareaEstresante(Persona, Tarea), Tareas), %El findall debe manejar el Tarea por eso no se liga antes
    length(Tareas, Cantidad).
    

