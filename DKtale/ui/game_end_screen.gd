extends Control

const LINES:=[
	"你赢了",
	"暂时的",
	"未完待续",
]

var current_line:=-1
var tween:Tween

@onready var label: Label = $Label

func _ready() -> void:
	show_line(0)
	SoundManager.play_bgm(preload("res://assets/bgm/Elliot Hsu - Elfridean Stories.mp3"))

func _input(event: InputEvent) -> void:
	if tween.is_running():
		return
	
	if (
	event is InputEventKey or 
	event is InputEventMouseButton or
	event is InputEventJoypadButton
	):
		if event.is_pressed() and not event.is_echo():
			if current_line+1<LINES.size():
				show_line(current_line+1)
			else:
				Game.back_to_title()

func show_line(line:int)->void:
	current_line=line
	
	tween=create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	
	if line>0:
		tween.tween_property(label,"modulate:a",0,1)
	else:
		label.modulate.a=0
	
	tween.tween_callback(label.set_text.bind(LINES[line]))
	tween.tween_property(label,"modulate:a",1,1)