
guardia(Nombre).
prisionero(Nombre, Crimen).

%1
controla(piper, alex).
controla(bennett, dayanara).
controla(Guardia, Otro):- prisionero(Otro,_), guardia(Nombre), not(controla(Otro, Guardia)).

%2
conflictoDeIntereses(Uno, Otro):- 
    controla(Uno, Tercero),
    controla(Otro, Tercero),
    not(controla(Uno, Otro)),  %EL paradigma es declarativo, prolog al bajarlo a tierra no es necesariamente tan declarativo, y estoy haciendo que se ligen las variables para hacer la consulta quenecesito
    not(controla(Otro, Uno)),
    Uno\=Otro.

%3
peligroso(Prisionero):-
    prisionero(Prisionero, _ ),
    forall(prisionero(Prisionero,Crimen), grave(Crimen)). %Para un prisionero en particular se genere todo el conjtuntode sus crimenes y a ese conjunto chequea si es grave

grave(homicidio(_)).
grave(narcotrafico(Drogas)):- member(metanfetaminas, Drogas).
grave(narcotrafico(Drogas)):- length(Drogas, Cantidad), Cantidad >=5.


%4
ladronDeGuanteBlanco(Prisionero):-
    prisionero(Prisionero, _ ),
    forall(prisionero(Prisionero, Crimen), (monto(Crimen, Monto), Monto>100000)).

monto(robo(Monto), Monto).
    
%5 
condena(Prisionero, Condena):-
    prisionero(Prisionero, _ ),
    findall(Pena, (prisionero(Prisionero, Crimen), pena(Crimen, Pena)), Penas),
    sum_list(Penas, Condena).
    
pena(robo(Monto), Pena):- Pena is Monto / 10000.
pena(homicidio(Persona), 9):- guardia(Persona).
pena(homicidio(Persona), 7):- not(guardia(Persona)).
pena(narcotrafico(Drogas), Pena):- length(Drogas, Cantidad), Pena is Cantidad*2.

%6

capo(Capo):- 
    prisionero(Capo,_),
    not(controla(_, Capo)),
    forall((persona(Persona), Capo \= Persona), controlaDirectaOIndirectamente(Capo, Persona)).
    
persona(Persona):- prisionero(Persona,_).
persona(Persona):- guardia(Persona).

controlaDirectaOIndirectamente(Uno, Otro):-controla(Uno, Otro).  %Directo
controlaDirectaOIndirectamente(Uno, Otro):-controla(Uno, Tercero), controlaDirectaOIndirectamente(Tercero, Otro).  %Indirecto Da tantos niveles de transitivdad
