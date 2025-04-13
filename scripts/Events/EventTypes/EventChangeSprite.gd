class_name EventChangeSprite extends EventBase

@export var character : Game.Character
@export_file("*.png") var sprite : String
@export var size_changes : VNCharacter.OpTime = VNCharacter.OpTime.BOTH

func _event(context: EventContext) -> void:
	context.scene.change_sprite(character, sprite, size_changes)
