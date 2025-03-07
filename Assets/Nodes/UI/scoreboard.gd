extends Control

var old_offer = 0
var old_bet = 0
var old_bank = 0
@export var inc_time:float = .05

@onready var bank__lbl = $VBoxContainer/HBoxContainer/Bank__lbl
@onready var tabled__lbl = $VBoxContainer/HBoxContainer/Tabled__lbl
@onready var current_bet__lbl = $VBoxContainer/HBoxContainer2/VBoxContainer2/CurrentBet__lbl
@onready var offer__lbl = $VBoxContainer/HBoxContainer2/VBoxContainer2/Offer__lbl

@onready var h_box_container_3 = $VBoxContainer/HBoxContainer3
@onready var rc_text__lbl = $VBoxContainer/HBoxContainer3/VBoxContainer2/RCText__lbl
@onready var rowscore__lbl = $VBoxContainer/HBoxContainer3/VBoxContainer2/Rowscore__lbl

func _ready():
	connectUp()
	update_bet_label()
	update_bank_label()


func connectUp():
	SignalRelay.offer_update.connect(update_offer)
	SignalRelay.bet_update.connect(update_bet_label)


func update_offer():
	var target = Banker.banker_offer
	var current = old_offer
	
	if old_offer < target:
		while current < target:
			current += 1
			await get_tree().create_timer(inc_time).timeout
			offer__lbl.text = "Offer: " + str(current)
	elif old_offer > target:
		while current > target:
			current -= 1
			await get_tree().create_timer(inc_time).timeout
			offer__lbl.text = "Offer: " + str(current)
	old_offer = current

func update_bet_label():
	var target = Banker.player_bet
	var current = old_bet
	
	if old_bet < target:
		while current < target:
			current += 1
			await get_tree().create_timer(inc_time).timeout
			current_bet__lbl.text = "Bet: " + str(current)
	elif old_bet > target:
		while current > target:
			current -= 1
			await get_tree().create_timer(inc_time).timeout
			current_bet__lbl.text = "Bet: " + str(current)
	old_bet = current

func update_bank_label():
	var target = Banker.bank_value
	var current = old_bank
	
	if old_bet < target:
		while current < target:
			current += 1
			bank__lbl.text = "Bank: " + str(current)
	elif old_bet > target:
		while current > target:
			current -= 1
			bank__lbl.text = "Bank: " + str(current)
	old_bank = current
