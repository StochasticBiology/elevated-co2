awk 'BEGIN{
  FS=",";
  initref = mktime("2017 04 11 00 00 00");
}
{
  split($6, datearr, "/");
  datestr = sprintf("%i %i %i 00 00 00", datearr[3], datearr[2], datearr[1]);
  dateref = (mktime(datestr)-initref)/(3600*24);
  biomass[$3][$4][dateref] += $9;
  rlength[$3][$4][dateref] += $7;
  volume[$3][$4][dateref] += (3.14159*$7*($8/2.)**2);
}
END{
  printf("Time\tLength\tVolume\tMass\tInitial_mass\tInitial_mass\n");
  for(i = 1; i <= 6; i++)
  {
    if(i == 2 || i == 3 || i == 5)
    {
      meanstart = 0;
      for(j = 1; j <= 4; j++)
      {
        meanstart += biomass[i][j][0];
      }
      meanstart /= 4;
      for(j = 1; j <= 4; j++)
      {
        for(k in biomass[i][j])
        {
          if(biomass[i][j][k] != 0)
          {
            printf("%.0f\t%f\t%f\t%f\t%f\t%f\n", k, rlength[i][j][k], volume[i][j][k], biomass[i][j][k], meanstart, meanstart);
          }
        }
      }
    }
  }
}' Data/Supplementary_data_1-Root_lengths.csv | awk 'NR == 1; NR > 1 {print $0 | "sort -n -k1,1"}' > Biomass_per_rhizo_control.txt

awk 'BEGIN{
  FS=",";
  initref = mktime("2017 04 11 00 00 00");
}
{
  split($6, datearr, "/");
  datestr = sprintf("%i %i %i 00 00 00", datearr[3], datearr[2], datearr[1]);
  dateref = (mktime(datestr)-initref)/(3600*24);
  biomass[$3][$4][dateref] += $9;
  rlength[$3][$4][dateref] += $7;
  volume[$3][$4][dateref] += (3.14159*$7*($8/2.)**2);
}
END{
  printf("Time\tLength\tVolume\tMass\tInitial_mass\tInitial_mass\n");
  for(i = 1; i <= 6; i++)
  {
    if(i == 1 || i == 4 || i == 6)
    {
      meanstart = 0;
      for(j = 1; j <= 4; j++)
      {
        meanstart += biomass[i][j][0];
      }
      meanstart /= 4;
      for(j = 1; j <= 4; j++)
      {
        for(k in biomass[i][j])
        {
          if(biomass[i][j][k] != 0)
          {
            printf("%.0f\t%f\t%f\t%f\t%f\t%f\n", k, rlength[i][j][k], volume[i][j][k], biomass[i][j][k], meanstart, meanstart);
          }
        }
      }
    }
  }
}' Data/Supplementary_data_1-Root_lengths.csv | awk 'NR == 1; NR > 1 {print $0 | "sort -n -k1,1"}' > Biomass_per_rhizo_treatment.txt

awk 'BEGIN{n=0;}{if(n++ > 0 && $1 < 365) print "eCO2", $1, $5, $4;}' Biomass_per_rhizo_treatment.txt > roots-bid-data.txt
awk 'BEGIN{n=0;}{if(n++ > 0 && $1 < 365) print "Control", $1, $5, $4;}' Biomass_per_rhizo_control.txt >> roots-bid-data.txt

awk 'BEGIN{
  n = 0;
  FS=",";
  initref = mktime("2017 04 11 00 00 00");
}
{
  if(n++ > 0)
  {
    split($6, datearr, "/");
    datestr = sprintf("%i %i %i 00 00 00", datearr[3], datearr[2], datearr[1]);
    dateref = (mktime(datestr)-initref)/(3600*24);
    print $3, dateref, $8;
  }
}' Data/Supplementary_data_1-Root_lengths.csv > root-widths.txt
