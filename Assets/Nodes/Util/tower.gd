extends Node2D
class_name Tower

var card_res:CardVariant__res

var spare_there = true
var good_save = false

@onready var animation_player = $AnimationPlayer

@onready var card_1:Card = $Card_1
@onready var card_2:Card = $Card_2
@onready var card_3:Card = $Card_3
@onready var card_4:Card = $Card_4
@onready var card_5:Card = $Card_5
@onready var card_6:Card = $Card_6
@onready var card_7:Card = $Card_7
@onready var card_8:Card = $Card_8
@onready var card_9:Card = $Card_9
@onready var card_10:Card = $Card_10
@onready var card_11:Card = $Card_11
@onready var card_12:Card = $Card_12
@onready var card_13:Card = $Card_13
@onready var card_14:Card = $Card_14
@onready var card_15:Card = $Card_15
@onready var card_16:Card = $Card_16
@onready var card_17:Card = $Card_17
@onready var card_18:Card = $Card_18
@onready var card_19:Card = $Card_19
@onready var card_20:Card = $Card_20
@onready var card_21:Card = $Card_21
@onready var card_22:Card = $Card_22
@onready var card_23:Card = $Card_23
@onready var card_24:Card = $Card_24
@onready var card_25:Card = $Card_25
@onready var card_26:Card = $Card_26
@onready var card_27:Card = $Card_27
@onready var card_28:Card = $Card_28
@onready var card_29:Card = $Card_29
@onready var card_30:Card = $Card_30
@onready var card_31:Card = $Card_31
@onready var card_32:Card = $Card_32
@onready var card_33:Card = $Card_33
@onready var card_34:Card = $Card_34
@onready var card_35:Card = $Card_35
@onready var card_36:Card = $Card_36
@onready var deck:Card = $Deck

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

@export var deckselection:int = 1
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
			card.card = shuffleddeck[card_id]
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
	coordinate_Tower()
	deck_ready()

func connect_signals():
	SignalRelay.hit_mashed.connect(reveal_row)

func coordinate_Tower():
	var row_address = 0
	for row in rows:
		var address = 0
		for card:Card in row:
			card.tower_coordinates[0] = row_address 
			card.tower_coordinates[1] = address 
			address += 1
		row_address += 1

func deck_ready():
	deck.deck_ready()
	deck.cardback__bg.visible= true


func reveal_row():
	GameDealer.turn += 1
	match GameDealer.turn:
		0:
			pass
		1:
			pass
		2:
			for card:Card in row2:
				card.flip_Card()
				calc_burn(GameDealer.turn)
		3:
			for card:Card in row3:
				card.flip_Card()
				calc_burn(GameDealer.turn)
		4:
			for card:Card in row4:
				card.flip_Card()
				calc_burn(GameDealer.turn)
		5:
			for card:Card in row5:
				card.flip_Card()
				calc_burn(GameDealer.turn)
		6:
			for card:Card in row6:
				card.flip_Card()
				calc_burn(GameDealer.turn)
		7:
			for card:Card in row7:
				card.flip_Card()
				calc_burn(GameDealer.turn)
		8:
			for card:Card in row8:
				card.flip_Card()
				calc_burn(GameDealer.turn)

func calc_burn(row):
	await get_tree().create_timer(1).timeout
	row = row - 1
	var address = 0
	var target1:Card 
	var target2:Card
	
	match row:
		0:
			GameDealer.burnt = false
		1:
			GameDealer.burnt = false
		2:
			for card:Card in row2:
				target1 = rows[row][card.tower_coordinates[1]]
				target2 =  rows[row][card.tower_coordinates[1]+1]
				#print("New Comparison")
				#print(target1.card, " Card: ", target1.name)
				#print(target2.card, " Card: ", target2.name)
				#print(card.card, " Card: ", card.name)
				if card.card == target1.card:
					if target1.name == card_1.name:
						await get_tree().create_timer(3.1).timeout
						card_1.burn()
					else:
						target1.burn()
					calc_save(target1,row3,row)
				if card.card == target2.card:
					if target2.name == card_1.name:
						card_1.burn()
					else:
						target2.burn()
					calc_save(target2,row3,row)

		3:
			for card in row3:
				target1 = rows[row][card.tower_coordinates[1]]
				target2 =  rows[row][card.tower_coordinates[1]+1]
				
				if card.card == target1.card:
					if target1.name == card_1.name:
						card_1.burn()
					else:
						target1.burn()
					calc_save(target1,row4,row)
				if card.card == target2.card:
					if target2.name == card_1.name:
						card_1.burn()
					else:
						target2.burn()
					calc_save(target2,row4,row)
				

		4:
			for card in row4:
				target1 = rows[row][card.tower_coordinates[1]]
				target2 =  rows[row][card.tower_coordinates[1]+1]
				
				if card.card == target1.card:
					if target1.name == card_1.name:
						card_1.burn()
					else:
						target1.burn()
					calc_save(target1,row5,row)
				if card.card == target2.card:
					if target2.name == card_1.name:
						card_1.burn()
					else:
						target2.burn()
					calc_save(target2,row5,row)

		5:
			for card in row5:
				target1 = rows[row][card.tower_coordinates[1]]
				target2 =  rows[row][card.tower_coordinates[1]+1]
				
				if card.card == target1.card:
					if target1.name == card_1.name:
						card_1.burn()
					else:
						target1.burn()
					calc_save(target1,row6,row)
				if card.card == target2.card:
					if target2.name == card_1.name:
						card_1.burn()
					else:
						target2.burn()
					calc_save(target2,row6,row)
				

		6:
			for card in row6:
				target1 = rows[row][card.tower_coordinates[1]]
				target2 =  rows[row][card.tower_coordinates[1]+1]
				
				if card.card == target1.card:
					if target1.name == card_1.name:
						card_1.burn()
					else:
						target1.burn()
					calc_save(target1,row7,row)
				if card.card == target2.card:
					if target2.name == card_1.name:
						card_1.burn()
					else:
						target2.burn()
					calc_save(target2,row7,row)

		7:
			for card in row7:
				target1 = rows[row][card.tower_coordinates[1]]
				target2 =  rows[row][card.tower_coordinates[1]+1]
				if card.card == target1.card:
					if target1.name == card_1.name:
						card_1.burn()
					else:
						target1.burn()
					calc_save(target1,row8,row)
				if card.card == target2.card:
					if target2.name == card_1.name:
						card_1.burn()
					else:
						target2.burn()
					calc_save(target2,row8,row)

func calc_save(card_id:Card, row, row_num):
	var crd = card_1.card
	
	for x:Card in row:
		if x.card == 8:
			heroicAct(row,x)
			GameDealer.burnt = false
			return true
	if spare_there == true:
		spare_there = false
		good_save = true
		rows[row_num][card_id.tower_coordinates[1]] = card_1
		card_1.tower_coordinates = card_id.tower_coordinates
		card_id.cardback__bg.visible = true
		card_id.card = crd
		card_1.use_Spare(card_id)
		calc_burn(row_num)
		GameDealer.burnt= false
		return true
	else:
		GameDealer.burnt = true
		await get_tree().create_timer(1.5).timeout
		#end_Round()
		return false

func heroicAct(row, card:Card):
	await get_tree().create_timer(1).timeout
	card.be_hero()
	await get_tree().create_timer(.2).timeout
	for x:Card in row:
		if x.card != 8:
			x.heroism()
