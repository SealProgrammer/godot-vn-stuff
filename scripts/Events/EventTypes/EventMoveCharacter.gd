class_name EventMoveCharacter extends EventBase


@export var character : Game.Character
@export_range(0.0, 100.0, 1.0) var screen_percent : float

func _event(context: EventContext) -> void:
	print("Changing character position!!")
	var c : Sprite2D = context.scene.get_char(character).node
	var s : SubViewport = context.subview
	var sc : SubViewportContainer = s.get_parent()
	
	print(sc.size)
	
	c.position.x = float(s.size.x)
