if [[ -z $1 || -z $2 ]] ;
then
	echo "required args: <fasta> <k>" 
	exit
fi

F=$1
# K=31
BASEDIR=$(dirname $(realpath $0))
for K in $2
do
   
	### FOR DOUBLE DIRECTED
	jellyfish count -m $K -s 100M -t 10 $F
	jellyfish dump -c mer_counts.jf > mer_counts_dumps.fa
    cat mer_counts_dumps.fa | cut -f 1 -d" " |  awk '{print $0" 1"}'  > dbg_fwd.txt
    echo "$(cat dbg_fwd.txt | wc -l)" > n_mer$K

    malfoybcalm  dbg_fwd.txt dbg$K.txt 50

    cat dbg$K.txt | tr a A | tr c C | tr g G | tr t T | tr -d \; > unid$K.sset
    
    
    $BASEDIR/sset_to_fa.sh unid$K.sset > uni_directed.fa

	
done


rm unid$K.sset
rm mer_counts.jf 
rm mer_counts_dumps.fa 
rm largest_bucket.dot 
rm dbg_fwd.txt 
rm dbg_bwd.txt
rm dbg_both.txt  
rm dbg$K.txt 

