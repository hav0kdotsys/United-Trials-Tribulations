mp_potential_step(OBJ_ANDY.x, OBJ_ANDY.y, 2, false)

if(place_meeting(x, y, OBJ_ANDY) && atk_cooldown <= 0)
{
	OBJ_ANDY.andy_health -= 10
	OBJ_HEALTHBAR.image_index += 1
	atk_cooldown = 90
}

if(atk_cooldown >= 0)
{
	atk_cooldown -= 1
}