extends RayCast3D

signal click

func _process(delta):
	if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		return
		
	var collider = get_collider() 
	if not (collider is Area3D):
		return

	var flashing = collider.get_meta("flashing")
	if not flashing:
		return
		
	collider.set_meta("flashing", false)
	
	var button = collider.get_parent()
	button.click()

	
	click.emit()


