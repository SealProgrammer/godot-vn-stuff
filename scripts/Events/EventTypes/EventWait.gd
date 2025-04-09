class_name EventWait extends EventBase

@export var time: float

func _event(context: EventContext) -> void:
	print("Pausing for ", time)
	await context.scene_tree.create_timer(time).timeout
	print("Finished waiting!")
