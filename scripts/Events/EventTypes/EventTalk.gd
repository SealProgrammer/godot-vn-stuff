class_name EventTalk extends EventBase


@export var character : Game.Character
@export var text : String
@export var translation: String
@export_file("*.mp3") var voice : String
@export var wait_for_input : bool = true
@export var size_changes : VNCharacter.OpTime = VNCharacter.OpTime.BOTH

func _event(context: EventContext) -> void:
	if voice:
		context.voice.stream = load(voice)
		context.voice.play()
	
	if VNCharacter.is_leading(size_changes): context.scene.get_char(character).node.play_anim("go_big")
	await context.scene.change_author(character)
	await context.scene.display_text(text, translation)
	if VNCharacter.is_ending(size_changes): context.scene.get_char(character).node.play_anim("go_small")
	
	context.emit_signal("we_are_waiting")
	await context.user_clicked
	context.emit_signal("we_are_not_waiting")
