## Like a normal event but it doesn't wait for anyone.
class_name AsyncEvent extends Event

func run_event() -> void:
	for params in event_parameters:
		params._event(event_ctx)
