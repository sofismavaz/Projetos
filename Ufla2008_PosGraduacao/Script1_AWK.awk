#/bin/awk -f

#
BEGIN {
  FS=" "
  OFS="\t"
  DIA=`date +"%d"`
  print $DIA
  # printf "%15s %10s %9s\n", "User login", "horario\n", 
  printf "%10s\n", "User login", "horario", "==================================================\n"
  }
{ 
# print $DIA
print $1, $7, $8, $9, $DIA
if ($6 == $DIA) {
  printf $1 "\t\t" $8 $9 "\n"
  }
}