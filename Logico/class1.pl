%Busqueda laboral
contador(roque).
joven(roque).
trabajoEn(jose,acme).
trabajoEn(roque,acme).
trabajoEn(ana,omni).
trabajoEn(lucia, omni).
trabajoEn(alicia,fiat).
honesto(roque).
ingeniero(ana).
ingeniero(alicia).
habla(roque,frances).
habla(ana,ingles).
habla(ana,frances).
habla(lucia,ingles).
habla(lucia,frances).
habla(cecilia,frances).
abogado(cecilia).
ambicioso(cecilia).
ambicioso(jose).

ambicioso(Persona):- contador(Persona), joven(Persona).
tieneExperiencia(Persona):-trabajoEn(Persona,_).
profesional(Persona):-abogado(Persona).
profesional(Persona):-contador(Persona).
profesional(Persona):-ingeniero(Persona).

puedeAndar(comercioExterior, Persona):-ambicioso(Persona).
puedeAndar(contaduria,Persona):-contador(Persona),honesto(Persona).
puedeAndar(ventas, Persona):-ambicioso(Persona), tieneExperiencia(Persona).
puedeAndar(ventas, lucia).

puedeAndar(proyectos,Persona):-ingeniero(Persona),tieneExperiencia(Persona).
puedeAndar(proyectos,Persona):-abogado(Persona), joven(Persona).
puedeAndar(logistica,Persona):- profesional(Persona), cumpleCondiciones(Persona).

cumpleCondiciones(Persona):-joven(Persona).
cumpleCondiciones(Persona):-trabajoEn(Persona,omni).

