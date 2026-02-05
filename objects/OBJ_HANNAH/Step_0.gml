
// Apply gravity
vsp += gravity;

// Move vertically
if (place_meeting(x, y + vsp, OBJ_ENV_GRASS)) {
    while (!place_meeting(x, y + sign(vsp), OBJ_ENV_GRASS)) {
        y += sign(vsp);
    }
    vsp = 0;
} else {
    y += vsp;
}



// Get Andy's position and speed
var andy_x = OBJ_ANDY.x;
var andy_y = OBJ_ANDY.y;
var andy_hsp = OBJ_ANDY.hsp; // Andy's horizontal speed

// Horizontal movement
if (andy_hsp != 0) { // Only move if Andy moves
    if (abs(x - andy_x) > AndyDistance) {
        // Move toward Andy
        if (x < andy_x - AndyDistance) {
            hsp = 2; // move right
        } else if (x > andy_x + AndyDistance) {
            hsp = -2; // move left
        }
    } else {
        hsp = 0; // close enough
    }
} else {
    hsp = 0; // Andy stopped
}


if (andy_y < y - 8 && place_meeting(x, y + 1, OBJ_ENV_GRASS)) {
	jumpcount = 0;	
}

if(andy_hsp !=0) {
// Vertical movement (jump if Andy is above)
if (andy_y < y - 60 && place_meeting(x, y + 1, OBJ_ENV_GRASS)) && (jumpcount == 0) {
    vsp = jump_speed; // jump up
	jumpcount = jumpcount + 1;
}
}

// Apply gravity
vsp += 0.5;
if (vsp > 8) vsp = 8;

// Horizontal collision
if (place_meeting(x + hsp, y, OBJ_ENV_GRASS)) {
    while (!place_meeting(x + sign(hsp), y, OBJ_ENV_GRASS)) {
        x += sign(hsp);
    }
    hsp = 0;
}
x += hsp;

// Vertical collision
if (place_meeting(x, y + vsp, OBJ_ENV_GRASS)) {
    while (!place_meeting(x, y + sign(vsp), OBJ_ENV_GRASS)) {
        y += sign(vsp);
    }
    vsp = 0;
}
y += vsp;
