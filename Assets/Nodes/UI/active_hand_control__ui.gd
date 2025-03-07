extends Control

@onready var controls = $VBoxContainer/MarginContainer/Controls
@onready var stay_btn = $VBoxContainer/MarginContainer/HBoxContainer/Stay_btn
@onready var hit_btn = $VBoxContainer/MarginContainer/HBoxContainer/Hit_btn


func _on_hit_btn_pressed():
	SignalRelay.hit_mashed.emit()
	update_UI()


func connectUp():
	pass

func update_UI():
	controls.visible = false
	await SignalRelay.row_good
	controls.visible = true
