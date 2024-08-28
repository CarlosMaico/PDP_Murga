%vende(Articulo, Precio).

vende(libro(elResplandor, stephenKing, terror, debolsillo), 2300).
vende(libro(mort, terryPratchett, aventura, plazaJanes),    1300).
vende(libro(harryPotter3, jkRowling, ficcion, salamandra),  2500).
vende(cd(differentClass, pulp, pop, 2, 24),                 1450).
vende(cd(bloodOnTheTracks, bobDylan, folk, 1, 12),          2500).
vende(pelicula(dragonBAlz, akira, accion),                  1200).

%autor(Articulo, Autor).

autor(libro(_,Autor,_,_), Autor):-
    vende(libro(_,Autor,_,_),_).
autor(cd(_,Autor,_,_,_), Autor):-
    vende(cd(_,Autor,_,_,_),_).
%No definicomos un autor como pelciula debuido a que una peli tiene un direector y no es un autor

titulo(libro(Titulo,_,_,_), Titulo):-
    vende(libro(Titulo,_,_,_), _).
titulo(cd(Titulo,_,_,_,_), Titulo):-
    vende(cd(Titulo,_,_,_,_), _).
titulo(pelicula(Titulo,_,_), Titulo):-
    vende(pelicula(Titulo,_,_), _).


libroMasCaro(libro(Titulo, Auto, Genero, Editorial)):-  %Como libro es un fucntor pasar el funcotr porq ue me pide el libro de mayor precio espcfiica libro
    vende(libro(Titulo, Auto, Genero, Editorial) ,PrecioMax),
    forall((vende(libro(_,_,_,_), OtroPrecio)), OtroPrecio =< PrecioMax).

curiosidad(Articulo):-  %esPredicado polimorifoc por que sabe trabajar con diferentes articulos
    vende(Articulo,_),
    autor(Articulo, Autor),  %autor no es inversible para el primer argumento
    not((vende(OtroArticulo,_), autor(OtroArticulo, Autor), Articulo\=OtroArticulo)).

sePrestaAConfusion(Titulo):-  %ES Predicado polimorfico
    titulo(Articulo, Titulo),
    titulo(OtroArticulo, Titulo),
    Articulo\= OtroArticulo.

mixto(Autor):-  %ACa no uso el modo polimorfico pero se podria usar Articulo nomas (No entendi no creo el predicado autor para peli pero aca lo usa)
    autor(libro(_,_,_,_), Autor), autor(cd(_,_,_,_,_), Autor).
mixto(Autor):-
    autor(libro(_,_,_,_), Autor), autor(pelciula(_,_,_), Autor).
mixto(Autor):-
    autor(cd(_,_,_,_,_), Autor), autor(pelciula(_,_,_), Autor).