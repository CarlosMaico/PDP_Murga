data Turista = Turista {
    cansancio :: Int,
    stress :: Int,
    solitario :: Bool,
    idiomas :: [Idioma]
} deriving Show

type Idioma = String

--1
ana = Turista 0 21 False ["Español"]
beto = Turista 15 15 True ["Aleman"]
cathi = Turista 15 15 True ["Aleman", "Catalan"]

--Cambios de posible uso para el data
deltaSegun :: (a -> Int) -> a-> a -> Int
deltaSegun f algo1 algo2 = f algo1  - f algo2

cambiarStress ::Int-> Turista -> Turista
cambiarStress valor turista = turista {stress = stress turista + valor}

cambiarStressPorcentual :: Int -> Turista -> Turista
cambiarStressPorcentual porcentaje turista = cambiarStress (div (porcentaje * stress turista) 100) turista

cambiarCansancio :: Int -> Turista -> Turista
cambiarCansancio valor turista = turista {cansancio = cansancio turista + valor}

aprenderIdioma :: String -> Turista -> Turista
aprenderIdioma idioma turista = turista {idiomas = idioma : idiomas turista}

acompañado :: Turista -> Turista
acompañado turista = turista {solitario = False}

--2
type Excursion = Turista -> Turista

irAPlaya :: Excursion
irAPlaya turista | solitario turista = cambiarCansancio (- 5) turista
                 | otherwise = cambiarCansancio (-1) turista

apreciarAlgo :: String -> Excursion
apreciarAlgo elemento = cambiarStress ((negate.length) elemento)

salicConGente :: String -> Excursion
salicConGente idioma = acompañado . aprenderIdioma idioma

caminar :: Int -> Excursion
caminar minutos  = cambiarStress (- intensidad minutos) . cambiarCansancio (intensidad minutos)

intensidad :: Int -> Int
intensidad = div 4

data Marea = Tranquila | Moderada | Fuerte

paseoEnBarco :: Marea -> Excursion
paseoEnBarco Tranquila = apreciarAlgo "Mar" . caminar 10 . acompañado
paseoEnBarco Moderada = id
paseoEnBarco Fuerte = cambiarStress 6 . cambiarCansancio 10

hacerExcursion :: Excursion -> Turista -> Turista
hacerExcursion excursion = cambiarStressPorcentual (-10).excursion

deltaExcursionSegun :: (Turista -> Int) -> Turista -> Excursion -> Int
deltaExcursionSegun f turista excursion =
    deltaSegun f (hacerExcursion excursion turista) turista

esExcursionEducativa :: Turista -> Excursion -> Bool
esExcursionEducativa turista = (>0). deltaExcursionSegun (length.idiomas) turista

escursionesDesetresantes :: Turista -> [Excursion ]-> [Excursion]
escursionesDesetresantes turista escursiones = filter (esDesestresante turista) escursiones

esDesestresante :: Turista ->Excursion -> Bool
esDesestresante turista = (<= -3) . deltaExcursionSegun stress turista

--3
type Tour = [Excursion]

completo :: Tour
completo = [caminar 20 , apreciarAlgo "cascada", caminar 40, irAPlaya, salicConGente "melmacquiano"]

ladoB :: Excursion -> Tour
ladoB excursion = [paseoEnBarco Tranquila, excursion, caminar 120]

islaVecina :: Marea -> Tour
islaVecina mareaVecina = [paseoEnBarco mareaVecina, excrusionEnIslaVecina mareaVecina, paseoEnBarco mareaVecina]

excrusionEnIslaVecina :: Marea -> Excursion
excrusionEnIslaVecina Fuerte = apreciarAlgo "Lago"
excrusionEnIslaVecina _ = irAPlaya

hacerTour :: Turista -> Tour -> Turista
hacerTour turista tour = foldr hacerExcursion (cambiarStress (length tour) turista) tour

propuestaConvincente :: Turista -> [Tour] -> Bool
propuestaConvincente turista = any (esConvincente turista)

esConvincente :: Turista -> Tour -> Bool
esConvincente turista  tour = (any ( dejaAcompañado turista) .  escursionesDesetresantes turista) tour

dejaAcompañado :: Turista -> Excursion -> Bool
dejaAcompañado turista excursion = (not.solitario . hacerExcursion excursion) turista 

efectividad :: Tour -> [Turista] -> Int
efectividad tour turistas = (sum . map (espiritualidadAportada tour) . filter (flip esConvincente tour)) turistas

espiritualidadAportada :: Tour -> Turista -> Int
espiritualidadAportada tour turista = (negate . deltaRutina tour) turista

deltaRutina :: Tour -> Turista -> Int
deltaRutina tour turista = deltaSegun nivelRutina (hacerTour turista tour) turista

nivelRutina :: Turista -> Int
nivelRutina turista = cansancio turista + stress turista

--4

playasEternas :: Tour
playasEternas = salicConGente "mambu" : repeat irAPlaya

--Para ana si es convincente ya que la primer actividad es desestresante y siempre essta acompañada
--pero para beto el algoritmo diverge ya que este nunca esta acompañado osea es solitario entonces entra en el bucle de ir a la playa
--No, solamente funciona para el caso que se consulte con una lista vacia de tuistas, que dara siempre  0