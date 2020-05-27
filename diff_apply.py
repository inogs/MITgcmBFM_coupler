from commons.utils import file2stringlist
import os

def insert_lines(orig_lines,NEW_LINES,position_line,nLINES,final=False):
    OUTLINES=[]
    for iline in range(position_line):
        OUTLINES.append(orig_lines[iline])

    for line in NEW_LINES: OUTLINES.append(line)

    for iline in range(position_line,nLINES):
        OUTLINES.append(orig_lines[iline])
    if final:
        OUTLINES=[line + "\n" for line in OUTLINES]
    return OUTLINES

MITCODE="../MITgcm/pkg/gchem/"
MYCODE="../code_NADRI/"

# gchem_init_vari.F
filename="gchem_init_vari.F"
infile=MITCODE + filename
outfile=MYCODE + filename

LINES=file2stringlist(infile)
nLINES=len(LINES)
for iline, line in enumerate(LINES):
    if line.find("INTERFACE: ==") >-1: position_line=iline
   
NEW_LINES=[
"#ifdef ALLOW_BFMCOUPLER",
"#include \"BFMcoupler_OPTIONS.h\"",
"#endif"]
OUTLINES=insert_lines(LINES, NEW_LINES, position_line,nLINES)

LINES=OUTLINES
nLINES=len(LINES)
for iline, line in enumerate(LINES):
    if line.find("#endif /* ALLOW_GCHEM */") >-1: position_line=iline
NEW_LINES=[
"#ifdef ALLOW_BFMCOUPLER",
"      IF ( useBFMcoupler) THEN",
"         CALL BFMcoupler_INI_FORCING(myThid)",
"      ENDIF",
"#endif"]
OUTLINES=insert_lines(LINES, NEW_LINES, position_line,nLINES,final=True)
fid=open(outfile,'w')
fid.writelines(OUTLINES)
fid.close()



# gchem_init_fixed.F
filename="gchem_init_fixed.F"
infile=MITCODE + filename
outfile=MYCODE + filename
LINES=file2stringlist(infile)
nLINES=len(LINES)
for iline, line in enumerate(LINES):
    if line.find("#ifdef ALLOW_DIAGNOSTICS") >-1: position_line=iline
NEW_LINES=[
"#ifdef ALLOW_BFMCOUPLER",
"         call BFMcoupler_INIT_FIXED(myThid)",
"#endif"]
OUTLINES=insert_lines(LINES, NEW_LINES, position_line,nLINES,final=True)
fid=open(outfile,'w')
fid.writelines(OUTLINES)
fid.close()

# gchem_fields_load.F
filename="gchem_fields_load.F"
infile=MITCODE + filename
outfile=MYCODE + filename
LINES=file2stringlist(infile)
nLINES=len(LINES)
for iline, line in enumerate(LINES):
    if line.find("#endif /* ALLOW_GCHEM */") >-1: position_line=iline
NEW_LINES=[
"#ifdef ALLOW_BFMCOUPLER",
"      IF ( useBFMcoupler ) THEN",
"       CALl BFMcoupler_FIELDS_LOAD(myIter,myTime,myThid)",
"      ENDIF",
"#endif /* ALLOW_BFMCOUPLER */"]
OUTLINES=insert_lines(LINES, NEW_LINES, position_line,nLINES,final=True)
fid=open(outfile,'w')
fid.writelines(OUTLINES)
fid.close()

# gchem_readparms.F
filename="gchem_readparms.F"
infile=MITCODE + filename
outfile=MYCODE + filename

LINES=file2stringlist(infile)
nLINES=len(LINES)
for iline, line in enumerate(LINES):
    if line.find("NAMELIST /GCHEM_PARM01/") >-1: position_line=iline+1
NEW_LINES=[
"#ifdef ALLOW_BFMCOUPLER",   
"c                 useBFMcoupler must be read in namelist",
"     &           ,useBFMcoupler,",
"#endif"]
OUTLINES=insert_lines(LINES, NEW_LINES, position_line,nLINES)

LINES=OUTLINES
nLINES=len(LINES)
for iline, line in enumerate(LINES):
    if line.find("C Set defaults values for parameters in GCHEM.h") >-1: position_line=iline+1
NEW_LINES=[
"#ifdef ALLOW_BFMCOUPLER",
"       useBFMcoupler = .FALSE.",
"#endif"]
OUTLINES=insert_lines(LINES, NEW_LINES, position_line,nLINES)

LINES=OUTLINES
nLINES=len(LINES)
for iline, line in enumerate(LINES):
    if line.find("#endif /* ALLOW_GCHEM */")>-1: position_line=iline
NEW_LINES=[
"#ifdef ALLOW_BFMCOUPLER",
"      IF ( useBFMcoupler ) THEN",
"        CALL BFMcoupler_READPARMS(myThid)",
"      ENDIF",
"#endif /* ALLOW_BFMCOUPLER */"]     
OUTLINES=insert_lines(LINES, NEW_LINES, position_line,nLINES,final=True)

fid=open(outfile,'w')
fid.writelines(OUTLINES)
fid.close()


# gchem_calc_tendency.F
filename="gchem_calc_tendency.F"
infile=MITCODE + filename
outfile=MYCODE + filename

LINES=file2stringlist(infile)
nLINES=len(LINES)
for iline, line in enumerate(LINES):
    if line.find("# endif /* GCHEM_SEPARATE_FORCING */")>-1: position_line=iline
NEW_LINES=[
"C------------------------",
"C BFM coupler           |",
"C------------------------",
"#ifdef ALLOW_BFMCOUPLER",
"      IF ( useBFMcoupler ) THEN",
"C$taf loop = parallel",
"        DO bj=myByLo(myThid),myByHi(myThid)",
"        DO bi=myBxLo(myThid),myBxHi(myThid)",
"              ",
"        jMin=1",
"        jMax=sNy",
"        iMin=1",
"        iMax=sNx",
"C BFMcoupler operates on bi,bj part only, but needs to get full arrays i",
"C because of last index (iPtr)",
"         CALL BFMcoupler_calc_tendency(bi,bj,imin,imax,jmin,jmax,",
"     &                            myIter,myTime,myThid)",
"        ENDDO",
"        ENDDO",
"       ENDIF",
"#endif /* ALLOW_BFMCOUPLER */"]    
OUTLINES=insert_lines(LINES, NEW_LINES, position_line,nLINES,final=True)
fid=open(outfile,'w')
fid.writelines(OUTLINES)
fid.close()


# GCHEM.h
filename="GCHEM.h"
infile=MITCODE + filename
outfile=MYCODE + filename
LINES=file2stringlist(infile)
nLINES=len(LINES)
for iline, line in enumerate(LINES):
    if line.find("C     useDARWIN :: flag to turn on/off darwin pkg")>-1: position_line=iline+1
NEW_LINES=[
"#ifdef ALLOW_BFMCOUPLER",
"C     useBFMcoupler :: flag to turn on/off BFMcoupler pkg",
"#endif"]
OUTLINES=insert_lines(LINES, NEW_LINES, position_line,nLINES)
LINES=OUTLINES
nLINES=len(LINES)
for iline, line in enumerate(LINES):
    if line.find("     &              useDARWIN")>-1: position_line=iline
NEW_LINES=[
"#ifdef ALLOW_BFMCOUPLER",
"     &             ,useBFMcoupler",
"      LOGICAL useBFMcoupler",
"#endif"]
OUTLINES=insert_lines(LINES, NEW_LINES, position_line,nLINES,final=True)
fid=open(outfile,'w')
fid.writelines(OUTLINES)
fid.close()

# GCHEM_OPTIONS.h
filename="GCHEM_OPTIONS.h"
infile=MITCODE + filename
outfile=MYCODE + filename
LINES=file2stringlist(infile)
nLINES=len(LINES)
for iline, line in enumerate(LINES):
    if line.find("#endif /* ALLOW_GCHEM */")>-1: position_line=iline
NEW_LINES=[
"#undef GCHEM_SEPARATE_FORCING",
"c undefining gchem_separate_forcing actives BFMcoupler_calc_tendency and add_tendency",
"c  #define GCHEM_SEPARATE_FORCING"]    
OUTLINES=insert_lines(LINES, NEW_LINES, position_line,nLINES,final=True)
fid=open(outfile,'w')
fid.writelines(OUTLINES)
fid.close()    
    

##### applying differences in longstep Pkg
MITCODE="../MITgcm/pkg/longstep/"
# longstep_thermodynamics.F
filename="longstep_thermodynamics.F"
infile=MITCODE + filename
outfile=MYCODE + filename
LINES=file2stringlist(infile)
nLINES=len(LINES)
for iline, line in enumerate(LINES):
    if line.find("      IF ( LS_doTimeStep ) THEN")>-1: position_line=iline+1
NEW_LINES=[
"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc",
"c CGP 2015/04/03 adding call to gchem_calc_tendency",
"      CALL GCHEM_CALC_TENDENCY( myTime, myIter, myThid )",
"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc"]
OUTLINES=insert_lines(LINES, NEW_LINES, position_line,nLINES,final=True)
fid=open(outfile,'w')
fid.writelines(OUTLINES)
fid.close()    
    

##### applying differences in ptracer Pkg
MITCODE="../MITgcm/pkg/ptracers/"
# ptracers_reset.F
filename="ptracers_reset.F"
infile=MITCODE + filename
outfile=MYCODE + filename
LINES=file2stringlist(infile)
nLINES=len(LINES)
for iline, line in enumerate(LINES):
    if line.find("C     !INPUT PARAMETERS:")>-1: position_line=iline
NEW_LINES=[
"#ifdef ALLOW_GCHEM",
"#include " + "" + "GCHEM.h" + "",
"#endif"]  
OUTLINES=insert_lines(LINES, NEW_LINES, position_line,nLINES)
LINES=OUTLINES
nLINES=len(LINES)
for iline, line in enumerate(LINES):
    if line.find("     DO iTracer = 1, PTRACERS_num")>-1:position_line=iline+1 
NEW_LINES=[
"c check for negative values of pTracer variables and set them to 1._d-10",
"#ifdef ALLOW_GCHEM",
"      IF ( useGCHEM ) THEN|",
"#ifdef ALLOW_BFMCOUPLER",
"         IF (useBFMcoupler) THEN",
"           DO bj = myByLo(myThid), myByHi(myThid)",
"             DO bi = myBxLo(myThid), myBxHi(myThid)",
"               DO k=1,Nr",
"                 DO j=1-OLy,sNy+OLy",
"                   DO i=1-OLx,sNx+OLx",
"                     if (pTracer(i,j,k,bi,bj,iTracer).lt.0.0)THEN",
"                         pTracer(i,j,k,bi,bj,iTracer)=1. _d -10",
"                     ENDIF",
"                   ENDDO",
"                 ENDDO",
"               ENDDO",
"             ENDDO",
"           ENDDO",
"         ENDIF",
"#endif /* BFMCOUPLER */",
"      ENDIF",
"#endif /* ALLOW_GCHEM */ "]
OUTLINES=insert_lines(LINES, NEW_LINES, position_line,nLINES,final=True)
fid=open(outfile,'w')
fid.writelines(OUTLINES)
fid.close()    


    
    
    

















