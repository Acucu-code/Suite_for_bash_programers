#!/bin/sh
#oxr 2026
# Matriz en variable, base de datos. Hay que incluirla: '. mt'
#
#\\r	mt [-g|-d|-s|-l|-b|-e] nombre
#\\r	mt nombre [-g|-d|-a|-p|-e|-r "texto" "reemplazo"] [var] ["valor"|$valor]
#
# 'nombre' nombre de la matriz
# '-g'	muestra nombre [var]
# '-a'	añade antes en var
# '-p'	añade despues en var
# '-r'	reemplaza texto en var
# '-d'	borra nombre [var]
# '-s'	guardar en ~/mt/nombre
# '-l'	cargar archivo nombre
# '-b'	borrar archivo nombre
# '-e'	ejecutar valores como instrucciones
# 'var'	nombre de variable
# \\r	 se indica para -g -d o para añadirla: mt nombre -g var
# \\r	 si no se indica, -g y -d actuaran con toda las variables
# 'valor'	contenido de 'var'
# \\r	 se indica solo al añadirla: mt nombre var valor
#
# Sin opcion y 'var' crea o reemplaza, sin 'var' muestra todo: 'var' 'valor' ...
# La salida esta en $mt_M.
#
# ⧵∕


[ $include_ctl ] || . include ; include tize # sep<tize


mt(){
[ $# -gt 0 ] || { infsh $code/mt 3 25 ; return ;}
# g get - d delete - s save - -e ejecutar - r reemplazar - a añade antes - p añade despues - S separador - R return - x comodin - z comodin - t reemplazo - B basedatos
#N nombre matriz - V nombre variable - C cadena - M matriz
local g=false d=false s=false e=false r=false a=false p=false S='¨¨ ' x=false z="" t="" B=~/mt
local mt_N="$1" mt_V="" mt_C="" # R='
# '

mt_M=""

[ ${1#-} = "$1" ] && shift || mt_N="$2"
# shift

case $1 in # opciones
-g) g=true ; shift ;;
"") g=true x=true ;;
-d) d=true ; shift ;;
-r) r=true ; mt_V=$2 mt_C="$3" t="$4" ; shift 4 ;;
-a) a=true ; shift ;;
-p) p=true ; shift ;;
-b)	unset $mt_N ; [ -e $B/$mt_N ] && rm $B/$mt_N ; return ;; # borrar archivo
-s) s=true ; shift ;;
-l)	[ -e $B/$mt_N ] && { # cargar
		sep -L -A $B/$mt_N -O 'mt_M=$mt_M$sep_C$R'
		eval $mt_N='${mt_M%$R}'
	} || echo "mt: No existe el archivo '$mt_N'"
	return ;;
-e) e=true ; shift ;;
esac

[ "$mt_N" != "$1" ] || shift

# Control de existencia y precarga
{ $r || { [ $# -gt 1 ] && { mt_V=$1 ; shift ; mt_C="$@" ;} || mt_V=$1 ;} # V y C
eval mt_M="\$$mt_N"
[ ${#mt_M} -gt 0 -o "$mt_M" = "$" ] || { # cargar si existe
	[ -e $B/$mt_N ] && { # carga
		mt $mt_N -l
		eval mt_M="\$$mt_N"
	} || { # no existe
		[ ${#mt_V} -gt 0 ] || {
			echo "mt: No existe la matriz '$mt_N'"
			return 1
		}
	}
};}

$e && { # ejecutar
	[ ${#mt_V} -eq 0 ] || { eval `mt $mt_N -g $mt_V` ; return ;}
	sep -S $S -O '[ "${sep_C#* }" = "" ] || eval ${sep_C#* }' "$mt_M" ; return
}

[ ${#mt_M} -gt 0 ] && { # existe
	$d || $a || $p || $r && { # borrar matriz/var | añadir a var
[ ${#mt_V} -gt 0 ] || { unset $mt_N mt_M ; return ;}
		x="$mt_M" mt_M=""
		sep -S $S -O '[ "${sep_C%% *}" = "$mt_V" ] && {
			! $a || mt_M="$mt_M${sep_C%% *} $mt_C ${sep_C#* }$S$R"
			! $p || mt_M="$mt_M${sep_C%% *} ${sep_C#* } $mt_C$S$R"
			! $r || { tize -v z -n "$mt_C" -r "$t" / "$sep_C" ; mt_M="$mt_M$z$S$R" ;}
		} || {
			[ "$sep_C" = "" ] || mt_M="$mt_M$sep_C$S$R"
		}' "$x"
		eval $mt_N='${mt_M%$R}'
		return
	} || :
	$s && { [ -e $B ] || mkdir ~/mt ; echo "$mt_M">$B/$mt_N ; return ;} || : # guardar
	$g && { # get
		[ ${#mt_V} -gt 0 ] && { # var
			sep -S $S -O '
				[ "${sep_C%% *}" != "$mt_V" ] || {
					mt_M=${sep_C#* } ; echo "$mt_M" ; return
				}' "$mt_M"
		} || { # todo: var's y valores
			$x && sep -S $S -V mt_M "$mt_M" || { # solo los valores
				x="$mt_M" mt_M=""
				sep -S $S -O 'mt_M=$mt_M${sep_C#* }$R' "$x"
				mt_M=${mt_M%$R}
			}
			echo -n "$mt_M" ; return
		}
	} || { # put/replace
		[ ${#mt_C} -gt 0 ] || {
			read -p "mt: Vaciar '$mt_V' [-d|nuevo contenido]" x
			[ "$x" = -d ] || { [ ${#x} -eq 0 ] && return || mt_C="$x" ;}
		}
		sep -S $S -O '[ "${sep_C%% *}" != "$mt_V" ] || {
			mt $mt_N -d $mt_V ; eval mt_M="\$$mt_N"
		}' "$mt_M"
		mt_M="$mt_M$mt_V $mt_C $S$R"
		eval $mt_N='${mt_M%$R}'
	}
} || { # crear
		mt_M="$mt_V $mt_C $S$R"
		eval $mt_N='${mt_M%$R}'
}
}


[ ${0##*/} != mt ] || mt "$@"
#
