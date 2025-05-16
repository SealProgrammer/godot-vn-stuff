class_name EventFlipCharacter extends EventBase


@export var character : Game.Character
@export var instant : bool = false

func _event(context: EventContext) -> void:
	await context.scene.get_char(character).node.flip(instant)
