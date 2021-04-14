# simply concatenate raw root measurements

cat Data/R1*A*csv Data/R4*A*csv Data/R6*A*csv | grep -v "root_name" > treatment-A.csv
cat Data/R1*B*csv Data/R4*B*csv Data/R6*B*csv | grep -v "root_name"  > treatment-B.csv
cat Data/R1*O*csv Data/R4*O*csv Data/R6*O*csv | grep -v "root_name"  > treatment-O.csv

cat Data/R2*A*csv Data/R3*A*csv Data/R5*A*csv | grep -v "root_name"  > control-A.csv
cat Data/R2*B*csv Data/R3*B*csv Data/R5*B*csv | grep -v "root_name"  > control-B.csv
cat Data/R2*O*csv Data/R3*O*csv Data/R5*O*csv | grep -v "root_name"  > control-O.csv

