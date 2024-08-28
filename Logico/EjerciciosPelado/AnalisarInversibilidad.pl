edad(christian, 25).

amigo(nico, fernando).  %Amigo es inversibel para su primer arguemtno, pero para el segundo arguemtno con alf, no es inversible ya que alf es amigo de todos, pero no conocemos a todos ya que es infinot todos
amigo(axel, Persona):- amigo(Persona, nico).
amigo(alf,_).

id(X, X). %este es inversible para cada argumento por separado, pero cuando madnamos 2 variables como arguemtnos ahi no es inversible, es medio raro

mayorDeEdad(Persona):-  %Aca no es inversible debido a que EDAD esta antes de ligar la edad estaria mal
    Edad > 18,
    edad(Persona, Edad).

%padre(PAdre, Hijo)

padre(abraham, homero).
padre(homero, bart).

abuelo(fry, fry). %fry es su propio abuelo

abuelo(Abuelo, Nieto):- 
    padre(Abuelo, Padre),
    padre(Padre, Nieto).


hermano(Uno, Otro):- 
    padre(Padre, Uno),
    padre(Padre, Otro),
    Uno\=Otro.

%ancestro(Ancestro, Descendiente)

ancestro(Ancestro, Descendiente):- padre(Ancestro, Descendiente).
ancestro(Ancestro, Descendiente):- padre(Ancestro, Tercero), padre(Tercero, Descendiente).
