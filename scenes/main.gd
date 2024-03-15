extends Node3D

var counter = 0

var buttons = []

var music_changer = 20
var music_counter = 1
var music_volume = -16

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enable_button_num(1)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if not $Pause.visible:
			$Pause/Buttons.text = str(counter)
			$Pause.visible = true
		else:
			$Pause.visible = false


func enable_button_num (num):
	var button = get_node("Buttons/Button"+str(num))
	enable_button(button)
	

func enable_button (button):
	button.visible = true
	if counter == 0:
		button.flash(false)
	else:
		button.flash()
		
	buttons.append(button)
	
	if $Buttons.get_children().size() > 0:
		$Buttons.remove_child(button)
	else:
		$ButtonsScene.remove_child(button)
		
	$ButtonsEnabled.add_child(button)

	

func enable_random_button ():
	var button:Node3D
	
	if $Buttons.get_children().size() > 0:
		button = $Buttons.get_children().pick_random()
	elif $ButtonsScene.get_children().size() > 0:
		button = $ButtonsScene.get_children().pick_random()
	else:
		$GameOver.visible = true
		return
		
	
	enable_button(button)



func first_game ():
	match counter:
		1:	enable_button_num(2)
		2:	enable_button_num(3)
		_:	enable_random_button()
	
	
func _on_player_button_clicked() -> void:
	if counter == 0:
		$MainMenu.visible = false
		$Music/AudioStreamPlayer1.volume_db = music_volume;
		for m in $Music.get_children():
			m.play()

	counter += 1

	if counter % music_changer == 0:
		music_counter += 1
		if music_counter <= 5:
			get_node("Music/AudioStreamPlayer"+str(music_counter)).volume_db = music_volume;
		
	
	var t = get_tree().create_timer(0.5)
	await t.timeout
	
	first_game()



func _on_credits_meta_clicked(meta: Variant) -> void:
	OS.shell_open("https://www.twitch.tv/videos/2091387371")


func _on_exit_pressed() -> void:
	get_tree().quit()
