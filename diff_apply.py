from commons.utils import file2stringlist
import os

INCLUDE_LINES=[
"#ifdef ALLOW_BFMCOUPLER",
"#include \"BFMcoupler_OPTIONS.h\"",
"#endif"]

CALL_LINES=[
"#ifdef ALLOW_BFMCOUPLER",
"      IF ( useBFMcoupler) THEN",
"         CALL BFMcoupler_INI_FORCING(myThid)",
"      ENDIF",
"#endif"]

def insert_lines(orig_lines,INCLUDE_LINES, CALL_LINES, interface_line,end_line):
    OUTLINES=[]
    for iline in range(interface_line):
        OUTLINES.append(orig_lines[iline])

    for line in INCLUDE_LINES: OUTLINES.append(line)
    for iline in range(interface_line,end_line):
        OUTLINES.append(orig_lines[iline])

    for line in CALL_LINES: OUTLINES.append(line)
    for iline in range(end_line,nLINES):
        OUTLINES.append(orig_lines[iline])

    OUTLINES=[line + "\n" for line in OUTLINES]
    return OUTLINES

filename="gchem_init_vari.F"
outfile ="gchem_init_vari.F_new"
PKG=os.path.basename(filename).rsplit("_")[0].upper()
end_string="#endif /* ALLOW_%s */" %PKG

LINES=file2stringlist(filename)

nLINES=len(LINES)

for iline, line in enumerate(LINES):
    if line.find("INTERFACE: ==") >-1: interface_line=iline
    if line.find(end_string)>-1: end_line=iline
        
OUTLINES=insert_lines(LINES, INCLUDE_LINES, CALL_LINES, interface_line, end_line)

fid=open(outfile,'w')
fid.writelines(OUTLINES)
fid.close()


