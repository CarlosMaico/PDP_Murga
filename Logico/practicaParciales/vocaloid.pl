
%canta(Persona, cancion(Nombrecancion, Duracion))

canta(megurineLuka, cancion(nightFever, 4)).
canta(megurineLuka, cancion(foreverYoung, 5)).
canta(hatsuneMiko, cancion(tellYourWorld, 4)).
canta(gumi, cancion(foreverYoung, 4)).
canta(gumi, cancion(tellYourWorld, 5)).
canta(seeU, cancion(novemberRain, 6)).
canta(seeU, cancion(nightFever, 5)).

%a)1)
esNovedoso(Vocaloid):-
    sabeAlmenosDosCanciones(Vocaloid),
    tiempoTotalDeCanciones(Vocaloid, Tiempo),
    Tiempo < 15.

sabeAlmenosDosCanciones(Vocaloid):-
    canta(Vocaloid, Cancion),
    canta(Vocaloid, OtraCancion),
    Cancion\=OtraCancion.

tiempoTotalDeCanciones(Vocaloid, Tiempo):-
    findall(Duracion, tiempoDeCadaCancion(Vocaloid, Duracion), Duraciones),
    sumlist(Duraciones, Tiempo).

tiempoDeCadaCancion(Vocaloid, TiempoCancion):- 
    canta(Vocaloid, Cancion),
    tiempo(Cancion, TiempoCancion).

tiempo(cancion(_,Tiempo), Tiempo).

%2
vocaloid(Vocaloid):- canta(Vocaloid,_).

esAcelerado(Vocaloid):-
    vocaloid(Vocaloid),
    not((tiempoDeCadaCancion(Vocaloid, TiempoCancion), TiempoCancion > 4)). %No usa forall de debido a que tiempoDeCAdaCancion me tir el unvierso completo de canciones
    
%Conciertos

%1
%concierto(Nombre, Pais, CantFama, TipoConcierto)
%gigante(cantMinimadeCAncionesQueDEbeSaberElCantante, DuracionDeTodasLasCanciones)
%mediano(duracionTotalDECanciones)
%diminuti(duracion de una cancion)
concierto(mikuExpo, eeuu, 2000, gigante(2,6)).
concierto(magicalMirai, japon, 3000 , gigante(3, 10)).
concierto(vocalektVisions, eeuu, 1000, mediano(9)).
concierto(mikuFest, argentina, 100, diminuto(4)).

%2

puedeParticipar(hatsuneMiko, Concierto):- concierto(Concierto,_,_,_).

puedeParticipar(Vocaloid, Concierto):-
    vocaloid(Vocaloid),
    Vocaloid \= hatsuneMiko,
    concierto(Concierto,_,_,Requisitos),
    cumpleRequisitos(Vocaloid, Requisitos).

cumpleRequisitos(Vocaloid, gigante(CantCanciones, TiempoMinimo)):-
    cantidadCanciones(Vocaloid, Cantidad),
    Cantidad >= CantCanciones,
    tiempoTotalDeCanciones(Vocaloid, Tiempo),
    Tiempo > TiempoMinimo.

cumpleRequisitos(Vocaloid, mediano(TiempoMax)):-
    tiempoTotalDeCanciones(Vocaloid, Tiempo),
    Tiempo < TiempoMax.

cumpleRequisitos(Vocaloid, diminuto(TiempoMinimo)):-
    canta(Vocaloid, Cancion),
    tiempo(Cancion, Tiempo),
    Tiempo > TiempoMinimo.

cantidadCanciones(Vocaloid, Cantidad):-
    findall(Cancion, canta(Vocaloid, Cancion), Canciones),
    length(Canciones, Cantidad).

%3

masFamoso(Vocaloid):-
    nivelFamaVocaloid(Vocaloid, Nivel),
    forall(nivelFamaVocaloid(_, OtroNivel), OtroNivel =< Nivel).

nivelFamaVocaloid(Vocaloid, Nivel):-
    famaTotal(Vocaloid, CantFamaTotal),
    cantidadCanciones(Vocaloid, Cantidad),
    Nivel is CantFamaTotal* Cantidad.
    
famaTotal(Vocaloid, CantFama):-
    vocaloid(Vocaloid),
    findall(Fama, famaDeConcierto(Vocaloid, Fama), Famas),
    sumlist(Famas, CantFama).

famaDeConcierto(Vocaloid, Fama):-
    puedeParticipar(Vocaloid, Concierto),
    fama(Concierto,Fama).

fama(Concierto, Fama):- concierto(Concierto,_, Fama,_).

%4
conoce(megurineLuka, hatsuneMiko).
conoce(megurineLuka, gumi).
conoce(gumi, seeU).
conoce(seeU, kaito).

conocido(UnVocaloid, OtroVocaloid):- conoce(UnVocaloid, OtroVocaloid).
conocido(UnVocaloid, OtroVocaloid):- conoce(UnVocaloid, TercerVocaloid), conocido(TercerVocaloid, OtroVocaloid).

esElUnicoQueParticipa(Vocaloid, Concierto):-
    puedeParticipar(Vocaloid, Concierto),
    not(( conocido(Vocaloid, OtroVocaloid),puedeParticipar(OtroVocaloid, Concierto))).

%5   
%Si se agrewga una nuevo tipo de conierto priemro debemos agregarlo en la base de conociemintos y luego en aquello lugar donde se uso directamente el functor tipo de conrierto
%en este caso seria en el cumpleRequisitos, 
%El polimorfismo es quien facilita dicha implemetnacion ya que ahi se da trtamientos distintos segun ela rguemtnoq ue se le pase