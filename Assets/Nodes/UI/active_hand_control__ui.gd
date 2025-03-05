extends Control

@onready var stay_btn = $VBoxContainer/MarginContainer/HBoxContainer/Stay_btn
@onready var hit_btn = $VBoxContainer/MarginContainer/HBoxContainer/Hit_btn


func _on_hit_btn_pressed():
	SignalRelay.hit_mashed.emit()
