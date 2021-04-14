# extract volume/production data from raw csv file

awk 'BEGIN{
  # set up file separator and date format
  n=0;
  FS=",";
  initref = mktime("2017 03 17 00 00 00");
}
{
  if(n++ > 0 && $8 < (365/4))
  {
    # avoid header row, and samples for which more than half a year gap exists between measurements
    # add volume observation to pool labelled by array and quarter
    quarter = int($7/(365/4));
    production[$2][quarter] += $17;
  }
}
END{
  # output pool
  for(i = 1; i <= 6; i++)
  {
    for(j in production[i])
    {
      # the *343 gives our mean biomass estimate (343 mg dw cm-3)
      printf("%i %i %f %f\n", i, j+1, production[i][j]*343, production[i][j]);
    }
  }
}' Data/Supplementary_data_3-Production-update.csv > production.txt
    
  
