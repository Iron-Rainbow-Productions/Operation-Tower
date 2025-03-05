extends Node2D
class_name Tower

var card_res:CardVariant__res

@onready var animation_player = $AnimationPlayer

@onready var card_1 = $Card_1
@onready var card_2 = $Card_2
@onready var card_3 = $Card_3
@onready var card_4 = $Card_4
@onready var card_5 = $Card_5
@onready var card_6 = $Card_6
@onready var card_7 = $Card_7
@onready var card_8 = $Card_8
@onready var card_9 = $Card_9
@onready var card_10 = $Card_10
@onready var card_11 = $Card_11
@onready var card_12 = $Card_12
@onready var card_13 = $Card_13
@onready var card_14 = $Card_14
@onready var card_15 = $Card_15
@onready var card_16 = $Card_16
@onready var card_17 = $Card_17
@onready var card_18 = $Card_18
@onready var card_19 = $Card_19
@onready var card_20 = $Card_20
@onready var card_21 = $Card_21
@onready var card_22 = $Card_22
@onready var card_23 = $Card_23
@onready var card_24 = $Card_24
@onready var card_25 = $Card_25
@onready var card_26 = $Card_26
@onready var card_27 = $Card_27
@onready var card_28 = $Card_28
@onready var card_29 = $Card_29
@onready var card_30 = $Card_30
@onready var card_31 = $Card_31
@onready var card_32 = $Card_32
@onready var card_33 = $Card_33
@onready var card_34 = $Card_34
@onready var card_35 = $Card_35
@onready var card_36 = $Card_36
@onready var deck = $Deck



@onready var towercontent = [card_1, card_2, card_3, card_4,
							card_5, card_6, card_7, card_8, 
							card_9, card_10, card_11, card_12, 
							card_13, card_14, card_15, card_16, 
							card_17, card_18, card_19, card_20, 
							card_21, card_22, card_23, card_24, 
							card_25, card_26, card_27, card_28, 
							card_29, card_30, card_31, card_32, 
							card_33, card_34, card_35, card_36]

@onready var row1 = 							 [card_1]
@onready var row2 = 						[card_2, card_3]
@onready var row3 = 					[card_4, card_5, card_6]
@onready var row4 = 				[card_7, card_8, card_9, card_10]
@onready var row5 = 			[card_11, card_12, card_13, card_14, card_15]
@onready var row6 = 		[card_16, card_17, card_18, card_19, card_20, card_21]
@onready var row7 = 	[card_22, card_23, card_24, card_25, card_26, card_27, card_28]
@onready var row8 = [card_29, card_30, card_31, card_32, card_33, card_34, card_35, card_36]

@onready var rows =[row1, row2, row3, row4, row5, row6, row7, row8]

@export var deckselection:int = 0
var shuffleddeck = []

func _ready():
	reset_GameDealer()
	connect_signals()
	await get_tree().create_timer(.2).timeout
	shuffle()


func reset_GameDealer():
	GameDealer.burnt = false
	GameDealer.turn = 1
	print("Dealer Reset")

func shuffle():
	var card_id = 0
	shuffleddeck = GameDealer.deckcontents[deckselection]
	shuffleddeck.shuffle()
	shuffleddeck.shuffle()
	for row in rows:
		for card:Card in row:
			card.card = card_id
			card.turn_off()
			card.assign_Card(shuffleddeck[card_id])
			card_id += 1
	#animation_player.play("Shuffle")
	await get_tree().create_timer(7).timeout

func build_tower():
	for row in rows:
		for card:Card in row:
			card.Card_Res = card_res
			card.build_Card()

func connect_signals():
	SignalRelay.hit_mashed.connect(reveal_row)

func reveal_row():
	GameDealer.turn += 1
	match GameDealer.turn:
		0:
			pass
		1:
			pass
		2:
			for card:Card in row2:
				card.animation_player.play("Card_Flip")
		3:
			for card:Card in row3:
				card.animation_player.play("Card_Flip")
		4:
			for card:Card in row4:
				card.animation_player.play("Card_Flip")
		5:
			for card:Card in row5:
				card.animation_player.play("Card_Flip")
		6:
			for card:Card in row6:
				card.animation_player.play("Card_Flip")
		7:
			for card:Card in row7:
				card.animation_player.play("Card_Flip")
		8:
			for card:Card in row8:
				card.animation_player.play("Card_Flip")
