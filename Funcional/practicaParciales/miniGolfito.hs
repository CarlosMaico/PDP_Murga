data Jugador = UnJugador {
    nombre :: String,
    padre :: String,
    habilidad :: Habilidad
} deriving (Eq,Show)

data Habilidad = Habilidad {
    fuerzaJugador :: Int,
    precisionJugador :: Int
} deriving (Eq,Show)

bart :: Jugador
bart = UnJugador "Bart" "Homer" (Habilidad 25 60)
todd :: Jugador
todd = UnJugador "Todd" "Ned" (Habilidad 15 80)
rafa :: Jugador
rafa = UnJugador "Rafa" "Gorgory" (Habilidad 10 1)

data Tiro = UnTiro {
    velocidad :: Int,
    precision :: Int,
    altura :: Int
} deriving (Eq, Show)

type Puntos = Int

between :: (Eq a, Enum a) => a -> a -> a -> Bool
between n m x = elem x [n..m]

--1 pensar en palos como funciones

type Palo = Habilidad -> Tiro

putter :: Palo
putter habilidad = UnTiro {
    velocidad = 10,
    precision = precisionJugador habilidad * 2,
    altura = 0
}

madera :: Palo
madera habilidad = UnTiro {
    velocidad = 100,
    altura = 5,
    precision = precisionJugador habilidad `div` 2
}

hierro :: Int -> Palo
hierro n habilidad = UnTiro {
    velocidad = fuerzaJugador habilidad * n,
    precision = precisionJugador habilidad `div` n,
    altura = max (n-3) 0
}

palos :: [Palo]
palos = [putter, madera] ++ map hierro [1..10]

--2
golpe :: Jugador -> (Habilidad -> Tiro) -> Tiro
golpe jugador palo = (palo . habilidad) jugador

golpe' :: Palo -> Jugador -> Tiro
golpe' palo = palo . habilidad

--3
data Obstaculo = UnObstaculo {
    puedeSuperar :: Tiro -> Bool,
    efectoLuegoDeSuperar :: Tiro -> Tiro
}

intentarSuperarObstaculo :: Obstaculo -> Tiro -> Tiro
intentarSuperarObstaculo obstaculo tiroOriginal 
    | puedeSuperar obstaculo tiroOriginal = efectoLuegoDeSuperar obstaculo tiroOriginal
    | otherwise = tiroDetenido

tunelConRampita :: Obstaculo
tunelConRampita = UnObstaculo superaTunelConRampita efectoTunelConRampita

superaTunelConRampita :: Tiro -> Bool
superaTunelConRampita tiro = precision tiro > 90 && vaAlRasDelSuelo tiro

vaAlRasDelSuelo :: Tiro -> Bool
vaAlRasDelSuelo = (==0). altura

efectoTunelConRampita :: Tiro -> Tiro
efectoTunelConRampita tiro = UnTiro {velocidad = velocidad tiro *2, precision = 100, altura = 0}

tiroDetenido :: Tiro
tiroDetenido = UnTiro 0 0 0

laguna :: Int -> Obstaculo
laguna largo = UnObstaculo superaLaguna (efectoLaguna largo)

superaLaguna :: Tiro -> Bool
superaLaguna tiro = velocidad tiro > 80 && (between 1 5 . altura) tiro

efectoLaguna :: Int -> Tiro -> Tiro
efectoLaguna largo tiroOriginal = 
    UnTiro {velocidad=velocidad tiroOriginal, precision=precision tiroOriginal, altura = altura tiroOriginal `div` largo } 

hoyo :: Obstaculo
hoyo = UnObstaculo superaHoyo efectoHoyo

superaHoyo :: Tiro -> Bool
superaHoyo tiro = (between 5 20 . velocidad) tiro && vaAlRasDelSuelo tiro

efectoHoyo :: Tiro -> Tiro
efectoHoyo _ = tiroDetenido

--4
palosUtiles :: Jugador -> Obstaculo -> [Palo]
palosUtiles jugador obstaculo = filter (leSirveParaSuperar jugador obstaculo) palos

leSirveParaSuperar :: Jugador -> Obstaculo -> Palo -> Bool
leSirveParaSuperar jugador obstaculo  palo = puedeSuperar obstaculo (golpe jugador palo)


cuantosObstaculosConsecutivosSupera :: Tiro -> [Obstaculo] -> Int
cuantosObstaculosConsecutivosSupera _ [] = 0
cuantosObstaculosConsecutivosSupera tiro (obstaculo : obstaculos)
    | puedeSuperar obstaculo tiro = 1 + cuantosObstaculosConsecutivosSupera (efectoLuegoDeSuperar obstaculo tiro) obstaculos
    | otherwise = 0

maximoSegun :: Ord b => (a-> b) -> [a] -> a
maximoSegun f = foldl1 (mayorSegun f)

mayorSegun :: Ord x => (t-> x) -> t -> t -> t
mayorSegun f a b | f a > f b = a
                 | otherwise = b

paloMasUtil :: Jugador -> [Obstaculo] -> Palo
paloMasUtil jugador obstaculos = maximoSegun (flip cuantosObstaculosConsecutivosSupera obstaculos . golpe jugador) palos

--5

jugadorDeTorneo = fst
puntosGanados = snd

pierdenLaApuesta :: [(Jugador, Puntos)] -> [String]
pierdenLaApuesta puntosDeTorneo = (map (padre.jugadorDeTorneo) . filter (not . gano puntosDeTorneo)) puntosDeTorneo 


gano :: [(Jugador, Puntos)] -> (Jugador, Puntos) -> Bool
gano puntosDeTorneo puntosDeUnJugador =
   (all ((< puntosGanados puntosDeUnJugador) . puntosGanados) . filter (/= puntosDeUnJugador)) puntosDeTorneo --Solo ganas si todos tiene menor puntos que vos


{-
jugadorDeTorneo = fst
puntosGanados = snd

pierdenLaApuesta :: [(Jugador, Puntos)] -> [String]
pierdenLaApuesta puntosDeTorneo = (map (padre.jugadorDeTorneo) . filter (not . gano puntosDeTorneo)) puntosDeTorneo

gano :: [(Jugador, Puntos)] -> (Jugador, Puntos) -> Bool
gano puntosDeTorneo puntosDeUnJugador = 
    (all ((< puntosGanados puntosDeUnJugador) . puntosGanados) . filter (/= puntosDeUnJugador)) puntosDeTorneo   
-}    