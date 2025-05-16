class_name EventFade extends EventBase

enum direction {
	TO_BLACK,
	FROM_BLACK
}

@export var fade_direction : direction

func _event(context: EventContext) -> void:
	await context.scene.fade(fade_direction == direction.FROM_BLACK)
