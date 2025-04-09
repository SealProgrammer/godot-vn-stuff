class_name Game extends Control

enum Character {
	CHAR1,
	CHAR2
}

var Characters = {
	"CHAR1": {
		"name": "Character 1"
	},
	"CHAR2": {
		"name": "Character 2"
	}
}

@export_enum("char1", "char2") var char_name

@export_category("Dialog")
@export var events : Array[Event]

@export_category("Setup")
@export var dialog : RichTextLabel
@export var author : RichTextLabel
@export var background : TextureRect

@export var event_context : EventContext

func wait(s: float):
	await get_tree().create_timer(s).timeout

func display_text(text: String) -> void:
	dialog.text = text
	dialog.visible_characters = 0
	
	var is_bbcode := false
	
	for i in range(len(text)):
		if text[i] == '[':
			is_bbcode = true
			
		if is_bbcode:
			if text[i] == ']':
				is_bbcode = false
		else:
			dialog.visible_characters += 1
			if [",", ".", "!", "?", "\n"].has(text[i]):
				await wait(0.5)
			else:
				await wait(0.04)
	
	await wait(2.0)

func change_author(new_author: String) -> void:
	author.text = Characters[new_author]["name"]

func change_sprite(actor : Character, sprite_path : String):
	var sprite = load(sprite_path)
	
	match actor:
		Character.CHAR1:
			$MarginContainer/VBoxContainer/Scene/SubViewportContainer/SubViewport/Base.texture = sprite
		Character.CHAR2:
			$MarginContainer/VBoxContainer/Scene/SubViewportContainer/SubViewport/Base2.texture = sprite

func converse() -> void:
	for event in events:
		event.event_ctx = event_context
		await event.run_event()

func _ready() -> void:
	event_context.scene_tree = get_tree()
	event_context.author = author
	event_context.dialog = dialog
	event_context.background = background
	event_context.scene = self
	
	converse()
