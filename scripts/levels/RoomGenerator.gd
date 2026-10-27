extends Node
class_name RoomGenerator

@export var room_scene: PackedScene
@export var min_rooms: int = 4
@export var max_rooms: int = 8
@export var room_size: Vector2 = Vector2(1024, 576)

var rooms: Array[Node2D] = []

func generate() -> Array[Node2D]:
	rooms.clear()
	var count = Globals.rng.randi_range(min_rooms, max_rooms)
	for i in count:
		var room = room_scene.instantiate() as Node2D
		room.position = Vector2(i * room_size.x, 0)
		add_child(room)
		rooms.append(room)
	return rooms
