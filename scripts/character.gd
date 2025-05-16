@tool
class_name VNCharacter extends Node2D

@export var starter_texture : Texture:
	set(texture):
		starter_texture = texture
		if is_node_ready():
			sprite.texture = texture

@onready var sprite : Sprite2D = %Sprite
@onready var anims : AnimationPlayer = %AnimationPlayer

enum OpTime {
	LEADING,
	BOTH,
	END,
	NEITHER
}

static func is_leading(time: OpTime) -> bool:
	return time == OpTime.LEADING or time == OpTime.BOTH

static func is_ending(time: OpTime) -> bool:
	return time == OpTime.END or time == OpTime.BOTH

func move_to(pos: float, time: float, animated: bool) -> void:
	if not animated:
		self.position.x = pos
		return

	anims.play("walk")

	var tween : Tween = get_tree().create_tween()
	# might implement at some point (tm)
#	tween.set_ease(Tween.EASE_IN)
	
	tween.tween_property(self, "position", Vector2(pos, position.y), time)
	
	await tween.finished
	
	anims.stop()
	anims.play("RESET")


func change_sprite(new_sprite: Texture, op_time: OpTime) -> void:
	if is_leading(op_time):
		anims.play("squish start")
		await anims.animation_finished

	sprite.texture = new_sprite

	if is_ending(op_time):
		anims.play("squish end")
		await anims.animation_finished

func flip() -> void:
	if sprite.flip_h:
		anims.play("flip 360")
		await anims.animation_finished
		anims.play("RESET")
		sprite.flip_h = false
	else:
		anims.play("flip 180")
		await anims.animation_finished
		anims.play("RESET")
		sprite.flip_h = true
	
	await anims.animation_finished

func play_anim(anim: String) -> void:
	anims.play(anim)

func _ready() -> void:
	sprite.texture = starter_texture
