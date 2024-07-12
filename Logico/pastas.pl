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


