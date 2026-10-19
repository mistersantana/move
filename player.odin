package move

import rl "vendor:raylib"

// types
Player_State :: enum {
	Idle,
	Moving,
	Jumping,
}

Player :: struct {
	x:          f32,
	y:          f32,
	width:      f32,
	height:     f32,
	speed:      f32,
	velocity_y: f32,
	color:      rl.Color,
	state:      Player_State,
}

// supporting procs
draw_player :: proc(p: Player) {
	rl.DrawRectangleRec({p.x, p.y, p.width, p.height}, p.color)
}

update_player :: proc(p: ^Player) {
	// physics variables
	gravity := f32(1800)
	jump_speed := f32(700)

	ground_y := f32(rl.GetScreenHeight())

	// jumping
	if rl.IsKeyPressed(.SPACE) && p.y + p.height >= ground_y {
		p.velocity_y = -jump_speed
		p.state = .Jumping
	}

	// gravity
	p.velocity_y += gravity * rl.GetFrameTime()
	p.y += p.velocity_y * rl.GetFrameTime()

	// ground collision
	if p.y + p.height >= ground_y {
		p.y = ground_y - p.height
		p.velocity_y = 0
		p.state = .Idle
	}

	// movement
	if rl.IsKeyDown(.D) {
		p.x += p.speed * rl.GetFrameTime()

		if p.state != .Jumping {
			p.state = .Moving
		}
	}

	if rl.IsKeyDown(.A) {
		p.x -= p.speed * rl.GetFrameTime()

		if p.state != .Jumping {
			p.state = .Moving
		}
	}

}
