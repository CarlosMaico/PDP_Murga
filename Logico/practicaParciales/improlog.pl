%integrante(Grupo, Persona, InstrumentoQuetocaLaPersona)
integrante(sophieTrio, sophie, violin).
integrante(sophieTrio, santi, guitarra).
integrante(vientosDelEste, lisa, saxo).
integrante(vientosDelEste, santi, voz).
integrante(vientosDelEste, santi, guitarra).
integrante(jazzmin, santi, bateria).

grupo(Grupo):- integrante(Grupo,_,_).

%novelQueTiene(Persona, InstrumentoQueToca, QueTanBIenLoTOca)
nivelQueTiene(sophie, violin, 5).
nivelQueTiene(santi, guitarra, 2).
nivelQueTiene(santi, voz, 3).
nivelQueTiene(santi, bateria, 4).
nivelQueTiene(lisa, saxo, 4).
nivelQueTiene(lore, violin, 4).
nivelQueTiene(luis, trompeta, 1).
nivelQueTiene(luis, contrabajo, 4).

%instrumento(NombreIsntrumento, RolDelInstrumento)
instrumento(violin, melodico(cuerdas)).
instrumento(guitarra, armonico).
instrumento(bateria, ritmico).
instrumento(saxo, melodico(viento)).
instrumento(trompeta, melodico(viento)).
instrumento(contrabajo, armonico).
instrumento(bajo, armonico).
instrumento(piano, armonico).
instrumento(pandereta, ritmico).
instrumento(voz, melodico(vocal)).

%1

tieneBuenaBase(Grupo):-
    alguienTocaInstruemntoRitmico(Grupo),
    alguienTocaInstruemntoArmonico(Grupo).

alguienTocaInstruemntoRitmico(Grupo):-
    integrante(Grupo, _, Instrumento),
    instrumento(Instrumento, ritmico).

alguienTocaInstruemntoArmonico(Grupo):-
    integrante(Grupo, _, Instrumento),
    instrumento(Instrumento, armonico).

%2

seDestaca(Persona, Grupo):-
    nivelDeIntegrante(Grupo, Persona, Nivel),
    forall((nivelDeIntegrante(Grupo, OtraPersona, OtroNivel), OtraPersona\=Persona), Nivel >= OtroNivel + 2).

nivelDeIntegrante(Grupo, Persona, Nivel):-
    integrante(Grupo, Persona, Instrumento),
    nivelQueTiene(Persona, Instrumento, Nivel).
    
%3
%grupo(Grupo, TipoDeGrupo)
grupo(vientosDelEste, bigBand).
grupo(sophieTrio, formacion([contrabajo, guitarra, violin])).
grupo(jazzmin, formacion([bateria, bajo, trompeta, piano, guitarra])).

%8
grupo(estudio1, ensamble(3)).


%4

hayCupo(Instrumento, Grupo):- 
    grupo(Grupo, bigBand),
    esDeViento(Instrumento). 

hayCupo(Instrumento, Grupo):-
    grupo(Grupo, TipoDeGrupo),
    instrumento(Instrumento,_),
    not(integrante(Grupo,_,Instrumento)),
    sirveInstrumento(TipoDeGrupo, Instrumento).

esDeViento(Instrumento):-   
    instrumento(Instrumento, melodico(viento)).

sirveInstrumento(formacion(InstrumentosBiuscados), Instrumento):- member(Instrumento, InstrumentosBiuscados).
sirveInstrumento(bigBand, Instrumento):- esDeViento(Instrumento).
sirveInstrumento(bigBand, bateria).
sirveInstrumento(bigBand, bajo).
sirveInstrumento(bigBand, piano).
%8
sirveInstrumento(ensamble(_),_).

%5
puedeIncorporarse(Persona, Grupo, Instrumento):-  %No es inversible pero moviendo los predicados se hace inversible
    not(integrante(Grupo, Persona, _)),
    hayCupo(Instrumento, Grupo),
    nivelQueTiene(Persona, Instrumento, Nivel),
    nivelEsperadoDeGrupo(Grupo, NivelEsperado),
    Nivel >= NivelEsperado.

nivelEsperadoDeGrupo(Grupo, NivelEsperado):-
    grupo(Grupo, TipoDeGrupo),
    nivelMinimo(TipoDeGrupo, NivelEsperado).

nivelMinimo(bigBand, 1).
nivelMinimo(formacion(InstrumentosBuscados), NivelEsperado):- length(InstrumentosBuscados, Cantidad), NivelEsperado is 7- Cantidad.
%8
nivelMinimo(ensamble(NivelEsperado), NivelEsperado).

%6
seQuedoEnBanda(Persona):-
    nivelQueTiene(Persona, _,_),
    not(integrante(_, Persona,_)),
    not(puedeIncorporarse(Persona, _, _)).

%7
puedeTocar(Grupo):-
    integrante(Grupo,_,_),
    cumplenNecesidades(Grupo).

cumplenNecesidades(Grupo):-
    grupo(Grupo, bigBand),
    tieneBuenaBase(Grupo),
    findall(PersonaViento, (integrante(Grupo, PersonaViento, Instrumento), esDeViento(Instrumento)), PersonasDeViento),
    length(PersonasDeViento, Cantidad), 
    Cantidad >= 5.
    
cumplenNecesidades(Grupo):-
    grupo(Grupo, formacion(InstrumentosRequeridos)),
    forall(member(Instrumento, InstrumentosRequeridos), integrante(Grupo, _, Instrumento)).

%8

cumplenNecesidades(Grupo):-
    grupo(Grupo, ensamble(_)),
    tieneBuenaBase(Grupo),
    integrante(Grupo, _ , melodico(_)).
    