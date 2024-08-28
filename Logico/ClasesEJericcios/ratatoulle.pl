vive(remy, gusteaus).
vive(emile, chezMilleBar).
vive(django, pizzeriaJesuis).

%humanos (nombre, platoqueCocina, experienciaEn cocinar ese plato)

sabeCocinar(linguini, ratatouille,3).
sabeCocinar(linguini, sopa, 5).
sabeCocinar(colette, salmonAsado, 9).
sabeCocinar(horst, ensaladaRusa, 8).


trabaja(linguini, gusteaus).
trabaja(colette, gusteaus).
trabaja(horst, gusteaus).
trabaja(skinner, gusteaus).
trabaja(amelie, moulins).


%1
estaEnElMenu(Plato, Restaurante):-
    sabeCocinar(Chef, Plato,_),
    trabaja(Chef, Restaurante).

%2

conTutor(linguini, Rata):- vive(Rata, Lugar), trabaja(linguini, Lugar).
conTutor(amelie, skinner).

cocinaBien(Chef, Plato):- sabeCocinar(Chef,Plato,Experiencia), Experiencia > 7.
cocinaBien(Chef, Plato):- sabeCocinar(Chef, Plato,_), conTutor(Chef, Tutor), cocinaBien(Tutor, Plato).
cocinaBien(remy,Plato):- sabeCocinar(_,Plato,_).

%3
esChef(Persona, Resto):-
    trabaja(Persona, Resto),
    cumpleCondiciones(Persona, Resto).


cumpleCondiciones(Persona, Resto):- forall(estaEnElMenu(Plato, Resto), cocinaBien(Persona, Plato)).
cumpleCondiciones(Persona, _):- totalExperiencia(Persona, Total), Total > 20.
    
totalExperiencia(Persona,Total):- findall(ExperienciaEnPlato, sabeCocinar(Persona, _, ExperienciaEnPlato), ListaExperienciaEnPlato),
    sumlist(ListaExperienciaEnPlato, Total).


%4

encargadoDe(Cocinero, Plato, Resto):- 
    experienciaEnResto(Cocinero, Plato, Resto, Experiencia),
    forall(experienciaEnResto(_,Plato,Resto, OtraExperiencia), OtraExperiencia =< Experiencia).  %MAximo segun una experiencia, siempre usar forall

experienciaEnResto(Cocinero, Plato, Resto, Experiencia):- trabaja(Cocinero, Resto), sabeCocinar(Cocinero, Plato, Experiencia).


    
plato(ensaladaRusa, entrada([papa, zanahoria, arvejas, huevo, mayonesa])).
plato(bifeDeChorizo, principal(pure,20)).
plato(frutillasConCrema, postre(30)).

%5
%Ponemos que es NOmbreDelPlato, yaque si ponemos solo plato, le estamos pasando todos los argumetnos del predicado plato de arriba
esSaludable(NombreDelPlato):- plato(NombreDelPlato, TipoPlato), calorias(TipoPlato, CantCalorias), CantCalorias < 75.

% aca en calorias se usa attern matchin  Este calorias es un predicado polimorfico. calorias no es totalmente invrsible ya que ya viene ligado de antes
calorias(entrada(Ingredientes), TotalCalorias):- length(Ingredientes, Cantidad), TotalCalorias is Cantidad * 15.
calorias(principal(Guarnicion, Minutos), TotalCalorias):- caloriasGuarnicion(Guarnicion, Calorias), TotalCalorias is Calorias + (5*Minutos).
calorias(postre(Calorias), Calorias).

caloriasGuarnicion(papasFritas, 50).
caloriasGuarnicion(pure, 20).
caloriasGuarnicion(ensalada, 0). 

%Polimorfismo, cuando uso un fucntor, y este esta como priemr argumento, y son distintos, lo interesante es que por cada argumentos realiza un tratamiento diferentes
%

%6
restaurante(Resto):- trabaja(_,Resto).

escribeResenaPositiva(Critico, Resto):- restaurante(Resto), not(vive(_, Resto)), criterioCritico(Critico, Resto).

criterioCritico(antonEgo, Restaurante):- esEspecialista(Restaurante, ratatouille).
criterioCritico(cormillot, Restaurante):- forall(estaEnElMenu(Plato, Restaurante), esSaludable(Plato)).
criterioCritico(martiniano, Restaurante):- esChef(Cocinero, Restaurante), not((esChef(OtroCocinero, Restaurante), Cocinero\= OtroCocinero)). %ESto uso cuano no hay ninung otro, osea que sea unico



esEspecialista(Resto, Comida):- forall(esChef(Cocinero, Resto), cocinaBien(Cocinero, Comida)).
