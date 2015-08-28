class
	APPLICATION

create
	make

feature

	make
			-- Launch the application.
		note
			status: creator
			explicit: wrapping, contracts
		local
			count, i: INTEGER
			game: GAME
		do
			from
				count := {GAME}.Min_player_count - 1
			invariant
				decreases ([])
			until
				{GAME}.Min_player_count <= count and count <= {GAME}.Max_player_count
			loop
				print ("Enter number of players: ")
				io.read_integer
				count := io.last_integer
			end

			create game.make (count)
			game.play
			if game.winners.count = 1 then
				print ("%NThe winner is: ")
				print (game.winners [1].name)
			else
				print ("%NThe winners are: ")
				from
					i := game.winners.lower
				invariant
					game.winners.lower <= i and i <= game.winners.upper + 1

					modify ([])
				until
					i > game.winners.upper
				loop
					print (game.winners [i].name)
					i := i + 1
				end
			end
		end
end
