// Draw Event: Show the power bar

// Draw background bar
draw_set_color(c_gray);
draw_rectangle(50, 50, 250, 70, false);

// Draw filled portion based on charge
var bar_width = lerp(0, 160, holdcounter/80);
draw_set_color(c_lime);
draw_rectangle(50, 50, 50 + bar_width, 70, false);