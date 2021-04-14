# this script pulls date-array-total live-total dead-total root weight data from the raw csv sheet

awk 'BEGIN{
  # set up file separator and date format
  n=0;
  FS=",";
  initref = mktime("2017 03 17 00 00 00");
}
{
  if(n++ > 0)
  {
    # for all except the first header line
    # extract date in days from start
    split($1, datearr, "/");
    datestr = sprintf("%i %i %i 00 00 00", datearr[3], datearr[2], datearr[1]);
    dateref = (mktime(datestr)-initref)/(3600*24);

    # pull live and dead mass and add to total for this array
    totallive[$3][$4][dateref] += $6;
    totaldead[$3][$4][dateref] += $7;
  }
}END{
  # output the stored data
  printf("Date\tArray Number\tTotal Live\tTotal Dead\tTotal\n");
  # loop through arrays
  for(i = 1; i <= 9; i++)
  {
    # loop through tubes and dates
    for(j in totallive[i])
    {
      for(k in totallive[i][j])
      {
        if(totallive[i][j][k] != 0 && totaldead[i][j][k] != 0)
        {
          printf("%i\t%i\t%i\t%i\t%i\n", k, i, totallive[i][j][k], totaldead[i][j][k], totallive[i][j][k]+totaldead[i][j][k]);
        }
      }
    }
  }
}' Data/Supplementary_data_2-Soil_cores.csv  | awk 'NR == 1; NR > 1 {print $0 | "sort -n -k1,1"}' | sed 's/\t/,/g' > core-weights.csv

# do the same but remembering horizon label
awk 'BEGIN{
  n=0;
  FS=",";
  initref = mktime("2017 03 17 00 00 00");
  printf("Time\tArray Number\tSoil horizon\tLive weight (mg)\tDead weight (mg)\n");
}
{ 
  if(n++ > 0)
  {
    split($1, datearr, "/");
    datestr = sprintf("%i %i %i 00 00 00", datearr[3], datearr[2], datearr[1]);
    dateref = (mktime(datestr)-initref)/(3600*24);
    printf("%i\t%i\t%s\t%i\t%i\n", dateref, $3, $5, $6, $7);
  }
}' Data/Supplementary_data_2-Soil_cores.csv > core-by-horizon.txt
