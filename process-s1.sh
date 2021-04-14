# this script takes the raw data on fine root volume measured from minirhizotrons (individual root segments) and pools these to labelled observations per tube for each date

awk 'BEGIN{
  # set up separator and date structure
  FS=",";
  initref = mktime("2017 04 11 00 00 00");
  n = 0;
}
{
  if(n > 0)
  {
    # for anything other than first header line
    split($6, datearr, "/");
    # extract date in days since start
    datestr = sprintf("%i %i %i 00 00 00", datearr[3], datearr[2], datearr[1]);
    dateref = (mktime(datestr)-initref)/(3600*24);
    # extract key features and add to array element labelled by array, tube, date
    # "biomass" is redundant; calculations are now in R
    biomass[$3][$4][dateref] += $9*1000;
    rlength[$3][$4][dateref] += $7;
    volume[$3][$4][dateref] += $9*1000;
  }
  n++;
}
END{
  # now output the array-tube-date labelled pooled data
  printf("Time\tLength\tVolume_redundant\tVolume\tInitial_mean_volume_redundant\tInitial_mean_volume\n");
  # loop through arrays
  for(i = 1; i <= 6; i++)
  {
    if(i == 2 || i == 3 || i == 5)
    {
      # control arrays (eCO2 below)
      meanstart = 0;
      # loop through tubes and build up initial volume for the array (t=0)
      for(j = 1; j <= 4; j++)
      {
        meanstart += biomass[i][j][0];
      }
      meanstart /= 4;
      # loop through tubes 
      for(j = 1; j <= 4; j++)
      {
        # loop through individual date measurements in this tube
        for(k in biomass[i][j])
        {
          if(biomass[i][j][k] != 0)
          {
            # output this pooled date measurement
            printf("%.0f\t%f\t%f\t%f\t%f\t%f\n", k, rlength[i][j][k], volume[i][j][k], biomass[i][j][k], meanstart, meanstart);
          }
        }
      }
    }
  }
}' Data/Supplementary_data_1-Root_lengths.csv | awk 'NR == 1; NR > 1 {print $0 | "sort -n -k1,1"}' > Biomass_per_rhizo_control.txt

awk 'BEGIN{
  # set up separator and date structure
  FS=",";
  initref = mktime("2017 04 11 00 00 00");
  n = 0;
}
{
  if(n > 0)
  {
    # for anything other than first header line
    split($6, datearr, "/");
    # extract date in days since start
    datestr = sprintf("%i %i %i 00 00 00", datearr[3], datearr[2], datearr[1]);
    dateref = (mktime(datestr)-initref)/(3600*24);
    # extract key features and add to array element labelled by array, tube, date
    # "biomass" is redundant; calculations are now in R
    biomass[$3][$4][dateref] += $9*1000;
    rlength[$3][$4][dateref] += $7;
    volume[$3][$4][dateref] += $9*1000;
  }
  n++;
}
END{
  # now output the array-tube-date labelled pooled data
  printf("Time\tLength\tVolume_redundant\tVolume\tInitial_mean_volume_redundant\tInitial_mean_volume\n");
  # loop through arrays
  for(i = 1; i <= 6; i++)
  {
    if(i == 1 || i == 4 || i == 6)
    {
      # eCO2 arrays (control above)
      meanstart = 0;
      # loop through tubes and build up initial volume for the array (t=0)
      for(j = 1; j <= 4; j++)
      {
        meanstart += biomass[i][j][0];
      }
      meanstart /= 4;
      # loop through tubes 
      for(j = 1; j <= 4; j++)
      {
        # loop through individual date measurements in this tube
        for(k in biomass[i][j])
        {
          if(biomass[i][j][k] != 0)
          {
            # output this pooled date measurement
            printf("%.0f\t%f\t%f\t%f\t%f\t%f\n", k, rlength[i][j][k], volume[i][j][k], biomass[i][j][k], meanstart, meanstart);
          }
        }
      }
    }
  }
}' Data/Supplementary_data_1-Root_lengths.csv | awk 'NR == 1; NR > 1 {print $0 | "sort -n -k1,1"}' > Biomass_per_rhizo_treatment.txt

# pool these outputs into an overall dataset
awk 'BEGIN{n=0;}{if(n++ > 0) print "eCO2", $1, $5, $4;}' Biomass_per_rhizo_treatment.txt > roots-bid-data.txt
awk 'BEGIN{n=0;}{if(n++ > 0) print "Control", $1, $5, $4;}' Biomass_per_rhizo_control.txt >> roots-bid-data.txt

# extract widths following the same process as above
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
