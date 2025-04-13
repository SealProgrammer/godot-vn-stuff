class_name EventChangeSprite extends EventBase

@export var character : Game.Character
@export_file("*.png") var sprite : String

func _event(context: EventContext) -> void:
	print("Changing sprite!")
	context.scene.change_sprite(character, sprite)
