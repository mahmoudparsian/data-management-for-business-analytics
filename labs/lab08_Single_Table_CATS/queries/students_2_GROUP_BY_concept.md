# GROUP BY Concept

Consider the following (key, value) pairs:

```
('alex', 1)
('alex', 3)
('alex', 4)
('alex', 5)
('jen', 10)
('jen', 15)
('jen', 20)
('max', 100)
('max', 200)
('max', 300)
('max', 400)
('max', 500)
('ted', 7)
```

## GROUP BY: MIN()

```
('alex', MIN[1, 3, 4, 5])             --> ('alex', 1)

('jen', MIN[10, 15, 20])              --> ('jen', 10)

('max', MIN[100, 200, 300, 400, 500]) --> ('max', 100)

('ted', MIN[7])                       --> ('ted', 7)
```

## GROUP BY: MAX()

```
('alex', MAX[1, 3, 4, 5])             --> ('alex', 5)

('jen', MAX[10, 15, 20])              --> ('jen', 20)

('max', MAX[100, 200, 300, 400, 500]) --> ('max', 500)

('ted', MAX[7])                       --> ('ted', 7)
```


## GROUP BY: COUNT()

```
('alex', COUNT[1, 3, 4, 5])             --> ('alex', 4)

('jen', COUNT[10, 15, 20])              --> ('jen', 3)

('max', COUNT[100, 200, 300, 400, 500]) --> ('max', 5)

('ted', COUNT[7])                       --> ('ted', 1)

```


## GROUP BY: AVG()

```
('alex', AVG[1, 3, 4, 5])             --> ('alex', 3.25)

('jen', AVG[10, 15, 20])              --> ('jen', 15.00)

('max', AVG[100, 200, 300, 400, 500]) --> ('max', 300.00)

('ted', AVG[7])                       --> ('ted', 7.00)
```
