
type Peso = Int
type Tiempo = Int
type Grados = Int

data Gimnasta = Gimnasta{
    peso :: Int,
    tonificacion :: Int
}deriving Show

data Rutina = Rutina {
    nombre :: String,
    duracionTotal :: Tiempo,
    ejercicios :: [Ejercicio]
}


--1
tonificar :: Int -> (Gimnasta -> Gimnasta)
tonificar n gimnasta = gimnasta {tonificacion = tonificacion gimnasta + n}

quemarCalorias :: Int -> (Gimnasta -> Gimnasta)
quemarCalorias kcal gimnasta = gimnasta {peso = peso gimnasta - kcal `div` 500}


--2
type Ejercicio = Tiempo -> Gimnasta -> Gimnasta

cinta :: Int -> Tiempo -> (Gimnasta -> Gimnasta)
cinta velocidad tiempo = quemarCalorias (tiempo * velocidad * 10)

caminata :: Tiempo -> (Gimnasta -> Gimnasta)
caminata = cinta 5

pique :: Tiempo -> (Gimnasta -> Gimnasta)
pique  tiempo = cinta (tiempo `div` 2 + 20) tiempo

pesas :: Peso -> Tiempo -> (Gimnasta -> Gimnasta)
pesas peso tiempo | tiempo > 10 = tonificar peso
                  | otherwise = id

colina :: Grados -> Tiempo -> (Gimnasta -> Gimnasta)
colina inclinacion tiempo = quemarCalorias (2 * tiempo * inclinacion)

montaña :: Grados -> Tiempo -> (Gimnasta -> Gimnasta)
montaña inclinacion tiempo = tonificar 3 . colina (inclinacion + 5) (tiempo `div` 2) . colina inclinacion (tiempo `div` 2) 


--3
realizarRutina :: Gimnasta  -> Rutina -> Gimnasta
realizarRutina gimnastaInicial rutina  = 
        foldl (\gimnasta ejercicio -> ejercicio (tiempoParaEjercicio rutina) gimnasta) gimnastaInicial (ejercicios rutina)


 
tiempoParaEjercicio :: Rutina -> Tiempo
tiempoParaEjercicio rutina = ((div (duracionTotal rutina)) . length . ejercicios) rutina

ejemplo = realizarRutina (Gimnasta 90 0) (Rutina "Mi Rutina" 30 [caminata, pique, pesas 5, colina 30, montaña 30])

--4
mayorCantidadDeEjercicios :: [Rutina] -> Int
mayorCantidadDeEjercicios = maximum . map (length.ejercicios)

nombresDeRutinasTonificantes :: Gimnasta -> [Rutina] -> [String]
nombresDeRutinasTonificantes gimnasta = map nombre . filter ((> tonificacion gimnasta) .tonificacion . realizarRutina gimnasta)

hayPeligrosa :: Gimnasta -> [Rutina] -> Bool
hayPeligrosa gimnasta = any ((< peso gimnasta `div` 2) . peso . realizarRutina gimnasta) 







