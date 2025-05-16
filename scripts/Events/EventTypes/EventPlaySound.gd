class_name EventPlaySound extends EventBase


@export_file("*.mp3") var sound : String

func _event(context: EventContext) -> void:
	context.voice.stream = load(sound)
	context.voice.play()
