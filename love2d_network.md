# LOVE2D Networking (ENET)

- `host` — ENet хост для коммуникации по сети
- `peer` — участник сети. Оттуда может прийти сообщение или туда можно отправить. Каждый сетевой игрок — это peer.
- `event` — сетевое событие. Имеет тип, тело сообщения и источник

  - `event.type` — тип сообщения:
    - `"receiver"` — получение сообщения
    - `"disconnect"` — отсоединился
    - `"connect"` — новый `peer` подключился
  - `event.peer` — источник, откуда пришло сообщение
  - `event.data` — строка или число, данные которые пришли по сети

- `enet.host_create` — создать сервер, если есть адрес ИЛИ клиент, если нет адреса
- `host:connect("192.168.1.1:6789")` — подключиться к серверу. Эта функция вернет объект типа `peer`.
- `host:broadcast(msg)` - отправить всем, кто подсоединился к серверу, сообщение msg (типа строка)
- `peer:send(msg)` - отправить сообщение в peer
- `peer:connect_id()` — вернет число, уникальный номер пира в сетевой игре.
- `peer:state` — состояние коннекта.
  - disconnected
  - connecting
  - connected
  - zombie
  - unknown
  - и много других....

## Server

```lua
local enet = require("enet")

function love.load()
	host = enet.host_create("0.0.0.0:6789")
end

function love.update(dt)
	local event = host:service() -- забрать сообщение из очереди
	while event do
		if event.type == "receive" then
			print("Got message ", event.data, event.peer)
			event.peer:send("pong")
		elseif event.type == "connect" then
			print("Connected ", event.peer)
		elseif event.type == "disconnect" then
			print("Disconnected ", event.peer)
		end
		event = host:service() -- еще раз забрать сообщение из очереди
		-- в очереди может быть несколько сообщений, нужно все обработать
	end
end
```

## Client

```lua
local enet = require("enet")

function love.load()
	host = enet.host_create() -- !!! ТУТ без адреса
	-- тут заменить localhost на адрес компьютера, где запущена игра сервер
	server = host:connect("localhost:6789")
end

function love.update(dt)
	local event = host:service() -- забрать сообщение из очереди
	while event do
		if event.type == "receive" then
			print("Got message ", event.data, event.peer)
			event.peer:send("ping")
		elseif event.type == "connect" then
			print("Connected ", event.peer)
		elseif event.type == "disconnect" then
			print("Disconnected ", event.peer)
		end
		event = host:service() -- еще раз забрать сообщение из очереди
		-- в очереди может быть несколько сообщений, нужно все обработать
	end
end
```
