C     SNOOPY CALENDAR PROGRAM FOR PDP-11 FORTRAN
C     TAKEN FROM (NON-WORKING) IBM FORTRAN+BAL VERSION
C     MODIFICATIONS BY T. M. KENNEDY 29-DEC-84
C
C     COMPONENTS NEEDED ARE:
C       SNPCAL.FOR (THIS FILE)
C       SNPPIC.FOR - PICTURE DATA INTERPRETER
C        -or-
C     NULPIC.FOR - NULL PICTURE NON-INTERPRETER
C       SNPCAL.DAT - DATA FILE FOR PICTURES
C
C     OUTPUT PRODUCED:
C       SNPCAL.OUT - PRINTER IMAGE OF THE DESIRED CALENDAR
C
C     HOW TO COMPILE AND LINK IT:
C       FORT/F77 SNPCAL.FOR/NOCK/NOTR
C       FORT/F77 SNPPIC.FOR/NOCK/NOTR
C       LINK/F77 SNPCAL,SNPCAL
C
C     THIS PROGRAM IS DESIGNED TO BE COMPILED UNDER THE PDP-11 FORTRAN-77
C     COMPILER VERSION 5.0-14 OR LATER. HOWEVER, IT DOES NOT UTILIZE ANY
C     FORTRAN-77 EXTENSIONS, THEREFORE YOU SHULD BE ABLE TO COMPILE IT
C     WITH ANY ANSI 66 FORTRAN-IV, SIMPLY BY CHANGING THE OPEN STATEMENTS.
C     COMMENTED-OUT CODE FOR THE DEC RT-11 FORTRAN-IV COMPILER IS PROVIDED.
C
C     ******************************************************************
C     *                                                                *
C     * PRINTS CALENDAR, ONE MONTH PER PAGE WITH PICTURES OPTIONAL.    *
C     *                                                                *
C     * BEGINNING MONTH AND YEAR, ENDING MONTH AND YEAR MUST BE PRO-   *
C     * VIDED IN 4(I6)  FORMAT ON A CARD IMMEDIATELY FOLLOWING         *
C     * CARD 98 OF DECK.                                               *
C     *                                                                *
C     * IF GRID LINES ARE DESIRED, A 1 MUST APPEAR IN COLUMN 30 OF     *
C     * ABOVE CARD.  A BLANK OR ZERO WILL SUPPRESS GRID LINES.         *
C     *                                                                *
C     * ALL PICTURE DATA DECKS MUST BE TERMINATED WITH CODE -2.        *
C     * CONSECUTIVE -2*S WILL RESULT IN NO PICTURE BEING PRINTED       *
C     * FOR THAT MONTH.                                                *
C     *                                                                *
C     * PICTURE FORMAT CODES --                                        *
C     *    -1    END OF LINE                                           *
C     *    -2    END OF PICTURE                                        *
C     *    -3    LIST CARDS, ONE PER LINE, FORMAT 13A6                 *
C     *    -4    LIST CARDS, TWO PER LINE, FORMAT 11A6/11A6            *
C     *    -5    LIST CARDS, TWO PER LINE, FORMAT 12A6/10A6            *
C     *                                                                *
C     ******************************************************************
      program snpcal

      use, intrinsic:: iso_fortran_env, only: output_unit, error_unit,
     &     real64

      implicit none

      real(real64) :: AMONTH (12,7,13), ANAM(22), ANUM(2,10,5),
     &  CAL(60,22), alin1, alin2, alin3, alin4, blank, one
      integer :: NODS(12), i, j, l, month
      integer, parameter :: iset=25

      integer :: ur, uw, ios, onlymonth, onlyyear, id, iday, idow, ii,
     &  iy1, iy2, iy3, iy4, iyr, iyrlst, k, lnsw, lpyrsw, lstday,
     &  mf, ml, mthlst, n, numb
      character(4) :: argv

      character(4) :: usermode
      character(4+1+3+2+4) :: monthfn

      OPEN(newunit=ur, FILE='snpcal.dat', STATUS='OLD', action='read')
      read(ur,1) (((AMONTH(I,J,K),K=1,13),J=1,7),I=1,12)
      read(ur,2) (ANAM(I),I=1,22)
      read(ur,3) (((ANUM(I,J,K),J=1,10),K=1,5),I=1,2)
      read(ur,4) (NODS(I),I=1,12)
      read(ur,1) BLANK,ONE,ALIN1,ALIN2,ALIN3,ALIN4
      read(ur,4) MF,IYR,MTHLST,IYRLST,LNSW

      call get_command_argument(1, argv, status=ios)
       if (ios/=0) stop 'must specify year and month e.g. 2019 7'
      read(argv,'(I4)', iostat=ios) iyr
      iyrlst = iyr + 1
      onlyyear = iyr

      call get_command_argument(2, argv, status=ios)
       if (ios/=0) stop 'must specify year and month e.g. 2019 7'
      read(argv,'(I2)') onlymonth


      usermode='snp'
      call get_command_argument(3, argv, status=ios)
      if (ios==0) read(argv,'(A4)') usermode

      uw = output_unit

      if (iyr<1753.or.iyr>3999) then
        write(error_unit,*) 'WARNING: algorithm may be inaccurate'//
     &                      ' for year', iyr
      endif


      CAL(:,:) = BLANK
      CAL(1,1)= ONE
      CAL(11,:)=ANAM(:)
      IF (LNSW /= 0) then
        CAL(20:60:8, :) = ALIN2
        DO 140 J=4,19,3
        I=13
127     DO 130 L=1,7
        CAL(I,J)=ALIN1
130     I=I+1
        IF (I-55) 135,135,140
135     CAL(I,J)=ALIN3
        I=I+1
        GO TO 127
140     CONTINUE
        CAL(20:60:8,1) = ALIN4
      endif
      IDOW=(IYR-1751)+(IYR-1753)/4-(IYR-1701)/100+(IYR-1601)/400
      IDOW=IDOW-7*((IDOW-1)/7)
55    IF (IYR-IYRLST) 60,65,100
60    ML=12
      GO TO 70
65    ML=MTHLST
70    IY1=IYR/1000
      NUMB=IYR-1000*IY1
      IY2=NUMB/100
      NUMB=NUMB-100*IY2
      IY3=NUMB/10
      NUMB=NUMB-10*IY3
      IY4=NUMB
      DO 72 J=1,5
      CAL(J+3,1)=ANUM(2,IY1+1,J)
      CAL(J+1,2)=ANUM(2,IY2+1,J)
      CAL(J+1,21)=ANUM(2,IY3+1,J)
72    CAL(J+3,22)=ANUM(2,IY4+1,J)

      LPYRSW = isleapyear(iyr)

      NODS(2)=NODS(2)+LPYRSW
      IF (MF-1) 100,110,95
95    MF=MF-1
      DO 105 MONTH=1,MF
105   IDOW=IDOW+NODS(MONTH)
      IDOW=IDOW-7*((IDOW-1)/7)
      MF=MF+1
110   DO 51 MONTH=MF,ML
      LSTDAY=NODS(MONTH)
      CAL(1:7, 5:17) = AMONTH(MONTH, 1:7, 1:13)
      IF (IDOW-1 > 0) then
        ID=IDOW-1
        J=2
        DO K=1,ID
          CAL(14:18,J:J+1)= BLANK
          J=J+3
        enddo
      endif
      IDAY=1
      II=14
25    J=3*IDOW-1
      N=IDAY/10+1
      CAL(II:II+4, J) = ANUM(1,N,:)
      N=IDAY-10*N+11
      J=J+1
      CAL(II:II+4, J) = ANUM(2,N,:)
      IDOW=IDOW+1
      IF (IDOW-7 > 0) then
        IDOW=1
        II=II+8
      endif
      IDAY=IDAY+1
      IF (IDAY-LSTDAY <= 0) goto 25
      ID=IDOW
205   J=3*ID-1
      CAL(II:II+4, J:J+1) = BLANK
      IF (ID-7 < 0) then
        ID=ID+1
        GO TO 205
      endif
      IF (II-54 < 0) then
        II=54
        ID=1
        GO TO 205
      endif

      select case (usermode)
      case ('snp')
        CALL SNPPIC(ur, uw, iset, onlymonth == month .and.
     &                            iyr == onlyyear)
      case ('user')
        write(monthfn,'(A8,I0.2,A4)') 'data/pic',month,'.txt'
        call userpic(monthfn, uw)
      case default
        ! no picture
      end select

      if (onlymonth == month .and. iyr==onlyyear) then
        WRITE (uw,'(22A6)') ((CAL(I,J),J=1,22),I=1,60)
      endif
51    CONTINUE
      IF (IYR-IYRLST) 235,100,100
235   NODS(2)=NODS(2)-LPYRSW
      IYR=IYR+1
      MF=1
      GO TO 55

100   close(ur)
      close(uw)
      if (uw /= output_unit) print *,'DONE'

1     FORMAT (13A6)
2     FORMAT (11A6)
3     FORMAT (10A6)
4     FORMAT (12I6)

      contains

      elemental integer function isleapyear(year)

      integer, intent(in) :: year

      isleapyear = 0

      if(modulo(year,4) /= 0) return

      if(modulo(year,100) /= 0) then
        isleapyear = 1
        return
      endif

      if(modulo(year,400) == 0) isleapyear = 1

      end function isleapyear

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

      open(newunit=u, file=filename, status='old', action='read',
     &   iostat=ios)

      do while (ios==0)

        read(u,'(A133)', iostat=ios) line

        if(ios/=0) exit
        write(uw,'(A133)') line
      enddo

      close(u)

      end subroutine userpic

      END program
