      SUBROUTINE SNPPIC(ur, uw, iset)
C     THIS SUBROUTINE WILL ANALYZE THE INPUT DATA AND PRINT A PICTURE
C     YOU CAN EXPECT TO GET 1 WARNING MESSAGE DURING COMPILATION
      integer, intent(in) :: ur, uw, iset
      integer :: ILINE(133),INUM(50),ICHR(50)

      integer, parameter :: iblnk = iachar(' ')

      DO I=1,133
        ILINE(I) = iblnk
      enddo
      K=1

   10 READ(ur, '(25(I2,A1))') (INUM(I),ICHR(I),I=1,ISET)
   
      DO I=1,ISET
        IF (INUM(I) .NE. -1) GOTO 100
C     HERE WE WRITE A LINE TO THE PRINTER AND GO BUILD ANOTHER
        DO L=K,133
          ILINE(L)=ICHR(I)
        enddo
        
        WRITE(uw,'(133A1)') (ILINE(K),K=1,133)
        ILINE(1) = iblnk
        DO  K=2,133
          ILINE(K)=ICHR(I)
        enddo
        
        K=1
C error      I=I+1
  100   IF (INUM(I) .EQ. -2) return
        IF (INUM(I) .EQ. 0) cycle
        DO J=1,INUM(I)
          ILINE(K)=ICHR(I)
          K=K+1
        enddo
      enddo
      GOTO 10

 
      END SUBROUTINE SNPPIC
