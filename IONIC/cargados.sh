q=$1 #charge of molecule
CA=$2 #CHARGED ATOMS

for file in *.xyz
do
#eliminate fist two lines in .xyz
gsed -i '1d' $file
gsed -i '1d' $file
done


for file in *.xyz

do

#mst opt in n-oct
echo "%nproc=4"> $file.mst.oct
echo "%Chk=$file.mst.oct.chk">> $file.mst.oct
echo "%mem=800MB">> $file.mst.oct
echo "#p b3lyp/6-31G(d) opt=(MaxStep=10,MaxCycles=1000) freq scf=(MaxCycle=2000,NoVarAcc,NoIncFock) scrf=(iefpcm,read,solvent=n-octanol)">> $file.mst.oct
echo "" >> $file.mst.oct
echo "$file" >> $file.mst.oct
echo "" >> $file.mst.oct
echo "$q 1" >> $file.mst.oct

cat $file.mst.oct $file > $file.mst.oct.gau
echo "" >> $file.mst.oct.gau
echo "MSTModel=DFT cav MSTcharged" >> $file.mst.oct.gau
echo "" >> $file.mst.oct.gau
echo "$CA" >> $file.mst.oct.gau
echo "" >> $file.mst.oct.gau

#single point
echo "--Link1--" >> $file.mst.oct.gau
echo "%nproc=4">> $file.mst.oct.gau
echo "%Chk=$file.mst.oct.chk">> $file.mst.oct.gau
echo "%mem=800MB">> $file.mst.oct.gau
echo "#p b3lyp/6-31G(d) geom=allcheck guess=read">> $file.mst.oct.gau
echo "" >> $file.mst.wat.gau
#solv in n-oct
echo "--Link1--" >> $file.mst.oct.gau
echo "%nproc=4">> $file.mst.oct.gau
echo "%Chk=$file.mst.oct.chk">> $file.mst.oct.gau
echo "%mem=800MB">> $file.mst.oct.gau
echo "#p b3lyp/6-31G(d) scrf=(iefpcm,read,solvent=n-octanol) geom=allcheck guess=read" >> $file.mst.oct.gau
echo "" >> $file.mst.oct.gau
echo "MSTModel=DFT cav g03defaults OFac=0.8 Rmin=0.3 MSTcharged" >> $file.mst.oct.gau
echo "" >> $file.mst.oct.gau
echo "$CA" >> $file.mst.oct.gau
echo "" >> $file.mst.oct.gau

done



for file in *.xyz

do

#mst opt in water
echo "%nproc=4"> $file.mst.wat
echo "%Chk=$file.mst.wat.chk">> $file.mst.wat
echo "%mem=800MB">> $file.mst.wat
echo "#p b3lyp/6-31G(d) opt=(MaxStep=10,MaxCycles=1000) freq scf=(MaxCycle=2000,NoVarAcc,NoIncFock) scrf=(iefpcm,read,solvent=water)">> $file.mst.wat
echo "" >> $file.mst.wat
echo "$file" >> $file.mst.wat
echo "" >> $file.mst.wat
echo "$q 1" >> $file.mst.wat

cat $file.mst.wat $file > $file.mst.wat.gau
echo "" >> $file.mst.wat.gau
echo "MSTModel=DFT cav MSTcharged" >> $file.mst.wat.gau
echo "" >> $file.mst.wat.gau
echo "$CA" >> $file.mst.wat.gau
echo "" >> $file.mst.wat.gau

#single point
echo "--Link1--" >> $file.mst.wat.gau
echo "%nproc=4">> $file.mst.wat.gau
echo "%Chk=$file.mst.wat.chk">> $file.mst.wat.gau
echo "%mem=800MB">> $file.mst.wat.gau
echo "#p b3lyp/6-31G(d) geom=allcheck guess=read">> $file.mst.wat.gau
echo "" >> $file.mst.wat.gau
#solv in water
echo "--Link1--" >> $file.mst.wat.gau
echo "%nproc=4">> $file.mst.wat.gau
echo "%Chk=$file.mst.wat.chk">> $file.mst.wat.gau
echo "%mem=800MB">> $file.mst.wat.gau
echo "#p b3lyp/6-31G(d) scrf=(iefpcm,read,solvent=water) geom=allcheck guess=read" >> $file.mst.wat.gau
echo "" >> $file.mst.wat.gau
echo "MSTModel=DFT cav g03defaults OFac=0.8 Rmin=0.3 MSTcharged" >> $file.mst.wat.gau
echo "" >> $file.mst.wat.gau
echo "$CA" >> $file.mst.wat.gau
echo "" >> $file.mst.wat.gau

done

