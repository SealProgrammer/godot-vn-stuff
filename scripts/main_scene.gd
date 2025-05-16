class_name Game extends Control

enum Character {
	CHARLOTTE,
	JULIE,
	MADDIE,
	KIDDO
}

@onready var characters : Dictionary = {
	"CHARLOTTE": {
		"name": "千代",
		"node": %Charlotte
	},
	"JULIE": {
		"name": "じゅんか",
		"node": %Julie
	},
	"MADDIE": {
		"name": "チュッキ",
		"node": %Chucky
	},
	"KIDDO": {
		"name": "子",
		"node": %Kid
	}
}

@export_category("Dialog")
@export var events : Array[Event]

@export_category("Setup")
@export var dialog : RichTextLabel
@export var dialog_en : RichTextLabel
@export var author : RichTextLabel
@export var background : TextureRect
@export var subviewport : SubViewport

@export var event_context : EventContext
@export var fadein : Panel

@export var voicelines : AudioStreamPlayer

var still_waiting : bool = false
var skipping_anim : bool = false

@export var go_next : GoNextArrow

func get_char(char: Character) -> Dictionary:
	return characters[Character.find_key(char)]

func wait(s: float) -> void:
	await get_tree().create_timer(s).timeout

func display_text(text: String, trans: String) -> void:
	dialog.text = "[outline_size=3]%s[/outline_size]" % text
	dialog.visible_characters = 0
	
	dialog_en.modulate = Color.TRANSPARENT
	dialog_en.text = "[i][color=#ffffffbb][outline_size=3](%s)[/outline_size][/color][/i]" % trans
	
	var is_bbcode := false
	
	for i in range(len(text)):
		if skipping_anim:
			break
		
		if text[i] == '[':
			is_bbcode = true
			
		if is_bbcode:
			if text[i] == ']':
				is_bbcode = false
		else:
			dialog.visible_characters += 1
			if [",", ".", "!", "?", "\n", "。", "、", "！", "？", "〜"].has(text[i]):
				await wait(0.5)
			else:
				await wait(0.1)
	
	if skipping_anim:
		dialog_en.modulate = Color.WHITE
		dialog.visible_ratio = 1.0
		skipping_anim = false
	else:
		var t : Tween = get_tree().create_tween()
		t.tween_property(dialog_en, "modulate", Color.WHITE, 0.4)

func change_author(new_author: Character) -> void:
	author.text = "[outline_size=8][outline_color=bb5599] %s[/outline_color][/outline_size]" % get_char(new_author)["name"]

func change_sprite(actor : Character, sprite_path : String, size_change: VNCharacter.OpTime) -> void:
	get_char(actor).node.change_sprite(load(sprite_path), size_change)

func converse() -> void:
	for event in events:
		event.event_ctx = event_context
		await event.run_event()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if not event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if dialog.visible_ratio < 1.0:
				skipping_anim = true
			event_context.emit_signal("user_clicked")

func on_waiting() -> void:
	print("waiting!")
	still_waiting = true
	
	await get_tree().create_timer(2).timeout
	
	if still_waiting:
		print("what the fuck is taking so long press the fucking button")
		go_next.appear()

func no_longer_waiting() -> void:
	print("No longer waiting")
	still_waiting = false
	
	go_next.disappear()

func fade(trans: bool) -> void:
	var t : Tween = get_tree().create_tween()
	
	await t.tween_property(fadein, "modulate", Color.TRANSPARENT if trans else Color.WHITE, 1).finished

func the_end() -> void:
	await fade(false)
	var te : Label = $TheEnd
	te.visible = true
	te.modulate = Color.TRANSPARENT
	var t : Tween = get_tree().create_tween()
	
	await t.tween_property(te, "modulate", Color.WHITE, 1).finished


func _ready() -> void:
	event_context.scene_tree = get_tree()
	event_context.author = author
	event_context.dialog = dialog
	event_context.dialog_en = dialog_en
	event_context.background = background
	event_context.scene = self
	event_context.subview = subviewport
	event_context.voice = voicelines
	# event_context.connect("user_clicked", on_waiting)
	
	event_context.connect("we_are_waiting", on_waiting)
	event_context.connect("we_are_not_waiting", no_longer_waiting)
	
	await get_tree().process_frame #HACK waits for everything to be loaded before continuing, fixes some things where root is loaded but other things are not.
	
	fade(true)
	
	converse()
