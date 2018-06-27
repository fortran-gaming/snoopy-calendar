SUBROUTINE SNPPIC(ur, uw, iset, use)
! THIS SUBROUTINE WILL ANALYZE THE INPUT DATA AND PRINT A PICTUREs
implicit none
integer, intent(in) :: ur, uw, iset
logical, intent(in) :: use

integer :: INUM(50), i,  k

character(133) :: line
character(50) :: CHR

line = repeat(' ', len(line))

K=1

do
  READ(ur, '(25(I2,A1))') (INUM(I), CHR(I:I),I=1,ISET)

  DO I=1,ISET
    IF (INUM(I) == -1) then
!     HERE WE WRITE A LINE TO THE PRINTER AND GO BUILD ANOTHER
      LINE(K:len(line)) = repeat(CHR(I:I), len(line)-k+1)
      if (use) WRITE(uw,'(A133)') line
      LINE(1:1) = ' '
      LINE(2:len(line)) = repeat(CHR(i:i), len(line)-1)

      K=1
    endif

    IF (INUM(I) .EQ. -2) return
    IF (INUM(I) == 0 .or. inum(i) == -1) cycle

    LINE(K:K+INUM(I)) = repeat(CHR(i:i), inum(i))
    K = K+INUM(I)

  enddo
enddo

END SUBROUTINE SNPPIC


subroutine userpic(filename, uw)
implicit none
character(*), intent(in) :: filename
integer, intent(in) :: uw
integer :: u, ios
character(133) :: line

open(newunit=u, file=filename, status='old', action='read', iostat=ios)

do while (ios==0)

  read(u,'(A133)', iostat=ios) line

  if(ios/=0) exit
  write(uw,'(A133)') line
enddo

close(u)

end subroutine userpic
