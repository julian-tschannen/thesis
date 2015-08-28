frozen class
	PLAYER

create
	make

feature -- Initialization

	make (n: V_STRING; b: BOARD)
			-- Create a player with name `n' playing on board `b'.
		note
			status: creator
		require
			name_exists: not n.is_empty
			board_exists: b /= Void
		do
			create name.make_from_v_string (n)
			board := b
--			money := 0
			position := {BOARD}.Start_position
			set_owns ([name])
		ensure
			name_set: name.sequence = n.sequence
			board_set: board = b
			at_start: position = {BOARD}.Start_position
			broke: money = 0
		end

feature -- Access

	name: V_STRING
			-- Player name.

	board: BOARD
			-- Board on which the player in playing.			

	position: INTEGER
			-- Current position on the board.

	money: INTEGER
			-- Amount of money.

feature -- Moving

	move (n: INTEGER)
			-- Advance `n' positions on the board.
		require
			not_beyond_start: n >= {BOARD}.Start_position - position

			modify_field(["closed", "position"], Current)
		do
			position := position + n
		ensure
			position_set: position = old position + n
		end

feature -- Money

	transfer (amount: INTEGER)
			-- Add `amount' to `money'.
		require
			modify_field(["closed", "money"], Current)
		do
			money := (money + amount).max (0)
		ensure
			money_set: money = (old money + amount).max (0)
		end

feature -- Basic operations

	play (d1, d2: DIE)
			-- Play a turn with dice `d1', `d2'.
		note
			explicit: wrapping
		require
			board.is_wrapped

			modify_field (["closed", "money", "position"], Current)
			modify (d1, d2)
		do
			d1.roll
			d2.roll
			move (d1.face_value + d2.face_value)
			if position <= board.squares.upper then
				check board.squares.inv end
				board.squares [position].affect (Current)
			end
		ensure
			player_moved: old position + 2 <= position and position <= old position + 2 * {DIE}.Face_count
		end

invariant
	position_not_negative: position >= 0
	money_non_negative: money >= 0
	owns_def: owns = [name]
	name_not_void: name /= Void
	name_exists: not name.sequence.is_empty
	board_exists: board /= Void
	position_valid: position >= {BOARD}.Start_position -- Token can go beyond the finish position, but not the start

note
	explicit: owns

end
