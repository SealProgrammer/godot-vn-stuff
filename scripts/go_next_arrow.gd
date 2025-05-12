class_name GoNextArrow extends Control

@onready var sprite : Sprite2D = $Sprite2D
@onready var anims : AnimationPlayer = $AnimationPlayer

func appear() -> void:
	sprite.modulate.a = 0
	
	var tween : Tween = get_tree().create_tween()
	
	await tween.tween_property(sprite, "modulate", Color.from_rgba8(255, 255, 255, 151), 0.5).finished
	
	print("Tween finished :3")
	
	anims.play("Wobble")

func disappear() -> void:
	anims.play("RESET")
