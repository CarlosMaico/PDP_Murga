%destreza(alumno, velocidad, [habilidades]).
destreza(sofia, 80, [golpeRecto(40, 3),codazo(20)]).
destreza(sara, 70, [patadaRecta(80, 2), patadaDeGiro(90, 95, 2),golpeRecto(1, 90)]).
destreza(bobby, 80, [patadaVoladora(100, 3, 2, 90),patadaDeGiro(50, 20, 1)]).
destreza(guidan, 70, [patadaRecta(60, 1), patadaVoladora(100, 3, 2,90),patadaDeGiro( 70, 80 1)]).

%categoria(Alumno, Cinturones)
categoria(sofia, [blanco]).
categoria(sara, [blanco, amarillo, naranja, rojo, verde, azul,violeta, marron, negro]).
categoria(bobby, [blanco, amarillo, naranja, rojo, verde, azul,violeta,marron, negro]).
categoria(guidan, [blanco, amarillo, naranja]).

%1
esBueno(Alumno):-
    destreza(Alumno,_, Habilidades),
    cumpleCondicion(Habilidades).

cumpleCondicion(Habilidades):-
    member(esPatada(Patada),Habilidades),
    member(esPatada(OtraPatada),Habilidades),
    Patada \=OtraPatada.

cumpleCondicion(Habilidades):-
    member(golpeRecto(_,Potencia), Habilidades),
    between(50, 80, Potencia).
    

esPatada(patadaRecta(_,_)).
esPatada(patadaDeGiro(_,_,_)).
esPatada(patadaVoladora(_,_,_,_)).

%2
esAptoParaToreno(Alumno):-
    esBueno(Alumno),
    poseeCategoriaVerde(Alumno).

poseeCategoriaVerde(Alumno):-
    categoria(Alumno, Cinturones),
    member(verde, Cinturones).

%3
/*patadaRecta(potencia, distancia), patadaDeGiro(potencia, punteria, distancia),
patadaVoladora(potencia, distancia, altura, punteria), codazo(potencia),
golpeRecto(distancia, potencia).*/

alumno(Alumno):- destreza(Alumno,_,_).

totalPotencia(Alumno, PotenciaTotal):-
    destreza(Alumno,_, Habilidades ),
    findall(Potencia, (member(Habilidad, Habilidades), calculoPotencia(Habilidad, Potencia)) ,Potencias).
    sumlist(Potencias, PotenciaTotal).

calculoPotencia(patadaRecta(Potencia,_), Potencia ).
calculoPotencia(patadaDeGiro(Potencia,_,_), Potencia ).
calculoPotencia(patadaVoladora(Potencia,_,_,_), Potencia ).
calculoPotencia(codazo(Potencia), Potencia ).
calculoPotencia(golpeRecto(_,Potencia), Potencia).

%4
algunoConMayorPotencia(Alumno):-
    totalPotencia(Alumno, PotenciaMax),
    forall(totalPotencia(_, OtraPotencia), OtraPotencia =< PotenciaMax).

%5
sinPatada(Alumno):-
    destreza(Alumno,_, Habilidad),
    forall(member(Habilidad, Habilidades), not(esPatada(Habilidad))).

%6
soloSabePatear(Alumno):-
    not(sinPatada(Alumno)).

%7
potencialesSemifinalistas(ListaDeAlumnos):-
    forall(member(Alumno, ListaDeAlumnos), cumpleCondicionParaTorneo(Alumno)).

cumpleCondicionParaTorneo(Alumno):- esAptoParaToreno(Alumno).
cumpleCondicionParaTorneo(Alumno):- maestroFamoso(Alumno).
cumpleCondicionParaTorneo(Alumno):- realizaHabilidadArtistica(Alumno).


alumnoDe(miyagui, sara).
alumnoDe(miyagui, bobby).
alumnoDe(miyagui, sofia).
alumnoDe(chunLi, guidan).

maestroFamoso(Alumno):- 
    alumnoDe(Maestro, Alumno),
    alumnoDe(Maestro, OtroAlumno),
    Alumno \= OtroAlumno.

realizaHabilidadArtistica(Alumno):-
    destreza(Alumno, _, Habilidades),
    member(Habilidad, Habilidades),
    esArtistica(Habilidad).

esArtistica(Habilidad):-
    calculoPotencia(Habilidad, Potencia), Potencia > 100
esArtistica(Habilidad)



    
    

