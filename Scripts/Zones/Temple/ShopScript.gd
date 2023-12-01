extends Node2D

#SOMENTE PARA TESTE
var itens_personagem = []
#Listas de Itens
var listaItens 
var random_value = RandomNumberGenerator.new()

var lastItemClicked=0
var lastTextureClicked=Texture.new()

var scrolls; 

var attack1_itens
var attack2_itens
var torreta_itens
var dash_itens
var ultimate_itens

var gold_for_stone={"Sold":2,"Buy":1}

var gold_for_wood={"Sold":2,"Buy":1}

var stone_for_gold={"Sold":2,"Buy":1}

var stone_for_wood={"Sold":2,"Buy":1}

var wood_for_gold={"Sold":2,"Buy":1}

var wood_for_stone={"Sold":2,"Buy":1}

func tradeLabelsText():
	$MINHAS_COISAS___TROCA/TROCA/Ouro/Sold.text=str(gold_for_stone.Sold)
	$MINHAS_COISAS___TROCA/TROCA/Ouro/GoldForStone/Ammount.text=str(gold_for_stone.Buy)
	$MINHAS_COISAS___TROCA/TROCA/Ouro/GoldForWood/Ammount.text=str(gold_for_wood.Buy)
	
	$MINHAS_COISAS___TROCA/TROCA/Pedra/Sold.text=str(stone_for_gold.Sold)
	$MINHAS_COISAS___TROCA/TROCA/Pedra/StoneForGold/Ammount.text=str(stone_for_gold.Buy)
	$MINHAS_COISAS___TROCA/TROCA/Pedra/StoneForWood/Ammount.text=str(stone_for_wood.Buy)
	
	$MINHAS_COISAS___TROCA/TROCA/Madeira/Sold.text=str(wood_for_gold.Sold)
	$MINHAS_COISAS___TROCA/TROCA/Madeira/WoodForGold/Ammount.text=str(wood_for_gold.Buy)
	$MINHAS_COISAS___TROCA/TROCA/Madeira/WoodForStone/Ammount.text=str(wood_for_stone.Buy)

func _ready():
	tradeLabelsText()
	$MINHAS_COISAS___TROCA/MinhasCoisas.disabled=true



func _on_minhas_coisas_pressed():
	$MINHAS_COISAS___TROCA/MINHASCOISAS.visible=true
	$MINHAS_COISAS___TROCA/TROCA.visible=false
	$MINHAS_COISAS___TROCA/ItemHUD.visible=false
	
	$MINHAS_COISAS___TROCA/MinhasCoisas.disabled=true
	$MINHAS_COISAS___TROCA/Troca.disabled=false 
	$MINHAS_COISAS___TROCA/Itens.disabled=false
	

func _on_troca_pressed(): 
	$MINHAS_COISAS___TROCA/MINHASCOISAS.visible=false
	$MINHAS_COISAS___TROCA/TROCA.visible=true
	$MINHAS_COISAS___TROCA/ItemHUD.visible=false
	
	$MINHAS_COISAS___TROCA/MinhasCoisas.disabled=false
	$MINHAS_COISAS___TROCA/Troca.disabled=true 
	$MINHAS_COISAS___TROCA/Itens.disabled=false


	
func _on_nope_pressed():
	$Warning.visible=false;

func _on_itens_pressed():
	$MINHAS_COISAS___TROCA/MINHASCOISAS.visible=false
	$MINHAS_COISAS___TROCA/TROCA.visible=false
	$MINHAS_COISAS___TROCA/ItemHUD.visible=true
	
	$MINHAS_COISAS___TROCA/MinhasCoisas.disabled=false
	$MINHAS_COISAS___TROCA/Troca.disabled=false 
	$MINHAS_COISAS___TROCA/Itens.disabled=true
	
func _on_gold_for_stone_pressed():
	var trade=gold_for_stone
	
	if(Global.player.gold>=trade.Sold):
		Global.player.gold-=trade.Sold
		Global.player.stone+=trade.Buy

func _on_gold_for_wood_pressed():
	var trade=gold_for_wood
	
	if(Global.player.gold>=trade.Sold):
		Global.player.gold-=trade.Sold
		Global.player.wood+=trade.Buy


func _on_stone_for_gold_pressed():
	var trade=stone_for_gold
	
	if(Global.player.stone>=trade.Sold):
		Global.player.stone-=trade.Sold
		Global.player.gold+=trade.Buy

func _on_stone_for_wood_pressed():
	var trade=stone_for_wood
	
	if(Global.player.stone>=trade.Sold):
		Global.player.stone-=trade.Sold
		Global.player.wood+=trade.Buy


func _on_wood_for_gold_pressed():
	var trade=wood_for_gold
	
	if(Global.player.wood>=trade.Sold):
		Global.player.wood-=trade.Sold
		Global.player.gold+=trade.Buy


func _on_wood_for_stone_pressed():
	var trade=wood_for_stone
	
	if(Global.player.wood>=trade.Sold):
		Global.player.wood-=trade.Sold
		Global.player.stone+=trade.Buy
