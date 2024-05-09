
--1
siguiente :: Integer -> Integer
siguiente numero = numero + 1

--2
mitad :: Double -> Double
mitad numero = numero / 2

--3
inversa :: Double -> Double
inversa numero = 1 / numero

--4
triple :: Integer -> Integer
triple numero = numero * 3

--5
esNumeroPositivo :: Double -> Bool
esNumeroPositivo numero = numero > 0

--6
--esMultiploDe :: Integer -> Integer -> Bool
--esMultiploDe numero otroNumero = ((== 0) . otroNumero `mod`) numero

esMultiploDe :: Integer -> Integer -> Bool
esMultiploDe numero otroNumero = ((== 0) . (otroNumero `mod`)) numero

--7
esBisiesto :: Integer -> Bool
esBisiesto año = ((|| esMultiploDe 4 año) . esMultiploDe 400) año 


--8 
inversaRaizCuadrada :: Double -> Double
inversaRaizCuadrada numero = (sqrt. inversa) numero

--9 
incrementMCuadradoN :: Integer -> Integer -> Integer
incrementMCuadradoN numero otroNumero = ((+ otroNumero) . (^2)) numero


--10
esResultadoPar :: Integer -> Integer -> Bool
esResultadoPar numero otroNumero = (even . (numero^)) otroNumero
