habitat(Animal, Bioma).

animal(Animal).

come(Comedor, Comido).

hostil(Animal, Bioma):-  %Si uso el predicado habitat(Animal, Bioma) como generador obligo a que el animal viva en el Bioma
    animal(Animal),
    habitat(_, Bioma),
    forall(habitat(OtroAnimal, Bioma), come(OtroAnimal, Animal)).

terrible(Animal, Bioma):-
    animal(Animal),
    habitat(_, Bioma),
    forall(come(OtroAnimal, Animal), habitat(OtroAnimal, Bioma)).
    
compatibles(Animal, OtroAnimal):-
    animal(Animal),
    animal(OtroAnimal),
    not(come(Animal, OtroAnimal)),  %no es lo mismo poner todo dentro de un not, alcanza con que uno de los dos animales no se coman para que sean compatbiles
    not(come(OtroAnimal, Animal)),
    Animal\= OtroAnimal.

adaptable(Animal):-
    animal(Animal),
    forall(habitat(_, Bioma), habitat(Animal, Bioma)).  %habitat(_, Bioma) genra el universo de biomas
    
raro(Animal):-
    habitat(Animal, Bioma),
    not((habitat(Animal, OtroBioma), Bioma\=OtroBioma)). %No Hay otroBioma distinto al Bioma en el que el animal Habite


dominante(Animal):-
    habitat(Animal, Bioma),
    forall((habitat(OtroAnimal, Bioma), OtroAnimal\=Animal), come(Animal, OtroAnimal)).
    