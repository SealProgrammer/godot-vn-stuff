class_name EventChangeBackground extends EventBase


# @export var background : Game.Character
@export_file var background : String


func _event(context: EventContext) -> void:
	context.background.texture = load(background)
