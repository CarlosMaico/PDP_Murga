import Text.Show.Functions ()

data Personaje = UnPersonaje {
    nombre :: String,
    salud :: Float,
    elementos :: [Elemento],
    anioPresente :: Int
} deriving (Show,Eq)

maico = UnPersonaje "Maico" 100 []  2024

data Elemento = UnElemento {
    tipo :: String,
    ataque :: (Personaje -> Personaje),
    defensa :: (Personaje -> Personaje)
}

--Instancias para que compile el Show
instance Show Elemento where
    show = tipo

instance Eq Elemento where
    (==) elemento1 elemento2 = tipo elemento1 == tipo elemento2

--1
mandarAlAnio :: Int -> Personaje -> Personaje
mandarAlAnio anio personaje = personaje {anioPresente = anio}

meditar :: Personaje -> Personaje
meditar = modificarSalud (*1.5)

modificarSalud :: (Float -> Float) -> Personaje -> Personaje
modificarSalud f personaje = personaje{salud = f (salud personaje)}

causarDanio :: Float -> Personaje -> Personaje
causarDanio daño = modificarSalud (max 0 . flip (-) daño) --aca uso flip por que quiero que a la slud del personaje se le reste el daño, no al reves

--2
esMalvado :: Personaje -> Bool
esMalvado personaje = any (esDeTipo "Maladad") (elementos personaje)

esDeTipo :: String -> Elemento -> Bool
esDeTipo unTipo elemento = tipo elemento == unTipo

danioQueProduce :: Personaje -> Elemento -> Float
danioQueProduce personaje elemento = ((salud personaje -) .salud . ataque elemento) personaje

enemigosMortales :: Personaje -> [Personaje] -> [Personaje]
enemigosMortales personaje enemigos = filter (esEnemigoMortal personaje) enemigos

esEnemigoMortal :: Personaje -> Personaje -> Bool
esEnemigoMortal personaje enemigo = any (tieneAtaqueMortal personaje) (elementos enemigo)

tieneAtaqueMortal :: Personaje -> Elemento-> Bool
tieneAtaqueMortal personaje elemento = danioQueProduce personaje elemento == salud personaje

--3
--Creo Elementos
noHacerNada :: a -> a
noHacerNada = id

concentracion ::Int -> Elemento
concentracion nivelDeConcentracion = UnElemento "Magia" noHacerNada ((!! nivelDeConcentracion).iterate meditar)

esbirrosMalvados :: Int -> [Elemento]
esbirrosMalvados cantidad = replicate cantidad unEsbirro

unEsbirro :: Elemento
unEsbirro = UnElemento "Maldad" (causarDanio 1) noHacerNada

--Creo Personajes

jack :: Personaje
jack = UnPersonaje "Jack" 300 [concentracion 3, katanaMagica] 200

katanaMagica :: Elemento
katanaMagica = UnElemento "Magia" (causarDanio 1000) noHacerNada

aku :: Int -> Float -> Personaje
aku anio saludInicial = UnPersonaje {nombre = "Aku",
                                     salud = saludInicial,
                                     elementos = concentracion 4 :   portalAlFuturoDesde anio : esbirrosMalvados (100*anio),
                                     anioPresente = anio}

portalAlFuturoDesde :: Int -> Elemento
portalAlFuturoDesde anio = UnElemento "Magia" (mandarAlAnio (anio +2800)) (aku (anio + 2800) . salud)

--4

estaMuerto = ((==0).salud)
luchar :: Personaje -> Personaje -> (Personaje , Personaje)
luchar atacante defensor | estaMuerto atacante = (defensor , atacante)
                         | otherwise = luchar (usarElementos ataque defensor (elementos atacante)) (usarElementos defensa atacante (elementos atacante))

usarElementos :: (Elemento -> Personaje -> Personaje) -> Personaje -> [Elemento] -> Personaje
usarElementos f personaje elementos = foldl afectar personaje (map f elementos)

afectar :: t1 -> (t1 -> t2) -> t2
afectar personaje funcion = funcion personaje


--5
--f:: (Eq z, Num p) => (p->a->(b,a))->(Int -> p) ->p -> [a]-> [b]
f :: Eq t1 => (t1 -> a1 -> (a2, a2)) -> (Int -> t1) -> t1 -> [a1] -> [a2]
f x y z | y 0 == z = map (fst . x z) 
        | otherwise = map (snd . x (y 0))




