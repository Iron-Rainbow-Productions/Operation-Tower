extends Node


@export var active_score:int = 0
@export var bank_value:int   = 150
@export var bank_denom = [0,0,0,0,0,0,0]
@export var table_value:int  = 0
@export var banker_offer:int = 0
@export var table_denom = [0,0,0,0,0,0,0]
@export var player_bet:int = 15

@onready var coin_dictionary:Dictionary = {"One":Color("WHEAT"), 
	"Fifty":Color("SILVER"), "Hundred":Color("GOLD"), "Thousand":Color("CYAN"), 
	"Man":Color("DARK_OLIVE_GREEN"),"Hunthousand":Color("CRIMSON"), "Million":Color("PURPLE")}


func calc_offer():
	if active_score == 0:
		banker_offer = 0
	else:
		var true_score:float = float(active_score)/15.0
		banker_offer = int(true_score * player_bet)
	
	SignalRelay.offer_update.emit()

func account(case:int):
	match case:
		0:
			return calc_denoms(bank_value)
		1:
			return calc_denoms(table_value)

func calc_denoms(case_value):
	if case_value != 0: 
		var remainder = case_value
		var denom = 0
		var denoms = [0,0,0,0,0,0,0]
		if remainder >= 1000000:
			denoms[denom] = int(remainder/1000000)
			remainder = remainder - denoms[denom] * 1000000
			denom += 1
		else:
			denoms[denom] = 0
			denom += 1
		if remainder >= 100000:
			denoms[denom] = int(remainder/100000)
			remainder = remainder - denoms[denom] * 100000
			denom += 1
		else:
			denoms[denom] = 0
			denom += 1
		if remainder >= 10000:
			denoms[denom] = int(remainder/10000)
			remainder = remainder - denoms[denom] * 10000
			denom += 1
		else:
			denoms[denom] = 0
			denom += 1
		if remainder >= 1000:
			denoms[denom] = int(remainder/1000)
			remainder = remainder - denoms[denom] * 1000
			denom += 1
		else:
			denoms[denom] = 0
			denom += 1
		if remainder >= 100:
			denoms[denom] = int(remainder/100)
			remainder = remainder - denoms[denom] * 100
			denom += 1
		else:
			denoms[denom] = 0
			denom += 1
		if remainder >= 50:
			denoms[denom] = int(remainder/50)
			remainder = remainder - denoms[denom] * 50
			denom += 1
		else:
			denoms[denom] = 0
			denom += 1
		if remainder >= 1:
			denoms[denom] = int(remainder/1)
			remainder = remainder - denoms[denom] * 1
			denom += 1
		else:
			denoms[denom] = 0
			denom += 1
		return denoms
	else:
		return [0,0,0,0,0,0]
