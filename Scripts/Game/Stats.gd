extends Node2D

func _ready():
	Global.Stats=self
	process_mode = Node.PROCESS_MODE_ALWAYS

func _process(delta):
	if Global.player!=null:
		$AllStats/maxHp/Value.text=str(Global.player.maxHp)
		$AllStats/maxHpPercentBonus/Value.text=str(Global.player.maxHpPercentBonus)
		$AllStats/hpRegeneration/Value.text=str(Global.player.hpRegeneration)
		$AllStats/lifeStealChance/Value.text=str(Global.player.lifeStealChance)
		$AllStats/percentDamage/Value.text=str(Global.player.percentDamage)
		$AllStats/baseDamage/Value.text=str(Global.player.baseDamage)
		$AllStats/percentCritDamage/Value.text=str(Global.player.percentCritDamage)
		$AllStats/attackSpeed/Value.text=str(Global.player.attack_Speed)
		$AllStats/armor/Value.text=str(Global.player.armor)
		$AllStats/Dodge/Value.text=str(Global.player.dodge)
		$AllStats/maxDodge/Value.text=str(Global.player.maxDodge)
		$AllStats/moveSpeed/Value.text=str(Global.player.moveSpeedPercentBonus)
		$AllStats/luck/Value.text=str(Global.player.luck)
		$AllStats/dracma/Value.text=str(Global.player.dracma)
