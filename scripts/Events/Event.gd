class_name Event extends Resource

@export var event_parameters : Array[EventBase]

var event_ctx : EventContext

func run_event() -> void:
	for params in event_parameters:
		await params._event(event_ctx)
