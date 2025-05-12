class_name EventWaitForClick extends EventBase


func _event(context: EventContext) -> void:
	context.emit_signal("we_are_waiting")
	await context.user_clicked
	context.emit_signal("we_are_not_waiting")
