%cocina(Nombre, Comida, Puntos)
cocina(mariano, principal(noquis,50), 80).
cocina(julia, principal(pizza, 100), 80).
cocina(hernan, postre(panqueque, dulceDeLeche, 100), 60).
cocina(hernan, postre(turfas, dulceDeLeche, 60), 80).
cocina(hernan, entrada(ensalada, [tomate, zanahoria, lechuga], 70), 29).
cocina(susana, entrada(empanada, [carne, cebolla, papa], 50),50).
cocina(susana, entrada(fritas, [carne, cebolla, papa], 49),50).
cocina(susana, postre(pastelito, dulceDeMembrillo, 50), 60).
cocina(melina, postre(torta, zanahoria, 60), 50).
cocina(maico, entrada(parrilla,[carne], 80), 90).



esAmigo(mariano, susana).
esAmigo(mariano, hernan).
esAmigo(melina, carlos).
esAmigo(carlos, susana).

esPopular(carne).
esPopular(dulceDeLeche).
esPopular(dulceDeMembrillo).

esSaludable(Comida):-
    cocina(_, Comida,_),
    esSana(Comida).

esSana(postre(_,_ , Caloraias)):- Caloraias < 100.
esSana(entrada(_,_,Caloraias)):- Caloraias < 60.
esSana(principal(_,Caloraias)):- between(70, 90, Caloraias).

cocinero(Cocinero):- cocina(Cocinero,_,_).

soloSalado(Cocinero):-
    cocinero(Cocinero),
    forall(cocina(Cocinero, Plato, _), not(esPostre(Plato))).

esPostre(postre(_,_,_)).

tieneUnagranFama(Cocinero):-
    puntuacionDePlatos(Cocinero, PuntosTotales),
    forall(puntuacionDePlatos(_, OtroPuntosTotales), OtroPuntosTotales =< PuntosTotales).

puntuacionDePlatos(Cocinero, PuntosTotales):-
    cocinero(Cocinero),
    findall(Puntos, cocina(Cocinero,_, Puntos), ListaPuntos),
    sum_list(ListaPuntos, PuntosTotales).
    
noEsSaludable(Cocinero):-
    poseePlatoSaludable(Cocinero, Plato),
    not((poseePlatoSaludable(Cocinero, OtroPlato), OtroPlato \= Plato)).

poseePlatoSaludable(Cocinero, Plato):-
    cocina(Cocinero, Plato,_),
    esSaludable(Plato).

noUsaIngredientesPopulares(Cocinero):-
    cocinero(Cocinero),
    forall(cocina(Cocinero, Plato,_), not(usaIngredientesPopulares(Plato))).

usaIngredientesPopulares(entrada(_, ListaIngredientes,_)):- esPopular(Ingrediente),member(Ingrediente, ListaIngredientes).
usaIngredientesPopulares(postre(_,Sabor,_)):- esPopular(Sabor).    


cantidadDeUsoDeIngredientePopular(Cocinero, IngredientePopular):-
    cocinero(Cocinero),
    lsitaDeIngredientesPopularesQueUsa(Cocinero, IngredientesPopulares),
    max_member(IngredientePopular, IngredientesPopulares).

lsitaDeIngredientesPopularesQueUsa(Cocinero, IngredientesPopulares):-
     findall(Ingrediente,(cocina(Cocinero, Plato,_), tieneIngredientePopular(Plato, Ingrediente)), IngredientesPopulares).

tieneIngredientePopular(entrada(_,ListaIng,_), Ingrediente):- member(Ingrediente, ListaIng), esPopular(Ingrediente).

esRecomendadoPorColega(UnCocinero, OtroCocinero):-
    not(noEsSaludable(UnCocinero)),
    esColega(UnCocinero, OtroCocinero).

esColega(UnCocinero, OtroCocinero):- esAmigo(UnCocinero, OtroCocinero).
esColega(UnCocinero, OtroCocinero):- esAmigo(UnCocinero, Tercero), esColega(Tercero, OtroCocinero).