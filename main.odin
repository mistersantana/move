package move

import rl "vendor:raylib"

// constants
SCREEN_WIDTH :: i32(800)
SCREEN_HEIGHT :: i32(450)

// entry point
main :: proc() {

	rl.InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "move!")
	rl.SetTargetFPS(60)

	// init player character[s]
	player1 := Player {
		x      = 100,
		y      = 250,
		width  = 50,
		height = 50,
		speed  = f32(SCREEN_WIDTH / 2),
		color  = rl.GRAY,
		state  = .Idle,
	}

	for !rl.WindowShouldClose() {
		// update
		update_player(&player1)

		//draw
		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)

		draw_player(player1)

		rl.EndDrawing()
	}

	rl.CloseWindow()
}
