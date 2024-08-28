%receta(Receta, Ingredientes)
receta(Nombre, Ingredientes).

ingrediente(Ingrediente).

calorias(Ingrediente, Calorias).

trivial(Receta):-
    receta(Receta, [_]).


%elPeor(Ingredientes, Peor) Implementacion caso recursivo
elPeor2([Peor], Peor).  %
elPeor2([Ingrediente| Otros], Ingrediente):-
    elPeor2(Otros, OtroIngrediente),
    calorias(OtroIngrediente, CaloriasOtroIngrediente),
    calorias(Ingrediente, CaloriasIngrediente),
    CaloriasIngrediente >= CaloriasOtroIngrediente.
elPeor2([Ingrediente | Otros], OtroIngrediente):-
    elPeor2(Otros, OtroIngrediente),
    calorias(OtroIngrediente, CaloriasOtroIngrediente),
    calorias(Ingrediente, CaloriasIngrediente),
    CaloriasIngrediente < CaloriasOtroIngrediente.


elPeor(Ingredientes, Peor):-  %Implementacion par la gente   (Poruqe no pone Peor\=Ingrediente)
    member(Peor, Ingredientes),
    calorias(Peor, CaloriasPeor),
    forall(member(Ingrediente, Ingredientes), (calorias(Ingrediente, Calorias), CaloriasPeor >=Calorias)).
    
% memebr me relacion elemtnos individuales con ubna lista, y el findall me sirve para a aprtir de respuestas indivifdaules armar u conjunto, osea si tengo un findall y en la consulta uso un memebre, pero luego no le hago otra consulta es al pedo el member    
caloriasTotales(Receta, Total):-
    receta(Receta, Ingredientes),
    findall(Caloria, (member(Ingrediente, Ingredientes), calorias(Ingrediente, Caloria)), Calorias),  
    sum_list(Calorias, Total).

versionLight(Receta, IngredientesLight):-
    receta(Receta, Ingredientes),
    elPeor(Ingredientes, Peor),
    findall(Ingrediente,(member(Ingrediente, Ingredientes), Ingrediente\=Peor), IngredientesLight).

guasada(Receta):-
    receta(Receta, Ingredientes),
    member(IngredienteEngordador, Ingredientes),
    calorias(IngredienteEngordador, Calorias),
    Calorias > 1000.