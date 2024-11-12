%postulante(Persona, LoqueEstudia(CArrea, Promedio General, CAntidad de materias aprobadas))
%1
postulante(margarita, estudia(ingenieria,8,20)).
postulante(mario, estudia(arquitectura,7,10)).
postulante(pedro, estudia(psicologia,9,8)).
postulante(ana, estudia(ingenieria,9,15)).
postulante(juan, estudia(abogacia,8,15)).
postulante(julia, estudia(ingenieria,7,25)).

alumno(Alumno):- postulante(Alumno,_).

ocupacion(margarita, amaDeCasa(1)).
ocupacion(mario, trabaja(cadete,30000)).
ocupacion(pedro, estudiante).
ocupacion(ana, trabaja(administrativo,50000)).
ocupacion(juan, trabaja(cadete,35000)).
ocupacion(julia, estudiante).

carreraEstrategica(medicina).
carreraEstrategica(arquitectura).
carreraEstrategica(ingenieria).

%no se agrega la carrerar que no son estrategicas debido a que por principio de unverso cerrado, esos predicados los tomas como falsos

%2
carrera(Carrera):- postulante(_,estudia(Carrera,_,_)).

cumpleCondicionBeca(Alumno):-
    alumno(Alumno),
    verificaCondicion(Alumno).

cumpleCondicionBeca(Alumno):-
    alumno(Alumno),
    cumpleConOcupacion(Alumno).

verificaCondicion(Alumno):-
    postulante(Alumno, estudia(_,Promedio, CantMateriasAp)),
    Promedio >= 8,
    CantMateriasAp >= 10.

cumpleConOcupacion(Alumno):- ocupacion(Alumno, amaDeCasa(_)).
cumpleConOcupacion(Alumno):- ocupacion(Alumno, estudiante).
cumpleConOcupacion(Alumno):- ocupacion(Alumno, trabaja(_, Sueldo)), Sueldo < 60000.


%3
unSoloPostulante(Carrera):-
    postulante(Alumno, estudia(Carrera,_,_)),
    not((postulante(OtroAlumno, estudia(Carrera,_,_)), OtroAlumno\=Alumno)).

%4
carreraConAltaDemanda(Carrera):- 
    cantidadDeAlumnosQueAlcanzanBeca(Carrera, Cantidad),
    forall(cantidadDeAlumnosQueAlcanzanBeca(_, OtraCantidad), OtraCantidad =< Cantidad).
    

cantidadDeAlumnosQueAlcanzanBeca(Carrera, Cantidad):-  %%mUY importante esto , poner el generado aca abajo y no en el princpal , pr que me da false
    carreraEstrategica(Carrera),
    findall(Alumno, (postulante(Alumno, estudia(Carrera,_,_)), cumpleCondicionBeca(Alumno)), Alumnos),
    length(Alumnos, Cantidad).
    
%5
conoce(margarita, juan).    
conoce(juan, pedro).    
conoce(pedro, ana).
conoce(pedro, mario).    
conoce(ana, julia).

postulante(Postulante):- conoce(Postulante,_).

todosTienenBeca(Carrera):-
    carreraEstrategica(Carrera),
    forall(postulante(Alumno, estudia(Carrera)), cumpleCondicionBeca(Alumno)).

conoceAAlguienQueAplique(UnPostulante, OtroPostulante):-
    postulante(UnPostulante), postulante(OtroPostulante),
    not(cumpleCondicionBeca(UnPostualnte)),
    conoce(UnPostualnte, OtroPostulante),
    cumpleCondicionBeca(OtroPostulante).

conoceAAlguienQueAplique(UnPostualnte, OtroPostulante):-
    conocido(UnPostualnte, OtroPostulante),
    cumpleCondicionBeca(OtroPostulante).


conocido(Uno, Otro):- conoce(Uno, Otro).
conocido(Uno, Otro):- conoce(Uno, Tercero), conocido(Tercero, Otro).
