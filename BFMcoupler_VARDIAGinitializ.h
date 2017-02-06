C $Header:/MITgcm/pkg/BFMcoupler/BFMcoupler_VARDIAGinitializ.h,v 1.01
C -----------------------------------------------------------------------------

C Copyright (C) 2016 Gianpiero Cossarini (gcossarini@inogs.it)

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
C initialization of local variables of diagnostic in BFMcoupler_calc_tendency.f 
C 
      DO j=1-OLy,sNy+OLy 
      DO i=1-OLx,sNx+OLx 
         do k=1,Nr 
              diaPPG(i,j,k)=0. _d 0 
              diaNPP(i,j,k)=0. _d 0 
              diaBPP(i,j,k)=0. _d 0 
              diaDIC(i,j,k)=0. _d 0 
              diaCO2(i,j,k)=0. _d 0 
              diaHCO3(i,j,k)=0. _d 0 
              diaCO3(i,j,k)=0. _d 0 
              diaAc(i,j,k)=0. _d 0 
              diapH(i,j,k)=0. _d 0 
              diapCO2(i,j,k)=0. _d 0 
              diaF01(i,j,k)=0. _d 0 
              diaF02(i,j,k)=0. _d 0 
              diaF03(i,j,k)=0. _d 0 
              diaF04(i,j,k)=0. _d 0 
              diaF05(i,j,k)=0. _d 0 
              diaF06(i,j,k)=0. _d 0 
              diaF07(i,j,k)=0. _d 0 
              diaF08(i,j,k)=0. _d 0 
              diaF09(i,j,k)=0. _d 0 
              diaF10(i,j,k)=0. _d 0 
              diaF11(i,j,k)=0. _d 0 
              diaF12(i,j,k)=0. _d 0 
              diaF13(i,j,k)=0. _d 0 
              diaxpar(i,j,k)=0. _d 0 
              diawspeed(i,j,k)=0. _d 0 
              diaRHOSitu(i,j,k)=0. _d 0 
              diaPCO2atm(i,j,k)=0. _d 0 
         enddo
       ENDDO
       ENDDO
