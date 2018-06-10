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
      use, intrinsic:: iso_fortran_env, only: output_unit, error_unit,
     &     real64

      IMPLICIT REAL(real64) (A-H,O-Z)

      real(real64) :: AMONTH (12,7,13), ANAM(22), ANUM(2,10,5),
     &          CAL(60,22)
      integer :: NODS(12), i, j, l, month
      integer, parameter :: iset=25

      integer :: ur, uw, ios
      character(4) :: argv
      character(6+4+4) :: filename
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
      if (ios==0) read(argv,'(I4)', iostat=ios) iyr
      if (ios==0) iyrlst = iyr + 1

      usermode='snp'
      call get_command_argument(2, argv, status=ios)
      if (ios==0) read(argv,'(A4)') usermode

      uw = output_unit

      if (iyr<1753.or.iyr>3999) then
        write(error_unit,*) 'WARNING: algorithm may be inaccurate'//
     &                      ' for year', iyr
      endif


      DO 10 I=1,60
      DO 10 J=1,22
10    CAL(I,J)= BLANK
      CAL(1,1)= ONE
      DO 20 J=1,22
20    CAL(11,J)=ANAM(J)
      IF (LNSW) 122,142,122
122   DO 125 I=20,60,8
      DO 125 J=1,22
125   CAL(I,J)=ALIN2
      DO 140 J=4,19,3
      I=13
127   DO 130 L=1,7
      CAL(I,J)=ALIN1
130   I=I+1
      IF (I-55) 135,135,140
135   CAL(I,J)=ALIN3
      I=I+1
      GO TO 127
140   CONTINUE
      DO 141 I=20,60,8
141   CAL(I,1)=ALIN4
142   IDOW=(IYR-1751)+(IYR-1753)/4-(IYR-1701)/100+(IYR-1601)/400
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
      LPYRSW=0
      IF (IYR-4*(IYR/4)) 90,75,90
75    IF (IYR-100*(IYR/100)) 85,80,85
80    IF (IYR-400*(IYR/400)) 90,85,90
85    LPYRSW=1
90    NODS(2)=NODS(2)+LPYRSW
      IF (MF-1) 100,110,95
95    MF=MF-1
      DO 105 MONTH=1,MF
105   IDOW=IDOW+NODS(MONTH)
      IDOW=IDOW-7*((IDOW-1)/7)
      MF=MF+1
110   DO 51 MONTH=MF,ML
      LSTDAY=NODS(MONTH)
      DO 115 I=1,7
      DO 115 JM=1,13
      J=JM+4
115   CAL(I,J)=AMONTH(MONTH,I,JM)
      IF (IDOW-1) 160,160,120
120   ID=IDOW-1
      J=2
      DO 155 K=1,ID
      DO 150 I=14,18
      CAL (I,J)= BLANK
150   CAL(I,J+1)= BLANK
      J=J+3
155   CONTINUE
160   IDAY=1
      II=14
25    J=3*IDOW-1
      N=IDAY/10+1
      I=II
      DO 30 K=1,5
      CAL(I,J)=ANUM(1,N,K)
30    I=I+1
      N=IDAY-10*N+11
      J=J+1
      I=II
      DO 35 K=1,5
      CAL(I,J)=ANUM(2,N,K)
35    I=I+1
      IDOW=IDOW+1
      IF (IDOW-7) 45,45,40
40    IDOW=1
      II=II+8
45    IDAY=IDAY+1
      IF (IDAY-LSTDAY) 25,25,50
50    ID=IDOW
205   I=II
      J=3*ID-1
      DO 210 K=1,5
      CAL(I,J)= BLANK
      CAL(I,J+1)= BLANK
210   I=I+1
      IF (ID-7) 215,220,220
215   ID=ID+1
      GO TO 205
220   IF (II-54) 225,230,230
225   II=54
      ID=1
      GO TO 205

230   select case (usermode)
      case ('snp')
        CALL SNPPIC(ur, uw, iset)
      case ('user')
        write(monthfn,'(A8,I0.2,A4)') 'data/pic',month,'.txt'
        call userpic(monthfn, uw)
      case default
        ! no picture
      end select

      WRITE (uw,'(22A6)') ((CAL(I,J),J=1,22),I=1,60)
51    CONTINUE
      IF (IYR-IYRLST) 235,100,100
235   NODS(2)=NODS(2)-LPYRSW
      IYR=IYR+1
      MF=1
      GO TO 55

100   close(ur)
      close(uw)
      if (uw/= output_unit) print *,'DONE'

1     FORMAT (13A6)
2     FORMAT (11A6)
3     FORMAT (10A6)
4     FORMAT (12I6)

      END program
