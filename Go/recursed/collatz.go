package main

import(
	"fmt"
	"sort"
	"os"
	"strconv"

)

type Cell struct { // structure holds number and collatz sequence length for sorting purposes
        num int
        length int
}

func collatz(n int64) int64 { //computes length of collatz sequence

	//base case
	if(n == 1){
		return 0
	}
	
	if (n%int64(2) == 0)	{
		return collatz(n/int64(2)) + 1
	} else {
		return collatz (n*3 + 1) + 1
	}


}

// adapted from gosamples.dev
func unique(s []Cell) []Cell { //removes cells with duplicate lengths from a set of Cells
	inResult := make(map[int]bool)

	var result []Cell


	for _, str := range s {
		if _, ok := inResult[str.length]; !ok {

			inResult[str.length] = true
			result = append(result, str)
		}
	}

	return result
}

func main(){

	arg1 := os.Args[1]

	arg2 := os.Args[2]


	//convert arg1 to int
	arg1a, err := strconv.Atoi(arg1)

	//convert arg2 to int
	arg2a, err1 := strconv.Atoi(arg2)

	//using err and err1 to avoid usage error
	_ = err
	_ = err1



	//initialize beginning and ending value
	begin := int64(arg1a)
	end := int64(arg2a)

	if(end < begin) {
		hold := begin
		begin = end
		end = hold
	}


	var cells []Cell //empty set of cells for sorting purposes


	for (begin <= end) {

		var temp Cell

		var length = 0

		temp.num = int(begin)


		// calculte collatz sequence length
		length = int( collatz(begin))

		temp.length = length

		//adding new cell to the set
		cells = append(cells, temp)

		begin+=1

	}


	//remove duplicate lengths
	cells = unique(cells)


	//sorts the list of cells by length
	sort.Slice(cells, func(i, j int) bool {
		return cells[i].length > cells[j].length
	})

	var final []Cell //empty set of cells for sorting purposes
	var k = len(cells)





	fmt.Println("Sorted based on sequence length: ")
	//prints the ten longest collatz sequence lengths
	if(k > 0) {
		for i := 0 ; i < 10 && i < k; i++ {
			fmt.Println(cells[i].num, "		", cells[i].length)


			// add ten longest numbers to the final list to sort
			final = append(final, cells[i])
		}
	}


	sort.Slice(final, func(i, j int) bool {
		return final[i].num > final[j].num
	})


	k = len(final)


	fmt.Println("Sorted based on integer size: ")
	//prints the ten longest collatz sequence lengths by integer size
	if(k > 0) {
		for i := 0 ; i < 10 && i < k; i++ {
			fmt.Println(final[i].num, "		", final[i].length)


		}
	}

}

