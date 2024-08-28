
%quedaEn(Lugar, Lugar)
quedaEn(venezuela, america).
quedaEn(argentina, america).
quedaEn(patagonia, argentina).
quedaEn(aula522, utn).
quedaEn(utn, buenosAires).
quedaEn(buenosAires, argentina).

nacioEn(dani, buenosAires).
nacioEn(alf, buenosAires).
nacioEn(nico, buenosAires).

haceTarea(dani, tomarExamen(paradigmaLogico, aula522), fecha(10,8,2023), aula522).
haceTarea(dani, hacerGol(primeraDivision), fecha(10,8,2023), buenosAires).
haceTarea(alf, hacerDiscurso(utn, 0), fecha(11,8,2023), utn).

%1
dulceHogar(Persona):-
    nacioEn(Persona, Lugar),
    forall(haceTarea(Persona, _,_, OtroLugar), 
    mismoLugar(Lugar, OtroLugar)).

mismoLugar(Lugar, Lugar).

%2
esEstresante(Tarea):- 
    haceTarea(_, Tarea,_, Lugar), 
    pertenece(Lugar, argentina), 
    cumpleCondicionesEstresantes(Tarea).

pertenece(Lugar, OtroLugar):- quedaEn(Lugar, OtroLugar).
pertenece(Lugar, OtroLugar):- quedaEn(Lugar, Lugar2), pertenece(Lugar2, OtroLugar).

cumpleCondicionesEstresantes(hacerDiscurso(_, Cantidad)):- Cantidad > 3000.  %Aca se uso polimorsifms
cumpleCondicionesEstresantes(tomarExamen(Tema,_)):- esComplejo(Tema).
cumpleCondicionesEstresantes(hacerGol(_)).

esComplejo(paradigmaLogico).
esComplejo(analisisMatematico).

%3 

clasificarSegun(Persona, zen):- 
    forall(haceTarea(Persona, Tarea, _, _), 
    not(esEstresante(Tarea))).

clasificarSegun(Persona, loco):- 
    forall(haceTarea(Persona, Tarea, fecha(_,_,2023),_), 
    esEstresante(Tarea)).

clasificarSegun(Persona, sabio):- 
    realizarTareaEstresante(Persona, Tarea), 
    not((realizarTareaEstresante(Persona, OtraTarea), OtraTarea\=Tarea)). %para ver si hizo una unica cosa

realizarTareaEstresante(Persona, Tarea):- 
    haceTarea(Persona, Tarea,_,_), 
    esEstresante(Tarea).

%4

masChapita(Persona):- 
    cantidadTareaEstresante(Persona, Cantidad),
    forall(cantidadTareaEstresante(_, OtraCantidad), Cantidad > OtraCantidad).

cantidadTareaEstresante(Persona, Cantidad):- 
    persona(Persona),
    findall(Tarea, realizarTareaEstresante(Persona, Tarea), Lista), length(Lista, Cantidad).
    
persona(Persona):-haceTarea(Persona,_,_,_).