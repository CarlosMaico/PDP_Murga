import Text.Show.Functions ()
--1
data Chofer = Chofer {
    nombre :: String,
    kilometrajeAuto :: Float,
    viajes :: [Viaje],
    condicionViaje :: CondicionViaje
} deriving Show

type CondicionViaje = Viaje -> Bool

data Viaje = Viaje {
    fecha :: (Int , Int ,Int),
    cliente :: Cliente,
    costo :: Float
} deriving Show

data Cliente = Cliente {
    nombreCliente :: String,
    lugar :: String
} deriving Show


--2
cualquierViaje :: CondicionViaje
cualquierViaje _ = True

viajesDe200 :: CondicionViaje
viajesDe200 = (>200) . costo

clienteNombreLargo :: Int -> CondicionViaje
clienteNombreLargo nro = (>nro) . length . nombreCliente . cliente

clienteNoViveEn :: String -> CondicionViaje
clienteNoViveEn donde = (/=donde) . lugar . cliente

--3
lucas :: Cliente
lucas = Cliente "Lucas" "Victoria"

daniel :: Chofer
daniel = Chofer "Daniel" 23500 [Viaje (20,4,2017) lucas 150] (clienteNoViveEn "Olivos")

alejandra :: Chofer
alejandra = Chofer "Alejandra" 180000 [] cualquierViaje

--4

puedeTomarViaje :: Viaje -> Chofer -> Bool
puedeTomarViaje viaje chofer = condicionViaje chofer viaje

--5
liquidacionChofer ::  Chofer -> Float
liquidacionChofer chofer = foldr ((+) . costo) 0 (viajes chofer)

--6
realizarViaje :: Viaje -> [Chofer] -> Chofer
realizarViaje viaje choferes =  (hacerViaje viaje . choferConMenosViajes . filter  (puedeTomarViaje viaje)) choferes

choferConMenosViajes :: [Chofer] -> Chofer
choferConMenosViajes [chofer] = chofer
choferConMenosViajes (chofer1:chofer2:choferes)=
    choferConMenosViajes ((elQueMenosViajesHizo chofer1 chofer2) : choferes)

elQueMenosViajesHizo :: Chofer -> Chofer -> Chofer
elQueMenosViajesHizo chofer1 chofer2 | cuantosViajes chofer1 > cuantosViajes chofer2 = chofer2
                                     | otherwise = chofer1

cuantosViajes :: Chofer -> Int
cuantosViajes = length . viajes

hacerViaje :: Viaje -> Chofer -> Chofer
hacerViaje viaje chofer = chofer { viajes = viaje : viajes chofer}

--7

nitoInfy = Chofer "Nito Infy" 70000 viajeInifinitos (clienteNombreLargo 3)


repetirViaje viaje = viaje : repetirViaje viaje
viajeInifinitos :: [Viaje]
viajeInifinitos = repetirViaje (Viaje (11,3,2017) lucas 50)

-- hayar la licquidacion del chofer nito nose puede ya que tiene viajes infinitos y y al usar fold en liquidacion este necesita recorrer toda la lista y nunca va a lograrlo porqie es infinito

-- si da un resultado por que no involucra el uso de la lista infinita osea nunca la evalua gracais  la evaluacion perezosa


--8
gongNeng :: Ord b=> b -> (b->Bool)-> (a->b)-> [a] -> b
gongNeng arg1 arg2 arg3 = max arg1 . head . filter arg2 . map arg3

