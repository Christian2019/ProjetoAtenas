extends Node2D

func _ready():
	Global.Stats=self
	process_mode = Node.PROCESS_MODE_ALWAYS

func _process(delta):
	if Global.player!=null:
		Global.player.multiplierController()
		$AllStats/maxHp/Value.text=str(Global.player.maxHp)
		$AllStats/maxHpPercentBonus/Value.text=str(Global.player.maxHpPercentBonus*100)
		$AllStats/hpRegeneration/Value.text=str(Global.player.hpRegeneration)
		$AllStats/lifeStealChance/Value.text=str(Global.player.lifeStealChance*100)
		$AllStats/percentDamage/Value.text=str(Global.player.percentDamage*100)
		$AllStats/baseDamage/Value.text=str(Global.player.baseDamage)
		$AllStats/percentCritDamage/Value.text=str(Global.player.percentCritDamage*100)
		$AllStats/attackSpeed/Value.text=str(Global.player.attack_Speed*100)
		$AllStats/armor/Value.text=str(Global.player.armor)
		$AllStats/Dodge/Value.text=str(Global.player.dodge*100)
		$AllStats/maxDodge/Value.text=str(Global.player.maxDodge)
		$AllStats/moveSpeed/Value.text=str(Global.player.moveSpeedPercentBonus*100)
		$AllStats/luck/Value.text=str(Global.player.luck*100)
		$AllStats/dracma/Value.text=str(Global.player.dracma)
