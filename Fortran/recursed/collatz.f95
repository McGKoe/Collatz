program collatz
        implicit none

        integer :: count

        integer(kind = 16) :: num1, num2, passed, val, begin, test, hold
        integer(kind = 16) :: collatzz
        external collatzz

        
        character(100) :: num1char
        character(100) :: num2char

        type Cell
                integer(kind = 16) :: num
                integer(kind = 16) :: length
        end type Cell

        type(Cell), dimension(:), allocatable :: setofcells
        type(Cell), dimension(:), allocatable :: res
        type(Cell), dimension(:), allocatable :: final2

!        type(Cell), dimension(10) :: final2




        type(Cell) :: temp
        integer(kind = 16) :: large 

       integer :: i,k !counter




!get command line arguments
CALL get_command_argument(1, num1char)
CALL get_command_argument(2, num2char)


!convert to int
read(num1char,*)num1
read(num2char,*)num2

if(num2 < num1) then
        hold = num1
        num1 = num2
        num2 = hold
end if




!allocate space to arrays
allocate(setofcells (num2-num1 + 1))
allocate(res (num2-num1 + 1))

allocate(final2 (10))


!counter
i = 1
begin = num1

count = 0

do while (begin <= num2)
        
        count = 0

        temp%num = begin

        test = begin

        count = collatzz (test)

        temp%length = count


        setofcells(i) = temp


        i = i + 1
        begin = begin + 1

end do



        call sort (setofcells, int(num2-num1, 4))

        call remove_dups(setofcells, size(setofcells), res, k)

print *, "Sorted by sequence length:"

i = 1
do
        if (i == size(setofcells) .or. i == 11) then
                exit
        end if

        if (res(i)%num == 0 .and. res(i)%length == 0) then
                exit
        end if


        print*, res(i)
        final2(i) = res(i)

        i = i + 1
end do


        call sort2(final2, 10)
print *, "Sorted by Integer size: "

do i = 1, size(final2)
        if (final2(i)%num == 0 .and. final2(i)%length == 0) then
                exit
        end if

        print*, final2(i)

end do


deallocate(setofcells)
deallocate(res)
deallocate(final2)

contains
        subroutine sort (x, arraysize) !sorts the array by sequence length

        implicit none              
 
        type(Cell), dimension(:), allocatable :: x
                integer, intent(in) :: arraysize
                integer :: maxcell
                integer :: i

                do i = 1, arraysize-1
                        maxcell = findMax(x, i, arraysize)
                        call swap(x(i), x(maxcell))
                end do


         end subroutine sort 

        subroutine swap(a, b) !swaps the values of two Cells
                implicit none

                type(Cell), intent(inout) :: a, b
        
                type(Cell) :: temp

                temp = a

                a = b
        
                b = temp



        end subroutine swap

        integer function findMax(x, first, last)  !finds location of largest
                implicit none
                
                type(Cell), dimension(:), allocatable :: x
                integer, intent(in) :: first, last

                real :: maximum
                integer :: location
                integer :: i

                maximum = x(first)%length !!collatz seuence length of first element
                location = first

                do i = first + 1, last
                        if(x(i)%length > maximum) then
                                maximum = x(i)%length
                                location = i
                        end if

                end do

                findMax = location


        end function findMax

        subroutine sort2 (x, arraysize) !sorts the array by integer size

        implicit none

        type(Cell), dimension(:), allocatable :: x
                integer, intent(in) :: arraysize
                integer :: maxcell
                integer :: i

                do i = 1, arraysize-1
                        maxcell = findMax2(x, i, arraysize)
                        call swap(x(i), x(maxcell))
                end do


         end subroutine sort2

        integer function findMax2(x, first, last)  !finds location of largest
                implicit none

                type(Cell), dimension(:), allocatable :: x
                integer, intent(in) :: first, last

                real :: maximum
                integer :: location
                integer :: i

                maximum = x(first)%num !!num of first element
                location = first

                do i = first + 1, last
                        if(x(i)%num > maximum) then
                                maximum = x(i)%num
                                location = i
                        end if

                end do

                findMax2 = location


        end function findMax2






        subroutine remove_dups(example, n, res, k)
                ! modified from 
                ! https://rosettacode.org/wiki/Remove_duplicate_elements#Fortran
                implicit none


                integer :: n, k, i, j

                type(Cell), dimension(n), intent(in) :: example
                type(Cell), dimension(n), intent(inout) :: res 

                k = 1
                res(1) = example(1)

                outer: do i=2,size(example)
                        do j=1,k
                                if (res(j)%length == example(i)%length) then
                                        cycle outer
                                end if
                        end do
                        k = k + 1
                        res(k) = example(i)


                end do outer


end subroutine remove_dups

end program collatz

        recursive integer(kind = 16) function collatzz (passed) result (val)
               integer(kind = 16):: passed
      
                val = 0
 
                if(passed == 1) then
                        return
                end if 
                if (mod(passed, 2) == 0) then
                        val = collatzz (passed/2) + 1
                else
                        val = collatzz (passed * 3 + 1) + 1
                end if

                return 

        end function collatzz

