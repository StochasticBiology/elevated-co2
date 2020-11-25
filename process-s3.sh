awk 'BEGIN{
  n=0;
  FS=",";
  initref = mktime("2017 03 17 00 00 00");
}
{
  if(n++ > 0 && $8 < (365/4))
  {
    quarter = int($7/(365/4));
    production[$2][quarter] += $17;
  }
}
END{
  for(i = 1; i <= 6; i++)
  {
    for(j in production[i])
    {
      printf("%i %i %f\n", i, j+1, production[i][j]);
    }
  }
}' Data/Supplementary_data_3-Production-update.csv > production.txt
    
  
