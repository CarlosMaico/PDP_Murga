--1
p :: (a -> Bool) -> [a] -> a
p n = (head . filter n)  --devuelve el primer elemnto que cumple una condicion

--2
f :: Ord a1 => (a2 -> a1) -> [(a2, a2)] -> Bool
f x y = (x.fst.head) y > (x.snd.head) y --Compara elmeentos de una liosta de tuplas

--3
g :: Eq c => (n -> c) -> n -> n -> Bool
g f a b = f a == f b

--4
f' :: (b->Bool) -> (a -> b) -> Int -> [a] -> Bool
f' x y z lista = ((>z) . length . filter x . map y) lista

--5
h:: Eq a => a -> [(b,a,c)]-> (b,a,c) 
h nom = head . filter ((nom ==) . g')

g' (_,c,_) = c

--6
f'' :: (Num a, Ord t, Num t) => a -> (a -> t) -> [a] -> a
f'' x _ [] = x
f'' x y (z:zs) | y z > 0 = z + f'' x y zs
               | otherwise = f'' x y zs


--7
f7 :: (Ord p) => p -> (p->q) -> [p] -> q
f7 a b (c:cs) | a > c = f7 a b cs
              | otherwise = b c


--8
f8 :: (Num q) => (t -> Bool) -> p -> [p] -> (q -> t) -> q -> Int
f8 a b c d e | (a . d e) (1, True) = 0
             | otherwise = length (b:c) + e

--9
g9 ::(Eq q) => (p -> q) -> q ->[p] -> p
g9 f x l = (head . filter ((x == ). f)) l

--10

qfsort :: (Eq q) => (p -> q)-> [p]-> [p]
qfsort f [] = []
qfsort f (x:xs) = (qfsort f (filter ((> f x). f ) xs)) ++ [x] ++ (qfsort f (filter ((< f x) . f) xs))


--11
floca :: Num t => (b -> Bool) -> (t -> b) -> t -> [t] 
--floca :: Num t => (b -> Bool) -> (t -> b) -> t -> [t]
floca g f n | (g. f) n = n : floca g f (n+1)
            | otherwise = floca g f (n+1)

--12
g12 ::Ord b => (a -> b) -> (b -> a-> Bool) -> b -> [a]-> Bool
g12 k p r = all (p r) . filter ((> r). k)

--13
f13 :: p ->(q-> t->p) -> q -> [(a,t)]-> Bool
--f13 :: Eq a1 => a1 -> (t1 -> t2 -> a1) -> t1 -> [(a2, t2)] -> Bool
f13 h r x = any (h == ). map (\(_,z) -> r x z)

esDivisible :: Int -> Int -> Bool
esDivisible multiplo divisor = multiplo `div` divisor == 0
