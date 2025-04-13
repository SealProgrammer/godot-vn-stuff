class_name EventFlipCharacter extends EventBase


@export var character : Game.Character

func _event(context: EventContext) -> void:
	await context.scene.get_char(character).node.flip()
