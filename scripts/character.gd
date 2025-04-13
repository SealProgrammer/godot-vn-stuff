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

var flipped : bool = false

static func is_leading(time: OpTime) -> bool:
	return time == OpTime.LEADING or time == OpTime.BOTH

static func is_ending(time: OpTime) -> bool:
	return time == OpTime.END or time == OpTime.BOTH

func move_to(position: float, time: float, animated: bool) -> void:
	if not animated:
		self.position.x = position
		return

	anims.play("walk")

	var tween : Tween = get_tree().create_tween()
	# might implement at some point (tm)
#	tween.set_ease(Tween.EASE_IN)
	
	tween.tween_property(self, "position", Vector2(position, self.position.y), time)
	
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
	if flipped:
		anims.play("flip 360")
	else:
		anims.play("flip 180")
	
	flipped = not flipped
	
	await anims.animation_finished

func play_anim(anim: String) -> void:
	anims.play(anim)

func _ready() -> void:
	sprite.texture = starter_texture
