import os
import argparse

def argument():
    parser = argparse.ArgumentParser(description = '''
   Writes:
   gchem_init_vari.F
   gchem_init_fixed.F
   gchem_fields_load.F
   gchem_readparms.F
   gchem_calc_tendency.F
   longstep_gchem_calc_tendency.F"
   GCHEM.h
   GCHEM_OPTIONS.h
   longstep_thermodynamics.F
   ptracers_reset.F
   GCHEM_FIELDS.H
   OBCS_OPTIONS.h
   DIAGNOSTIC_SIZE.h
   cg2d.F
   cg3d.F
   PTRACERS_SIZE.h
   RBCS_SIZE.h

   by reading from MITgcm code
'''
, formatter_class=argparse.RawTextHelpFormatter)


    parser.add_argument(   '--inputdir','-i',
                                type = str,
                                required = True,
                                help = '''namelist.passivetrc''')
    parser.add_argument(   '--outdir','-o',
                                type = str,
                                required = True,
                                help = '''path of the output dir''')
    parser.add_argument(   '--ntracers','-n',
                                type = str,
                                required = True,
                                help = '''number of specific site tracers''')

    return parser.parse_args()

args = argument()



def file2stringlist(filename):
    '''
    Argument : string - a path name indicating a text file
    Returns  : a list of strings

    A text file is converted in a list of strings, one for each row.

    '''
    LIST=[]
    filein=open(filename)
    for line in filein:
        LIST.append(line[:-1])
    filein.close()
    return LIST

def addsep(string):
    if string[-1] != os.sep:
        return string + os.sep
    else:
        return  string

def dumpfile(filename,string_list):
    outlines=[line + "\n" for line in string_list]
    with open(filename,'w') as fid:
        fid.writelines(outlines)
    print(filename)

def insert_lines(orig_lines,NEW_LINES,position_line):
    """
    Insert NEW_LINES in orig_lines after position_line
    """
    nLINES=len(orig_lines)
    OUTLINES=[]
    for iline in range(position_line):
        OUTLINES.append(orig_lines[iline])

    for line in NEW_LINES: OUTLINES.append(line)

    for iline in range(position_line,nLINES):
        OUTLINES.append(orig_lines[iline])
    return OUTLINES

def replace_lines(orig_lines, searchstring, new_lines):
    """
    Replaces searchstring with new_lines
    """
    assert len(orig_lines)>0
    assert isinstance(new_lines,list)
    OUTLINES=[]
    found=False
    for line in orig_lines:
        if line.find(searchstring) > -1 :
            found = True
            for dest_line in new_lines:
                OUTLINES.append(dest_line)
        else:
            OUTLINES.append(line)
    if not found :
        raise ValueError(searchstring + " Not found")
    return OUTLINES

def strings_and_position(filename, searchstring:str):
    LINES=file2stringlist(infile)
    for iline, line in enumerate(LINES):
        if line.find(searchstring) >-1:
            position_line=iline
            break
    else:
        raise ValueError(f"{searchstring} not found in {filename}")
    return LINES, position_line

def get_position_on_strings(string_list, searchstring:str) -> int:
    for iline, line in enumerate(string_list):
        if line.find(searchstring) >-1: position_line=iline
    return position_line


print("")
print("----------   Applying patch   -------------------")

INPUTDIR=addsep(args.inputdir)
OUTDIR=addsep(args.outdir)
MITCODE=INPUTDIR + "pkg/gchem/"
MYCODE=OUTDIR


filename="gchem_init_vari.F"
infile=MITCODE + filename
outfile=MYCODE + filename

LINES, position_line = strings_and_position(infile, "C !LOCAL VARIABLES")
LINES, position_line = strings_and_position(infile, "Initialise GCHEM variables:")
   
NEW_LINES=[
"#ifdef ALLOW_BFMCOUPLER",
"#include \"BFMcoupler_OPTIONS.h\"",
"#endif"]
OUTLINES=insert_lines(LINES, NEW_LINES, position_line)

LINES=OUTLINES
position_line=get_position_on_strings(LINES, "ifdef GCHEM_ADD2TR_TENDENCY")
NEW_LINES=[
"#ifdef ALLOW_BFMCOUPLER",
"      IF ( useBFMcoupler) THEN",
"         CALL BFMcoupler_INI_FORCING(myThid)",
"      ENDIF",
"#endif"]
OUTLINES=insert_lines(LINES, NEW_LINES, position_line-1)
dumpfile(outfile, OUTLINES)



filename="gchem_init_fixed.F"
infile=MITCODE + filename
outfile=MYCODE + filename
LINES, position_line = strings_and_position(infile, "#ifdef ALLOW_DIAGNOSTICS")

NEW_LINES=[
"#ifdef ALLOW_BFMCOUPLER",
"         call BFMcoupler_INIT_FIXED(myThid)",
"#endif"]
OUTLINES=insert_lines(LINES, NEW_LINES, position_line)
dumpfile(outfile, OUTLINES)



filename="gchem_fields_load.F"
infile=MITCODE + filename
outfile=MYCODE + filename
LINES, position_line = strings_and_position(infile, "#endif /* ALLOW_GCHEM */")

NEW_LINES=[
"#ifdef ALLOW_BFMCOUPLER",
"      IF ( useBFMcoupler ) THEN",
"       CALl BFMcoupler_FIELDS_LOAD(myIter,myTime,myThid)",
"      ENDIF",
"#endif /* ALLOW_BFMCOUPLER */"]
OUTLINES=insert_lines(LINES, NEW_LINES, position_line)
dumpfile(outfile, OUTLINES)



filename="gchem_readparms.F"
infile=MITCODE + filename
outfile=MYCODE + filename

LINES, position_line = strings_and_position(infile,"C- Set defaults values for parameters in GCHEM.h")
LINES, position_line = strings_and_position(infile,"#endif /* ALLOW_GCHEM */")
LINES, position_line = strings_and_position(infile,"NAMELIST /GCHEM_PARM01/")

NEW_LINES=[
"#ifdef ALLOW_BFMCOUPLER",   
"c                 useBFMcoupler must be read in namelist",
"     &            useBFMcoupler,",
"#endif"]
OUTLINES=insert_lines(LINES, NEW_LINES, position_line+1)

LINES=OUTLINES
position_line = get_position_on_strings(LINES, "C- Set defaults values for parameters in GCHEM.h")

NEW_LINES=[
"#ifdef ALLOW_BFMCOUPLER",
"       useBFMcoupler = .FALSE.",
"#endif"]
OUTLINES=insert_lines(LINES, NEW_LINES, position_line+1)

LINES=OUTLINES
position_line = get_position_on_strings(LINES, "#endif /* ALLOW_GCHEM */")

NEW_LINES=[
"#ifdef ALLOW_BFMCOUPLER",
"      IF ( useBFMcoupler ) THEN",
"        CALL BFMcoupler_READPARMS(myThid)",
"      ENDIF",
"#endif /* ALLOW_BFMCOUPLER */"]     
OUTLINES=insert_lines(LINES, NEW_LINES, position_line)
dumpfile(outfile,OUTLINES)



filename="gchem_calc_tendency.F"
infile=MITCODE + filename
outfile=MYCODE + filename
LINES, position_line = strings_and_position(infile, "C !LOCAL VARIABLES")
LINES, position_line = strings_and_position(infile, "#ifdef ALLOW_AUTODIFF")

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
"#endif /* ALLOW_BFMCOUPLER */",
"#endif /* ALLOW_LONGSTEP */"]


OUTLINES=insert_lines(LINES, NEW_LINES, position_line)
LINES=OUTLINES
position_line = get_position_on_strings(LINES, "C !LOCAL VARIABLES")

NEW_LINES=["# ifndef ALLOW_LONGSTEP"]

OUTLINES=insert_lines(LINES, NEW_LINES, position_line-1)
dumpfile(outfile, OUTLINES)



outfile=MYCODE + 'longstep_gchem_calc_tendency.F'
LINES=OUTLINES # we'll apply changes from gchem_calc_tendency.F


l0="C !ROUTINE: GCHEM_CALC_TENDENCY"
l1="C !ROUTINE: LONGSTEP_GCHEM_CALC_TENDENCY"
OUTLINES = replace_lines(OUTLINES,l0,[l1] )


l0= "      SUBROUTINE GCHEM_CALC_TENDENCY("
l1 = ["C version of GCHEM_CALC_TENDENCY called by LONGSTEP package",
 "      SUBROUTINE LONGSTEP_GCHEM_CALC_TENDENCY("]
OUTLINES = replace_lines(OUTLINES,l0, l1 )

l0 = "# ifndef ALLOW_LONGSTEP"
l1 = "# ifdef ALLOW_LONGSTEP"
OUTLINES = replace_lines(OUTLINES,l0,[l1] )
dumpfile(outfile, OUTLINES)






filename="GCHEM.h"
infile=MITCODE + filename
outfile=MYCODE + filename
LINES, position_line = strings_and_position(infile,"     &              useDARWIN")
LINES, position_line = strings_and_position(infile, "C     useDARWIN :: flag to turn on/off darwin pkg")

NEW_LINES=[
"#ifdef ALLOW_BFMCOUPLER",
"C     useBFMcoupler :: flag to turn on/off BFMcoupler pkg",
"#endif"]
OUTLINES=insert_lines(LINES, NEW_LINES, position_line+1)
LINES=OUTLINES
position_line = get_position_on_strings(LINES, "     &              useDARWIN")

NEW_LINES=[
"#ifdef ALLOW_BFMCOUPLER",
"     &              ,useBFMcoupler",
"      LOGICAL useBFMcoupler",
"#endif"]
OUTLINES=insert_lines(LINES, NEW_LINES, position_line+1)
dumpfile(outfile, OUTLINES)


filename="GCHEM_OPTIONS.h"
infile=MITCODE + filename
outfile=MYCODE + filename

LINES, position_line = strings_and_position(infile, "#endif /* ALLOW_GCHEM */")
NEW_LINES=[
"#undef GCHEM_SEPARATE_FORCING",
"c undefining gchem_separate_forcing actives BFMcoupler_calc_tendency and add_tendency",
"c  #define GCHEM_SEPARATE_FORCING"]    
LINES=insert_lines(LINES, NEW_LINES, position_line)
LINES = replace_lines(LINES, "#undef GCHEM_ADD2TR_TENDENCY", ["#define GCHEM_ADD2TR_TENDENCY"])
OUTLINES = insert_lines(LINES,"",0)
dumpfile(outfile, OUTLINES)
    

##### applying differences in longstep Pkg
MITCODE=INPUTDIR + "pkg/longstep/"
filename="longstep_thermodynamics.F"
infile=MITCODE + filename
outfile=MYCODE + filename
LINES, position_line = strings_and_position(infile, "      IF ( LS_doTimeStep ) THEN")

NEW_LINES=[
"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc",
"c CGP 2015/04/03 adding call to gchem_calc_tendency",
"      CALL LONGSTEP_GCHEM_CALC_TENDENCY( myTime, myIter, myThid )",
"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc"]
OUTLINES=insert_lines(LINES, NEW_LINES, position_line)
dumpfile(outfile, OUTLINES)
    

##### applying differences in ptracer Pkg
MITCODE=INPUTDIR + "pkg/ptracers/"
filename="ptracers_reset.F"
infile=MITCODE + filename
outfile=MYCODE + filename
LINES, position_line = strings_and_position(infile,"     DO iTracer = 1, PTRACERS_num")
LINES, position_line = strings_and_position(infile, "C     !INPUT PARAMETERS:")

NEW_LINES=[
"#ifdef ALLOW_GCHEM",
"#include \"GCHEM.h\"",
"#endif"]  
OUTLINES=insert_lines(LINES, NEW_LINES, position_line)
LINES=OUTLINES
position_line = get_position_on_strings(LINES, "     DO iTracer = 1, PTRACERS_num")

NEW_LINES=[
"c check for negative values of pTracer variables and set them to 1._d-10",
"#ifdef ALLOW_GCHEM",
"      IF ( useGCHEM ) THEN",
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
OUTLINES=insert_lines(LINES, NEW_LINES, position_line+1)
dumpfile(outfile, OUTLINES)


MITCODE=INPUTDIR + "pkg/gchem/"
filename="GCHEM_FIELDS.h"
infile=MITCODE + filename
outfile=MYCODE + filename

LINES, position_line = strings_and_position(infile, "#endif /* GCHEM_ADD2TR_TENDENCY */")
NEW_LINES=["#ifdef GCHEM_SEPARATE_FORCING",
"      _RL gchemTendency(1-OLx:sNx+OLx,1-OLy:sNy+OLy,Nr,nSx,nSy,",
"     &                  PTRACERS_num)",
"      COMMON /GCHEM_FIELDS/",
"     &     gchemTendency",
"#endif /* when define GCHEM_SEPARATE_FORCING */"]
OUTLINES=insert_lines(LINES, NEW_LINES, position_line)
dumpfile(outfile, OUTLINES)


MITCODE=INPUTDIR + "pkg/obcs/"
filename="OBCS_OPTIONS.h"
infile=MITCODE + filename
outfile=MYCODE + filename
LINES, position_line = strings_and_position(infile, "#define ALLOW_ORLANSKI")
LINES, position_line = strings_and_position(infile, "#undef ALLOW_OBCS_SPONGE")
LINES, position_line = strings_and_position(infile, "#undef ALLOW_OBCS_TIDES")

LINES = replace_lines(LINES, "#define ALLOW_ORLANSKI", ["#undef ALLOW_ORLANSKI"])
LINES = replace_lines(LINES, "#undef ALLOW_OBCS_SPONGE", ["#define ALLOW_OBCS_SPONGE"])
OUTLINES = replace_lines(LINES,"#undef ALLOW_OBCS_TIDES", ["#define ALLOW_OBCS_TIDES"])
dumpfile(outfile, OUTLINES)



MITCODE=INPUTDIR + "pkg/diagnostics/"
filename="DIAGNOSTICS_SIZE.h"
infile=MITCODE + filename
outfile=MYCODE + filename
LINES, position_line = strings_and_position(infile, "PARAMETER( ndiagMax = 500 )")
longstr_src  = "PARAMETER( numlists = 10, numperlist = 50, numLevels=2*Nr )"
longstr_dest = "       PARAMETER( numlists = 150, numperlist = 150, numLevels=2*Nr )"
LINES, position_line = strings_and_position(infile, longstr_src)
LINES, position_line = strings_and_position(infile, "PARAMETER( numDiags = 1*Nr )")
LINES, position_line = strings_and_position(infile, "PARAMETER( diagSt_size = 10*Nr )")

LINES = replace_lines(LINES, "PARAMETER( ndiagMax = 500 )", ["       PARAMETER( ndiagMax = 1500 )"])
LINES = replace_lines(LINES, longstr_src, [longstr_dest])
LINES = replace_lines(LINES,"PARAMETER( numDiags = 1*Nr )", ["       PARAMETER( numDiags = 150*Nr )"])
OUTLINES = replace_lines(LINES,"PARAMETER( diagSt_size = 10*Nr )", ["       PARAMETER( diagSt_size = 150*Nr )"])
dumpfile(outfile, OUTLINES)


MITCODE=INPUTDIR + "model/src/"
filename="cg2d.F"
infile=MITCODE + filename
outfile=MYCODE + filename
LINES, position_line = strings_and_position(infile,"WRITE(standardmessageunit")
LINES=replace_lines(LINES,"WRITE(standardmessageunit",["C"])
LINES=replace_lines(LINES," cg2d: Sum(rhs),rhsMax = ",["C"])
dumpfile(outfile,LINES)
filename="cg3d.F"
infile=MITCODE + filename
outfile=MYCODE + filename
LINES, position_line = strings_and_position(infile,"WRITE(standardmessageunit")
LINES = replace_lines(LINES,"WRITE(standardmessageunit",["C"])
LINES = replace_lines(LINES," cg3d: Sum(rhs),rhsMax = ",["C"])
dumpfile(outfile,LINES)

MITCODE = INPUTDIR + "pkg/ptracers/"
filename="PTRACERS_SIZE.h"
infile=MITCODE + filename
outfile=MYCODE + filename
LINES, position_line = strings_and_position(infile, "PARAMETER(PTRACERS_num = 1 )")
Specific_site_tracers = int(args.ntracers)
newstr=f"      PARAMETER(PTRACERS_num = {51 + Specific_site_tracers} )"
LINES = replace_lines(LINES,"PARAMETER(PTRACERS_num = 1 )", [newstr])
dumpfile(outfile,LINES)

MITCODE = INPUTDIR + "pkg/rbcs/"
filename="RBCS_SIZE.h"
infile=MITCODE + filename
outfile=MYCODE + filename
LINES, position_line = strings_and_position(infile, "PARAMETER( maskLEN = 3 )")
LINES = replace_lines(LINES, "PARAMETER( maskLEN = 3 )" ,["       PARAMETER( maskLEN = 53 )"] )
dumpfile(outfile,LINES)

MITCODE = INPUTDIR + "model/inc/"
filename="CPP_OPTIONS.h"
infile=MITCODE + filename
outfile=MYCODE + filename
infile=MITCODE + filename
LINES, position_line = strings_and_position(infile,"#undef SHORTWAVE_HEATING")

LINES = replace_lines(LINES,"#undef SHORTWAVE_HEATING", ["#define SHORTWAVE_HEATING"])
LINES = replace_lines(LINES,"#undef ALLOW_3D_DIFFKR", ["#define ALLOW_3D_DIFFKR"])
LINES = replace_lines(LINES,"#undef ALLOW_ADAMSBASHFORTH_3", ["#define ALLOW_ADAMSBASHFORTH_3"])
LINES = replace_lines(LINES,"#undef ALLOW_NONHYDROSTATIC", ["#define ALLOW_NONHYDROSTATIC"])
LINES = replace_lines(LINES,"#undef ALLOW_FRICTION_HEATING", ["#define ALLOW_FRICTION_HEATING"])
LINES = replace_lines(LINES,"#undef ALLOW_ADDFLUID", ["#define ALLOW_ADDFLUID"])
LINES = replace_lines(LINES,"#undef EXCLUDE_FFIELDS_LOAD", ["#define EXCLUDE_FFIELDS_LOAD"])
LINES = replace_lines(LINES,"#define ALLOW_SRCG", ["#undef ALLOW_SRCG"])
dumpfile(outfile,LINES)


print("-------------------------------------------------")
print("")


