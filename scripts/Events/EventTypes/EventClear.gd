class_name EventClear extends EventBase

func _event(context: EventContext) -> void:
	context.author.text = ""
	context.dialog.text = ""
	context.dialog_en.text = ""
