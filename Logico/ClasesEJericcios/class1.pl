%%Busqueda laboral
contador(roque).
joven(roque).
trabajoEn(julia,acme).
trabajoEn(roque,acme).
trabajoEn(ana,omni).
trabajoEn(lucia,omni).
trabajoEn(pepe,fiat).
honesto(roque).
ingeniero(ana).
ingeniero(pepe).
habla(roque, frances).
habla(ana, ingles).
habla(ana, frances).
habla(lucia, ingles).
habla(lucia, frances).
habla(cecilia, frances).
abogado(cecilia).
ambicioso(cecilia).
ambicioso(julia).
ambicioso(Alguien):- joven(Alguien), contador(Alguien).

tieneExperiencia(Alguien):- trabajoEn(Alguien,_).

profesional(Persona):- contador(Persona).
profesional(Persona):- abogado(Persona).
profesional(Persona):- ingeniero(Persona).

puedeAndar(comercioExterior,Persona):- ambicioso(Persona).
puedeAndar(contaduria, Persona):- contador(Persona), honesto(Persona).
puedeAndar(ventas, Persona):- ambicioso(Persona), tieneExperiencia(Persona).
puedeAndar(ventas, lucia).
puedeAndar(proyectos, Persona):-ingeniero(Persona), tieneExperiencia(Persona).
puedeAndar(proyectos, Persona):- abogado(Persona), joven(Persona).
puedeAndar(logistica, Persona):- profesional(Persona), cumpleCondiciones(Persona).

cumpleCondiciones(Persona):- joven(Persona).
cumpleCondiciones(Persona):- trabajoEn(Persona,omni).

%relaciones Familiares

madre(mona, homero).
madre(jaqueline, marge).
madre(marge, maggie).
madre(marge, bart).
madre(marge, lisa).
padre(abraham, herbert).
padre(abraham, homero).
padre(clancy, jaqueline).
padre(homero, maggie).
padre(homero, bart).
padre(homero, lisa).

hermano(Persona, OtraPersona):- mismaMadre(Persona, OtraPersona), mismoPadre(Persona, OtraPersona).

mismaMadre(Persona, OtraPersona):- madre(Madre, Persona), madre(Madre, OtraPersona), Persona\=OtraPersona.
mismoPadre(Persona, OtraPersona):- padre(Padre, Persona), padre(Padre, OtraPersona), Persona\=OtraPersona.

medioHermano(Persona, OtraPersona):-mismaMadre(Persona, OtraPersona), not(mismoPadre(Persona, OtraPersona)).
medioHermano(Persona, OtraPersona):-mismoPadre(Persona, OtraPersona), not(mismaMadre(Persona, OtraPersona)).

hijoUnico(Alguien):- hijo(Alguien,_),not(hermano(Alguien,_)).
hijo(Alguien,Progenitor):- madre(Progenitor, Alguien).
hijo(Alguien,Progenitor):- padre(Progenitor, Alguien).

tio(Sobrino, Tio):-padre(Padre,Sobrino), hermano(Padre,Tio).
tio(Sobrino, Tia):-madre(Madre,Sobrino), hermano(Madre,Tia).

%medios de Transporte
transporte(juan, camina).
transporte(marcela, subte(a)).
transporte(pepe, colectivo(160,d)).
transporte(elena, colectivo(76)).
transporte(maria, auto(fiesta, ford, 2020)).
transporte(ana, auto(fiesta,ford, 2020)).
transporte(roberto, auto(qubo, fiat, 2015)).
transporte(maico, camina).
manejaLento(manuel).
manejaLento(ana).

tardaMucho(Persona):-transporte(Persona,camina).
tardaMucho(Persona):-transporte(Persona,auto(_,_,_)), manejaLento(Persona).

%1)
%transporte(Persona, auto(_,_,_)).
%Persona = maria ;
%Persona = roberto.

viajaEnColectivo(Persona):- transporte(Persona,colectivo(_)).
viajaEnColectivo(Persona):- transporte(Persona,colectivo(_,_)).