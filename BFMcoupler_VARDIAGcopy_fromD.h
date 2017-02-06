C BFMcoupler/BFMcoupler_VARDIAGcopy_fromD.h,v 1.0
C -----------------------------------------------------------------------------

C Copyright (C) 2017 Gianpiero Cossarini (gcossarini@inogs.it)

C This program is free software; you can redistribute it and/or modify it
C under the terms of the GNU General Public License as published by the Free
C Software Foundation; either version 3 of the License, or (at your option)
C any later version.
C
C This program is distributed in the hope that it will be useful,
C but WITHOUT ANY WARRANTY; without even the implied warranty of
C MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
C GNU General Public License for more details.

C -----------------------------------------------------------------------------

C copy OUTPUT_ECOLOGY diagnostics from vector d to local variables of diagnostic in BFMcoupler_calc_tendency.f 
C 
              diaPPG(i,j,k)=d(1)
              diaNPP(i,j,k)=d(2)
              diaBPP(i,j,k)=d(3)
              diaDIC(i,j,k)=d(4)
              diaCO2(i,j,k)=d(5)
              diaHCO3(i,j,k)=d(6)
              diaCO3(i,j,k)=d(7)
              diaAc(i,j,k)=d(8)
              diapH(i,j,k)=d(9)
              diapCO2(i,j,k)=d(10)
              diaF01(i,j,k)=d(11)
              diaF02(i,j,k)=d(12)
              diaF03(i,j,k)=d(13)
              diaF04(i,j,k)=d(14)
              diaF05(i,j,k)=d(15)
              diaF06(i,j,k)=d(16)
              diaF07(i,j,k)=d(17)
              diaF08(i,j,k)=d(18)
              diaF09(i,j,k)=d(19)
              diaF10(i,j,k)=d(20)
              diaF11(i,j,k)=d(21)
              diaF12(i,j,k)=d(22)
              diaF13(i,j,k)=d(23)
              diaxpar(i,j,k)=er(6)
              diawspeed(i,j,k)=er(9)
              diaRHOSitu(i,j,k)=er(3)
              diaPCO2atm(i,j,k)=er(5)
