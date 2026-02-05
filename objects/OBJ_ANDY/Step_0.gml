
/// Andy - Step Event

// Death
if(andy_health <= 0)
{
	room_goto(room_last)
}

// Gain Health
var _inst_LargeMedpack = instance_place(x, y, OBJ_LARGE_MEDPACK)
var _inst_SmallMedpack = instance_place(x, y, OBJ_SMALL_MEDPACK)

if(_inst_LargeMedpack != noone)
{
	andy_health += 50
	OBJ_HEALTHBAR.image_index -= 5
	instance_destroy(_inst_LargeMedpack)
}

if(_inst_SmallMedpack != noone)
{
	andy_health += 20
	OBJ_HEALTHBAR.image_index -= 2
	instance_destroy(_inst_SmallMedpack)
}

// Horizontal input
if (keyboard_check(vk_right)) {
	walking_direction = "right"
    hsp = 4;
} else if (keyboard_check(vk_left)) {
	walking_direction = "left"
    hsp = -4;
} else {
    hsp = 0;
}

// Gravity
vsp += 0.7;

// Charged Jump
if (keyboard_check(vk_space)) {
	holdcounter += 1;
	if holdcounter > 100 {
	holdcounter = 80 }
}

if (keyboard_check_released(vk_space)) {
     if (place_meeting(x, y + 1, OBJ_ENV_GRASS) || place_meeting(x, y + 1, OBJ_ENV_STONE ) || place_meeting(x, y + 1, OBJ_ENV_BREAKABLE )) {
        vsp = -(holdcounter/4); // jump 
		holdcounter = 0;
} }

// Horizontal collision
if (hsp != 0) {
    var signh = sign(hsp);
    repeat (abs(hsp)) {
        if (!place_meeting(x + signh, y,  OBJ_ENV_GRASS) && !place_meeting(x + signh, y,  OBJ_ENV_STONE) && !place_meeting(x + signh, y,  OBJ_ENV_BREAKABLE)) {
            x += signh;
        } else {
            break; // stop at wall
        }
    }
}

// Vertical collision
if (vsp != 0) {
    var signv = sign(vsp);
    repeat (abs(vsp)) {
        if (!place_meeting(x, y + signv,  OBJ_ENV_GRASS) && !place_meeting(x, y + signv,  OBJ_ENV_STONE) && !place_meeting(x, y + signv,  OBJ_ENV_BREAKABLE)) {
            y += signv;
        } else {
            vsp = 0; // stop falling/jumping
            break;
        }
    }
}

if y > room_height + 100 {
	room_restart()	
}

// SledgeHammer Functionality

// Define Breakable Object
var _inst_breakable_left = instance_place(x - 3, y, OBJ_ENV_BREAKABLE)
var _inst_breakable_right = instance_place(x + 3, y, OBJ_ENV_BREAKABLE)

if(holding_hammer && _inst_breakable_left != noone || holding_hammer && _inst_breakable_right != noone) 
{
	show_debug_message("Collision with 'Breakable' detected! Instance ID: " + string(_inst_breakable_left == noone ? _inst_breakable_right : _inst_breakable_left)) // Not needed, for debugging purposes only
	if(keyboard_check_pressed(ord("F"))) 
	{
		instance_destroy(_inst_breakable_left == noone ? _inst_breakable_right : _inst_breakable_left)
	}
}


// Room Navigation

// Room1
if(place_meeting(x, y, inst_5E92F425))
{
	instance_destroy(inst_5E92F425)
}
if(place_meeting(x, y, inst_5440D6C3) && !instance_exists(inst_5E92F425)) 
{
	room_goto_next()
}


// Room2
if(place_meeting(x, y, inst_15D4C637)) 
{
	instance_destroy(inst_15D4C637) // Pick up Sledgehammer
	holding_hammer = true
}

// Sprite Index
if(walking_direction == "right")
{
	image_index = 0
}

if(walking_direction == "left")
{
	image_index = 1
}

if(walking_direction == "left" && holding_hammer)
{
	image_index = 2
}

if(walking_direction == "right" && holding_hammer)
{
	image_index = 3
}

