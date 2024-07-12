import Distribution.Simple.Build (createInternalPackageDB)
--1
data Auto = Auto {
    color :: String,
    velocidad :: Int,
    distanciaRecorrida :: Int
} deriving (Show, Eq)

type Carrera = [Auto]

estaCerca :: Auto -> Auto -> Bool
estaCerca auto1 auto2 =  colorDistinto auto1 auto2 && distanciaEntreAutos auto1 auto2 <10

colorDistinto :: Auto -> Auto -> Bool
colorDistinto auto1 auto2 = color auto1 /= color auto2

distanciaEntreAutos :: Auto -> Auto -> Int
distanciaEntreAutos auto1 auto2 = abs (distanciaRecorrida auto1 - distanciaRecorrida auto2)

vaTranquilo :: Auto -> Carrera -> Bool
vaTranquilo auto carrera = (not. tieneAlgunAutoCerca auto) carrera && vaGanando auto carrera

tieneAlgunAutoCerca :: Auto -> Carrera -> Bool
tieneAlgunAutoCerca auto carrera = any (estaCerca auto) carrera

vaGanando :: Auto -> Carrera -> Bool
vaGanando auto carrera = all (lesVaGanando auto) carrera

lesVaGanando :: Auto -> Auto -> Bool
lesVaGanando autoGanador = (< distanciaRecorrida autoGanador) . distanciaRecorrida

puesto :: Auto -> Carrera -> Int
puesto auto  = (1 +) . length . filter (not . lesVaGanando auto)

--2

corra :: Int ->  Auto -> Auto
corra tiempoDeCorrida auto = auto {distanciaRecorrida = distanciaRecorrida auto + distanciaPor tiempoDeCorrida auto}

distanciaPor :: Int -> Auto -> Int
distanciaPor tiempoDeCorrida auto = tiempoDeCorrida * velocidad auto

type ModificadorDeVelocidad = Int -> Int

alterarVelocidad :: ModificadorDeVelocidad -> Auto -> Auto
alterarVelocidad modificador auto = auto {velocidad = (modificador. velocidad) auto}

bajarVelocidad :: Int -> Auto -> Auto
bajarVelocidad velocidadABajar = alterarVelocidad (max 0 . subtract velocidadABajar)

--3
afectarAlosQueCumplen :: (a-> Bool) ->  (a-> a) -> [a] -> [a]
afectarAlosQueCumplen criterio efecto lista = (map efecto. filter criterio) lista ++ filter (not. criterio) lista

type PowerUp = Auto -> Carrera -> Carrera

terremoto :: PowerUp
terremoto autoQueGatillo = afectarAlosQueCumplen (estaCerca autoQueGatillo) (bajarVelocidad 50)

miguelitos :: Int -> PowerUp
miguelitos velocidadABajar autoQueGatillo = afectarAlosQueCumplen (lesVaGanando autoQueGatillo) (bajarVelocidad velocidadABajar)

jetPack :: Int -> PowerUp
jetPack tiempo autoQueGatillo = 
    afectarAlosQueCumplen (== autoQueGatillo) (alterarVelocidad (\_ -> velocidad autoQueGatillo) . corra tiempo . alterarVelocidad (*2))



type Color = String
type Evento = Carrera -> Carrera

simularCarrera :: Carrera -> [Evento] -> [(Int, Color)]
simularCarrera carrera eventos =  (tablaDePosiciones . procesarEventos eventos) carrera 

tablaDePosiciones :: Carrera -> [(Int, Color)]
tablaDePosiciones carrera = map (entradaDeTabla carrera) carrera

entradaDeTabla :: Carrera -> Auto -> (Int, Color)
entradaDeTabla carrera auto = (puesto auto carrera, color auto)

procesarEventos :: [Evento] -> Carrera -> Carrera
procesarEventos eventos carreraInicial = foldr ($) carreraInicial eventos

correnTodos :: Int -> Evento
correnTodos tiempo = map (corra tiempo)

usaPowerUp :: PowerUp -> Color -> Evento
usaPowerUp powerUp colorBuscado carrera = powerUp (find ((== colorBuscado). color) carrera) carrera

find :: (c -> Bool) -> [c] -> c
find cond = head . filter cond

ejeSimularCarrera =
    simularCarrera autosDeEjemplo [correnTodos 30, usaPowerUp (jetPack 3) "azul", usaPowerUp terremoto "blanco", correnTodos 40, usaPowerUp (miguelitos 20) "blanco", usaPowerUp (jetPack 6) "negro", correnTodos 10]

autosDeEjemplo :: [Auto]
autosDeEjemplo = map (\color -> Auto color 120 0) ["rojo", "balnco", "azul" , "negro"]

--5 Se puede agregar ya que powerUp es una funcion podria ser : misilTeledirigido :: Color -> PowerUp  y usarlo como cuaquuier otro power up

-- 5b vaTranquilo puede terminar solo si el auto indicado no va tranuilo, ya que usa any y all estos pueden llegar a terminar sin la necesidad de evaluar toda la lista de autos infinitos por la evaluacion diferida
--para el 1c no terminaria ya que tenemos que filtrar y para filtrar debe reccorer toda la lista de autos que es infinita entonces nunca termina