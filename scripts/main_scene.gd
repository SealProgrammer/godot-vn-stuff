class_name Game extends Control

enum Character {
	CHAR1,
	CHAR2
}

@onready var characters = {
	"CHAR1": {
		"name": "Character 1",
		"node": %Character1
	},
	"CHAR2": {
		"name": "Character 2",
		"node": %Character2
	}
}

@export_category("Dialog")
@export var events : Array[Event]

@export_category("Setup")
@export var dialog : RichTextLabel
@export var author : RichTextLabel
@export var background : TextureRect
@export var subviewport : SubViewport

@export var event_context : EventContext

func get_char(char: Character) -> Dictionary:
	return characters[Character.find_key(char)]

func wait(s: float):
	await get_tree().create_timer(s).timeout

func display_text(text: String) -> void:
	dialog.text = "[outline_size=3]%s[/outline_size]" % text
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
	# TBD if this needs to be animated
	author.text = "[outline_size=8][outline_color=bb5599] %s[/outline_color][/outline_size]" % characters[new_author]["name"]

func change_sprite(actor : Character, sprite_path : String) -> void:
	characters[actor].node.texture = load(sprite_path)

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
	event_context.subview = subviewport
	
	await get_tree().process_frame #HACK waits for everything to be loaded before continuing, fixes some things where root is loaded but other things are not.
	
	converse()
