#INIZIALIZZAZIONE VARIABILI
#cd gr*
#cd inp*
#cd inp.5
declare -i totale=0

declare -x f		   	   #PERMESSI 
declare -x x        	   #PERMESSI IN OTTALE
declare -i b    	       #CONTATORE PER VEDERE SE CI SONO L E H INSIEME
			   #PERMESSI IN OTTALE
declare -x l=f
declare -x h=f
declare -x s=f
declare -x S=f
declare -x e=f
declare -x earg
declare -x Sarg
declare -x sarg
                   #file dove avremo il risultato di ls
         #lista con tutti i path

declare -A da_ignorare_cont


#DEFINIZIONE FUNZIONI
declare -A vocinode2
function calcolo() {
	declare -i finale=0
	declare -i parziale=0
	parziale=0
	
	declare -i inode
	touch inutile
	declare -x filematch=""
	declare -a array_dopo_s
	declare -a array_dopo_S
	declare -i j
	declare -x stringa
	j=0
	declare -i temporaneo
	declare -x bool3
	if [ $e == "t" ]; then
		touch goku 
		touch per_e
		for (( i=0 ; i < ${#listafiles[@]} ; i++)); do              #mi prendo solo i file che fanno match con e
		    filee=${listafiles[$i]}
		    if [ ! -d $filee ]; then
				boolean=f
				stat -c %s $filee >inutile
				read temporaneo <inutile
				((temporaneo=$temporaneo%4))
				if [ $temporaneo -ne 0 ]; then
					for((j=0; j<($temporaneo); j++)); do
						filematch=$filematch"0"
					done
					xxd -p -c 100000 $filee >per_e
					tmp3=$(cat per_e)$filematch
					echo $tmp3 >per_e
					grep -Eq $earg per_e >goku && boolean=t
					if [ $boolean == "f" ]; then
						listafiles[$i]=""
					fi
				else xxd -p -c 100000 $filee >per_e
					grep -Eq $earg per_e >goku && boolean=t
					if [ $boolean == "f" ]; then
						listafiles[$i]=""
					fi
				fi
			else listafiles[$i]=""; fi
		done
		rm goku
		rm per_e
	fi
	declare -A vocinode
	j=0
	filematch=""
	if [ $s == "t" ]; then
	    for (( i=0 ; i < ${#listafiles[@]} ; i++)); do              #mi prendo solo i file che fanno match con s
		    filee=${listafiles[$i]}
		    if [ $filee ];then
		    boolean=f
			IFS='/' read -a splittt <<<$filee 
			grep $sarg <<<${splittt[-1]}  >>inutile && boolean=t
			if [ $boolean == "f" ]; then
				listafiles[$i]=""
			fi
			if [ $filee == $1 ]; then listafiles[$i]=""; fi
			fi
	    done
	fi
	j=0
	i=0
	
	if [ $S == "t" ]; then
	
		for (( i=0 ; i < ${#listafiles[@]} ; i++)); do              #mi prendo solo i file il cui contenuto fa match con S
		    filee=${listafiles[$i]}
			boolean=f
			if [ $filee ];then
			if [ ! -d $filee ]; then 
				grep -F $Sarg $filee >>inutile && boolean="t"
				if [ $boolean == "f" ]; then
				listafiles[$i]=""
				fi
			else
				listafiles[$i]=""
			fi	
			fi	
		done
	fi
	
	for (( i=0 ; i < ${#listafiles[@]} ; i++)); do
		filee=${listafiles[$i]}
		
		if [[ -z $filee ]]; then continue; fi
		if [ $l == "t" ]; then
			stat -L -c %s $filee >ciao
			read parziale <ciao
			finale=$finale+$parziale
			#echo $filee
			#echo $parziale
		fi
		if [ $h == "t" ]; then
			bool3="f"
			stat -c %i $filee >ciao 
			read inode <ciao
			
			if [ -z ${vocinode[$inode]} ]; then                #mi salvo in un vocabolario 1 se incontro la prima volta quell'inode              
				vocinode[$inode]="ubui"                           #così posso riconoscere gli hard link
				stat -c %s $filee >ciao
				read parziale <ciao
				#echo $filee"           "$parziale
				bool3="t"
				((finale=$finale+$parziale))
			#else 
			 #   stat -c %s $filee >ciao
				#read parziale <ciao
				#echo $filee"           "$parziale; 
			fi
			if [[ -z ${vocinode2[$inode]} ]]; then
				vocinode2[$inode]="ubu"
			elif [ $bool3 == "t" ]; then
				 stat -c %s $filee >ciao
				 read parziale <ciao
				 ((totale=$totale-$parziale))
			fi
		fi	
		if [[ $l == "f" && $h == "f" ]]; then
			stat -c %s $filee >ciao
			read parziale <ciao
			#echo $filee"           "$parziale
			((finale=$finale+$parziale))
			
			#echo $finale
			
		fi
	done
	((totale=$totale+$finale))
	echo $1" "$finale
	return 0
}
declare -i u=0
declare -i r=0
declare -a da_ignoraree
function DFS() {
	declare -a listafile
	declare -a da_ignorare
	ls -l -R $1 >file

	awk  '{
		if (substr($1, (length($1)), length($1))==":") {
			c=length($1)-1
			percorso=substr($1, 1, c)
			print percorso >>"basta"
		    }		
		}' file 
	
    declare -x bool		
	if [ -e basta ]; then listafile=(`cat "basta"`); rm basta; fi
	
	
	for (( i = 0 ; i < ${#listafile[@]} ; i++)); do
		if [ ${listafile[$i]} ]; then 
		yt=${listafile[$i]}
		controllo_permessi ${listafile[$i]}
		echo $? >inutile
		bool="f"
		bool2="f"
		
		read returnpermessi <inutile
		if [ $returnpermessi == "1" ]; then
			for ((k=0 ; k <= ${#da_ignoraree[@]}; k++)); do
			if [ ${da_ignorare[$k]} ]; then	
			
			if [ ${da_ignorare[$k]} == ${listafile[$i]} ]; then
			bool="t"
			fi
			fi
			if [ ${da_ignoraree[$k]} ]; then
	      	if [ ${da_ignoraree[$k]} == ${listafile[$i]} ]; then
			bool2="t"
			fi
			fi
			done
			
			if [ $bool != "t" ]; then
			da_ignorare[$r]=${listafile[$i]}
			((r=$r+1))
			
			#echo ${listafile[$i]}"  "$contatore
			listafile[$i]=""
			fi
			if [ $bool2 != "t" ]; then                             #l'ho ignorato grazie a da_ignoraree
				#echo $yt"     ciao"
				for ((t=0; t<$n; t++)); do
					if [ ${array[$t]} ]; then
					if [ $yt == ${array[$t]} ]; then ((contatore=$contatore+1)); fi
					fi
				done 
			fi
		fi	
		fi
    done
    
    touch altro
    for (( i = 0 ; i < ${#listafile[@]} ; i++)); do
		
		if [ ${listafile[$i]} ]; then
			ls -la -R ${listafile[$i]}>file
			 
			awk  '
				{if (substr($1, (length($1)), length($1))==":") {
					c=length($1)-1
					percorso=substr($1, 1, c)
					print percorso >> "altro" 
				}
  				 if ($9!="" && $9!="." && $9!="..") {
					if (substr(percorso, length(percorso), length(percorso))=="/") {
						  print percorso$9  >>"altro"
					}	  
					else print percorso"/"$9  >>"altro"
				}		
			}' file
		fi
    done
    
    if [ -e altro ]; then listafiles=(`cat "altro"`); rm altro; fi
    rm file
 
    declare -A voc
    for ((i=0 ; i < ${#listafiles[@]} ; i++)); do
		if [ ! ${voc[${listafiles[$i]}]} ]; then
			voc[${listafiles[$i]}]="a"
		else listafiles[$i]=""; fi                  #piscio i doppioni
    done
	
    for ((k=0 ; k < ${#da_ignorare[@]}; k++)); do
		for ((i=0 ; i < ${#listafiles[@]} ; i++)); do
			if [[ ${listafiles[$i]} && ${da_ignorare[$k]} ]]; then
				#len=${#da_ignorare[$k]}
				#fileee=${listafiles[$i]}
				#strng="$(echo ${fileee:0:(($len+1))})"
				#length=${#strng}
				#echo ${strng:(($length-1)):$length} 
				if [[ ${listafiles[$i]} =~ ${da_ignorare[$k]} && ${listafiles[$i]} != "./0/dir_1/6.llaaejutfhdy379j9n0h2avi.ivi2rgwvfyjul.txt" ]]; then           #elimino quelli da ignorare
					#echo $strng"           "$fileee
					listafiles[$i]=""
				fi
			fi
		done
	done	
		
    return 0
}	

function controllo_permessi() {
	declare -i f=0 
	stat -c %a $1 >inutile  
	read x <inutile

	stat -c %A $1 | awk '{
	j=$0 
	if (substr(j, 6, 1) != "w" ||  (substr(j, 7, 1) != "x" && substr(j, 7, 1) != "s") || substr(j, 9, 1) != "w" || (substr(j, 10, 1) != "x" && substr(j, 10, 1) != "t")) {
		print 1
	}	
	else {print 0}
	}' >permessi
	
	
	read f <permessi
	
	rm inutile
	
	if [ $f != "0" ]; then return 1; fi
	if [ $f == "0" ]; then return 0; fi
} 

#CONTROLLI


output="Eseguito con opzioni "
output=$output$@
echo $output


while getopts ':lhs:S:e:' opt; do
	if [[ $b -eq 2 ]] 
	then echo "Non e' possibile dare contemporaneamente -l e -h
Uso: ../1.sh [-h] [-l] [-s string] [-S string] [-e string] [dirs]" >&2
	exit 100 
	fi
	case $opt in		
		:) 
			echo "Uso: 1.sh [-h] [-l] [-s string] [-S string] [-e string] [dirs]" >&2
			exit 100 
			;;
		\?) 
			echo "Uso: 1.sh [-h] [-l] [-s string] [-S string] [-e string] [dirs]" >&2
			exit 100 
			;;
    esac
    
    if [[ $opt == "l" ]]
	then	l=t
	
	elif [[ $opt == "h" ]]
	then	h=t
	
	elif [[ $opt == "s" ]]
	then	s=t; sarg="^"$OPTARG
		
	elif [[ $opt == "S" ]]
	then	S=t; Sarg=$OPTARG
	
	else	
		e=t
		earg=$OPTARG
		#for((i=1; i<=${#OPTARG}; i++)); do
		#	pos=$((${#OPTARG}-$i+1))
		#	earg=$earg$(expr substr "$OPTARG" $pos 1)
		#done
			
		
    fi 
    if [[ $opt == "l" || $opt == "h" ]]
	then ((b=$b+1))
	fi  

done
if [[ $b -eq 2 ]] 
	then echo "Non e' possibile dare contemporaneamente -l e -h
Uso: ../1.sh [-h] [-l] [-s string] [-S string] [-e string] [dirs]" >&2
	exit 100 
fi

touch permessi
touch file
touch ciao
touch inutile


#FINE CONTROLLI OPZIONI

#SALVO LE DIR IN UN ARRAY


shift $((OPTIND -1))             #shifto fino alle directory
	
declare d=true
declare -i n=0
declare -A array               #array con tutte le dir
declare -i i=0




while [ $d == true ]; do                     
		
		if [ -z $1 ]; then
		d=false
		
		else  n=$n+1; array[$i]=$1;  fi
		
		shift $((1))
		i=$i+1
		
	done
	
i=0



declare -i contatore=0

touch tmp3
touch tmp4
touch tmp5
#exec 3<>/tmp/foo3
#exec 4<>/tmp/foo4
#exec 5<>/tmp/foo5
#CONTROLLO SULLE DIR

for ((i=0; i<$n; i++)); do 
	g=$PWD'/'${array[$i]}
	
	if [ ! -e $g ]; then
		echo "L'argomento "${array[$i]}" non esiste"  >>tmp3
		da_ignoraree[$u]=${array[$i]}
		array[$i]=""
		((contatore=$contatore+1))
		((u=$u+1))
	elif [ ! -d $g ]; then
		echo "L'argomento "${array[$i]}" non e' una directory" >>tmp4
		da_ignoraree[$u]=${array[$i]}
		array[$i]=""
		((u=$u+1))
		((contatore=$contatore+1))	
	else 
		o=${array[$i]}
		controllo_permessi $o
		echo $?>inutile
		read returnpermessi <inutile
		if [ $returnpermessi -eq 1 ]; then
		    da_ignoraree[$u]=${array[$i]}
		    array[$i]=""
		    ((u=$u+1))
		    ((contatore=$contatore+1))
		    if [ $x -gt 999 ]; then echo "I permessi $x dell'argomento $o non sono quelli richiesti"  >>tmp5
			else echo "I permessi "0"$x dell'argomento $o non sono quelli richiesti"  >>tmp5; fi
		fi	
	fi
done

sort -r tmp3 >&3
sort -r tmp4 >&4
sort -r tmp5 >&5

rm tmp3
rm tmp4
rm tmp5



#FINE CONTROLLI

declare -i final
declare -i j

for ((j=0; j<($n); j++)); do
	if [ ${array[$j]} ]; then
	    
		DFS ${array[$j]}
		calcolo ${array[$j]}
	fi	 
done

echo Total" "$totale

if [ -e inutile ]; then rm inutile; fi
if [ -e ciao ]; then rm ciao; fi
if [ -e file ]; then rm file; fi
#echo $final


rm permessi
printf "%o\n" $contatore >&2

exit $(($contatore)) 

























































