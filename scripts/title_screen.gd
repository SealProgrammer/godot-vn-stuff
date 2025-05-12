extends Control

@onready var creds : Control = $Credits
@onready var fadeout : Panel = $Fadeout
@onready var audio : AudioStreamPlayer = $AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	
	fadeout.mouse_filter = Control.MOUSE_FILTER_STOP
	
	var t : Tween = get_tree().create_tween()
	
	t.tween_property(audio, "volume_db", -80.0, 1)
	await t.parallel().tween_property(fadeout, "modulate", Color.WHITE, 1).finished
	
	get_tree().change_scene_to_file("res://scenes/main_scene.tscn")


func _on_credits_pressed() -> void:
	creds.visible = true
	
	var t : Tween = get_tree().create_tween()
	await t.tween_property(creds, "modulate", Color.WHITE, 0.5).finished


func _on_return_to_title_pressed() -> void:
	var t : Tween = get_tree().create_tween()
	await t.tween_property(creds, "modulate", Color.from_rgba8(255, 255, 255, 0), 0.5).finished

	creds.visible = false
