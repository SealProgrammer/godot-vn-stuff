class_name EventTheEnd extends EventBase


func _event(context: EventContext) -> void:
	await context.scene.the_end()
