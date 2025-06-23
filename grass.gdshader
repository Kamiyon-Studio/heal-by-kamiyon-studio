shader_type canvas_item;

uniform float sway_strength = 10.0; // max horizontal movement (pixels)
uniform float sway_speed = 2.0;     // how fast it sways
uniform float sway_offset = 0.0;    // phase offset if you want different grasses to move differently

void vertex() {
    float sway = sin(TIME * sway_speed + sway_offset + VERTEX.y * 0.05) * sway_strength;
    
    // sway more as you go higher (top of grass)
    float factor = clamp((UV.y - 0.2) * 2.0, 0.0, 1.0); // adjust for texture base
    VERTEX.x += sway * factor;
}
