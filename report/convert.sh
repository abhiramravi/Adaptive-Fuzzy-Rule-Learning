for file in *
do 
   convert -density 130 -antialias -colors 128 -background white -normalize -units PixelsPerInch -quality 100 $file $file.jpg
done
