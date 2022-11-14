# Переменные

```lua
-- локальные(лучше)
local a = 10

--глобальные
a = 10
```

# Ветвление

```lua
if условие then
  действия
else
  действия
end
```

## Switch-case (Else If)

```lua
if условие then
  действия
elseif условие then
  действия
else
  действия
end
```

# Операторы сравнения

- Равенство `==`
- Неравно ~=
- Больше `>`
- Больше или равно `>=`
- Меньше `<`
- Меньше или равно `<=`

# Булевы переменные

Истина `true` (с маленькой буквы!)
Ложь `false`.

# Циклы

```lua
for i = 1, 10 do
  -- действия
end

--цикл с шагом 3
for i = 1, 10, 3 do
  -- действия
end

--цикл пробегающий по списку
for i = 1, #list do
  v = list[i]
  -- действия
end

--цикл пробегающий по списку(более надежный)
for i, v in ipairs(list) do
  -- i - это индекс элемента
  -- v - это элемент массива
  -- действия
end

while(условие)do
  -- действия
end

repeat
  -- действия
until(условие)
```

# Как создать список (массив)

> Индексация в массивах с `1`.

```lua
arr = {1,4,7,9}
arr[1] == 1
arr[2] == 4
arr[3] == 7
arr[4] == 9
```

Взятие размера массива

```lua
#arr -- решетка перед именем переменной массива(таблицы)
```

Вставка в массив

```lua
arr = {}
table.insert(arr, 'hello')
table.insert(arr, 'world')
#arr == 2
arr[1] == 'hello'
arr[2] == 'world'
```

Удаление из массива по индексу

```lua
arr = {'a', 'b', 'c', 'd'}
#arr == 4
table.remove(arr, 2) -- {'a','c','d'}
#arr == 3
```

# Как создать таблицу как словарь

```lua
dict = {
  "a" = 42,
  "b" = 32,
}

dict.c = 7 -- положить в словарь 7 по ключу 'c'
dict['d'] = 13 -- положить в словарь 13 по ключу 'd'
```

Оператор `.` (точка) и `[]` (квадратные скобки) — это одно и то же — доступ к полю таблицы по ключу.

# ООП

## Си-стайл

```lua
function NewPlayer(x, y)
  return {
    x = x, y = y,
    height = 10, width = 15,
    speedX = 1, speedY = 0,
  }
end

function PlayerDraw(self)
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

function PlayerUpdate(self, dt)
  self.x = self.x + self.speed * dt
end

-- Теперь использование этого объекта и методов

local p = NewPlayer(10, 20)

function love.update(dt)
  PlayerUpdate(p, dt)
end

function love.draw()
  PlayerDraw(p)
end
```

## Прототипное ООП на метатаблицах

TODO: надо бы объяснить что происходит....
Оператор `:` — это синтаксический сахар на оператором точка `.`
Следующие записи эквивалентны: `p:update(dt)` и `p.update(p, dt)`.

```lua
local Player = {
  x = 0, y = 0,
  width = 50, height = 50,
  speedX = 20, speedY = 20,
}

function Player:new(o)
  o = o or {}
  self.__index = self
  setmetatable(o, self)
  return o
end

function Player:draw()
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

function Player:update(dt)
  self.x = self.x + self.speedX * dt
  self.y = self.y + self.speedY * dt
end

--- использование
local p = Player:new({x=10, y=20})

function love.update(dt)
  p:update(dt)
end

function love.draw()
  p:draw()
end
```

## ООП на замыканиях

```lua
function Player(x, y)
  local self = {
    x = x, y = y,
    width = 50, height = 50,
    speedX = 20, speedY = 20,
  }
  local update = function(dt)
    self.x = self.x + self.speedX * dt
    self.y = self.y + self.speedY * dt
  end
  local draw = function()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
  end

  return {
    update = update,
    draw = draw,
  }
end

-- использование

local p = Player(10, 10)

function love.update(dt)
  p.update(dt)
end

function love.draw()
  p.draw()
end
```

# Love2D

```lua
function love.keypressed(btn)
end
```

mouse

animations

textures

вектора и направления

## AABB коллизии

```go
func Collide(a, b HitBox) bool {
	rect1 := a.GetHitRect()
	rect2 := b.GetHitRect()
	return rect1.X < rect2.X+rect2.Width &&
		rect1.X+rect1.Width > rect2.X &&
		rect1.Y < rect2.Y+rect2.Height &&
		rect1.Y+rect1.Height > rect2.Y
}
```
