class_name EventText extends EventBase

@export var text: String
@export var translation: String

func _event(context: EventContext) -> void:
	print("Saying: ", text)
	
	await context.scene.display_text(text, translation)
