program collatz
        implicit none

        integer :: count

        real(kind = 16) :: begin, passed, val
        real(kind = 16) :: collatzz
        external collatzz




begin = 9780657630.0

count = 1
        write (*,*) begin

do while (begin /= 1)
        print *, begin
        
        count = count + 1
        begin = collatzz (begin)

end do

print *, "Length : ", count



end program collatz

        real(kind = 16) function collatzz (passed) result (val)
               real(kind = 16):: passed
        
                if (mod(passed, 2.0) == 0) then
                        val = passed/2
                else
                        val = passed * 3 + 1
                        return
                end if


        end function collatzz
