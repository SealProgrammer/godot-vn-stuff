@tool
extends Node2D

@export var starter_texture : Texture:
	set(texture):
		starter_texture = texture
		if is_node_ready():
			sprite.texture = texture

@onready var sprite : Sprite2D = %Sprite
@onready var anims : AnimationPlayer = %AnimationPlayer


var flipped = false

func change_sprite(new_sprite: Texture) -> void:
	anims.play("squish start")
	await anims.animation_finished
	sprite.texture = new_sprite
	anims.play("squish end")
	await anims.animation_finished

func flip() -> void:
	if flipped:
		anims.play("flip 360")
	else:
		anims.play("flip 180")
	
	flipped = not flipped
	
	await anims.animation_finished

func _ready() -> void:
	sprite.texture = starter_texture
