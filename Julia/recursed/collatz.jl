#!/usr2/local/julia-1.8.2/bin/julia


mutable struct Cell
	num
	length
end



#determines length of collatz sequence recursively
function collatz(n)
	if (n == 1)
		return 0
	end	
	if (n%2 == 0)
		return collatz(n/2) + 1
	else
		return collatz(n*3 + 1) + 1
	end
end



arg1 = ARGS[1]
arg2 = ARGS[2]


start = parse(Int64, arg1)
stop = parse(Int64, arg2)

if stop < start
	hold = start
	start = stop
	stop = hold
end	

#array of cells to sort
cells = Array{Cell,1}(undef, (stop-start))

#counter variable
i = 1


while start < stop

	test = start

	#sets collatz sequence length
	length = collatz(test)


	#create new Cell to add to the list
	temp = Cell(start, length)

	#adds new Cell to the array
	cells[i] = temp

	#increment counter
	global i = i+1

	global start = start + 1


end

#delete duplicates and sort by sequence length
unique!(x -> x.length, cells)
sort!(cells, by = x -> x.length, rev = true)

final = Array{Cell,1}(undef, 10)

#fill final array with 0 cells
final = fill!(final, Cell(0,0))

println("Sorted by sequence length: ")

#add largest sequence lengths to final array
for i = 1:10
	if i > length(cells)
		break
	end


	println(cells[i].num, "		", cells[i].length)
	final[i] = cells[i]

end


#sort final array by integer sieze
sort!(final, by = x -> x.num, rev = true)

println("Sorted based on integer size: ")

for i = 1:10
	if final[i].num == 0
		break
	end
	println(final[i].num, "		", final[i].length)

end


