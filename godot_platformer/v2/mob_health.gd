extends Node2D
signal no_health()
signal damage()
@onready var health_bar=$health_bar
@onready var damage_text=$damage_text
@onready var anim_player=$AnimationPlayer
var health=100:
	set(value):
		health=value
		health_bar.value=health
		if health<=0:
			health_bar.visible=false
		else:
			health_bar.visible=true
func _ready():
	Global.connect("player_attack",Callable(self,"_on_damage"))
	health_bar.max_value=health
	health_bar.visible=false
	damage_text.modulate.a=0
func _process(delta):
	pass
func _on_damage(player_damage):
	health-=player_damage
	damage_text.text=str(player_damage)
	anim_player.stop()
	anim_player.play("damage_text")
	if health<=0:
		emit_signal("no_health")
	else:
		emit_signal("damage")
