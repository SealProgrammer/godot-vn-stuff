class_name EventAuthor extends EventBase

@export var author: Game.Character

func _event(context: EventContext) -> void:
	print("Author is now: ", author)
	
	await context.scene.change_author(author)
