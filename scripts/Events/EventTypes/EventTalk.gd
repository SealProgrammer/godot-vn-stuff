class_name EventTalk extends EventBase


@export var character : Game.Character
@export var text : String
@export var size_changes : VNCharacter.OpTime = VNCharacter.OpTime.BOTH

func _event(context: EventContext) -> void:
	if VNCharacter.is_leading(size_changes): context.scene.get_char(character).node.play_anim("go_big")
	await context.scene.change_author(character)
	await context.scene.display_text(text)
	if VNCharacter.is_ending(size_changes): context.scene.get_char(character).node.play_anim("go_small")
