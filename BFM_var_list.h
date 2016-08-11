      INTEGER, parameter :: jptra = 51
      INTEGER, parameter :: jptra_dia = 23

C State variables

        integer,parameter :: ppO2o=1, ppN1p=2, ppN3n=3, ppN4n=4, 
     &     ppO4n=5,  ppN5s=6,  ppN6r=7,  ppB1c=8,  ppB1n=9,  ppB1p=10, 
     &     ppP1c=11, ppP1n=12, ppP1p=13, ppP1i=14, ppP1s=15, ppP2c=16, 
     &     ppP2n=17, ppP2p=18, ppP2i=19, ppP3c=20, ppP3n=21, ppP3p=22, 
     &     ppP3i=23, ppP4c=24, ppP4n=25, ppP4p=26, ppP4i=27, ppZ3c=28, 
     &     ppZ3n=29, ppZ3p=30, ppZ4c=31, ppZ4n=32, ppZ4p=33, ppZ5c=34, 
     &     ppZ5n=35, ppZ5p=36, ppZ6c=37, ppZ6n=38, ppZ6p=39, ppR1c=40,
     &     ppR1n=41, ppR1p=42, ppR1s=43, ppR2c=44, ppR6c=45, ppR6n=46, 
     &     ppR6p=47,ppR6s=48, ppR7c=49, ppO3c=50, ppO3h=51

C      diagnostic indexes
       integer,parameter :: ppPPG=1, ppNPP=2, ppBPP=3,ppDIC=4, ppCO2=5,
     &      ppHCO3=6,ppCO3=7,   ppAc=8,
     &      pppH =9, pppCO2=10, ppF01 =11, ppF02=12, ppF03=13,
     &      ppF04=14, ppF05=15, ppF06 =16, ppF07=17, ppF08=18,
     &      ppF09=19, ppF10=20, ppF11 =21, ppF12=22, ppF13=23


