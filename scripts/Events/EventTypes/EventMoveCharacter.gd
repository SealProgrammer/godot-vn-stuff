class_name EventMoveCharacter extends EventBase


@export var character : Game.Character
@export var screen_percent : float = 50.0
@export var animated : bool = true
@export var time : float = 1.0
#@export_exp_easing("inout") var move_exp

func _event(context: EventContext) -> void:
	var c : VNCharacter = context.scene.get_char(character).node
	var s : SubViewport = context.subview
	var sc : SubViewportContainer = s.get_parent()
	
	await c.move_to(sc.size.x * (screen_percent / 100.0), animated, time)
