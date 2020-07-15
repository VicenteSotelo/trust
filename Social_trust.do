

#R

setwd("/Users/luisvicentesotelofarfan/Google Drive/III.ComponenteProfesional/Repo/ENAHO/2019/687-Modulo85")

library(foreign)

base_1<-read.spss ("Enaho01B-2019-1.sav", use.value.labels=TRUE, to.data.frame=TRUE)
write.dta(base_1, file="base1.dta")

base_2<-read.spss ("Enaho01B-2019-2.sav", use.value.labels=TRUE, to.data.frame=TRUE)
write.dta(base_2, file="base2.dta")

list.files()

*Stata

clear

use "/Users/luisvicentesotelofarfan/Google Drive/III.ComponenteProfesional/Repo/ENAHO/2019/687-Modulo85/base1.dta"


*Domine: Region

gen region=1				if UBIGEO>=1 & UBIGEO<=51

replace region=2			if UBIGEO>=52 & UBIGEO<=128

replace region=3			if UBIGEO>=129 & UBIGEO<=187

replace region=4			if UBIGEO>=188 & UBIGEO<=252

replace region=5			if UBIGEO>=253 & UBIGEO<=325

replace region=6			if UBIGEO>=326 & UBIGEO<=404

replace region=7			    if UBIGEO>=405 & UBIGEO<=411

replace region=8	    		if UBIGEO>=412 & UBIGEO<=487

replace region=9			if UBIGEO>=488 & UBIGEO<=552

replace region=10			    if UBIGEO>=553 & UBIGEO<=617

replace region=11 			    if UBIGEO>=618 & UBIGEO<=654

replace region=12 	    if UBIGEO>=655 & UBIGEO<=728

replace region=13 		if UBIGEO>=729 & UBIGEO<=789

replace region=14			    if UBIGEO>=790 & UBIGEO<=825

replace region=15		if UBIGEO>=826 & UBIGEO<=935

replace region=16     if UBIGEO>=934 & UBIGEO<=977

replace region=17			if UBIGEO>=978 & UBIGEO<=988

replace region=18		    if UBIGEO>=989 & UBIGEO<=1007

replace region=19			    if UBIGEO>=1008 & UBIGEO<=1035

replace region=20 			    if UBIGEO>=1036 & UBIGEO<=1086

replace region=21 	    if UBIGEO>=1087 & UBIGEO<=1153

replace region= 22 			    if UBIGEO>=1154 & UBIGEO<=1212

replace region=23 			if UBIGEO>=1213 & UBIGEO<=1232

replace region=24 			if UBIGEO>=1233 & UBIGEO<=1245

replace region=25			if UBIGEO>=1246 & UBIGEO<=1259


label variable region "regiones" /*seting nd execution labes variable*/


#delimit ;						/*seting label values*/

label define regiones

1 "AMAZONAS" 	2 "ANCASH"
3 "APURIMAC" 	4 "AREQUIPA"
5 "AYACUCHO" 	6 "CAJAMARCA"
7 "CALLAO"
8 "CUSCO" 	    9 "HUANCAVELICA"
10 "HUANUCO" 	11 "ICA"
12 "JUNIN"   	13 "LA LIBERTAD"
14 "LAMBAYEQUE" 15 "LIMA"
16 "LORETO"  	17 "MADRE DE DIOS"
18 "MOQUEGUA"   19 "PASCO"
20 "PIURA"   	21 "PUNO"
22 "SAN MARTIN"  23 "TACNA"
24 "TUMBES"  	25 "UCAYALI"
;


label values region regiones   /*execution label values*/


/*
gen region="AMAZONAS" 				if UBIGEO>=1 & UBIGEO<=51

replace region="ANCASH" 			if UBIGEO>=52 & UBIGEO<=128

replace region="APURIMAC" 			if UBIGEO>=129 & UBIGEO<=187

replace region="AREQUIPA" 			if UBIGEO>=188 & UBIGEO<=252

replace region="AYACUCHO" 			if UBIGEO>=253 & UBIGEO<=325

replace region="CAJAMARCA" 			if UBIGEO>=326 & UBIGEO<=404

replace region="CALLAO" 			    if UBIGEO>=405 & UBIGEO<=411

replace region="CUSCO" 	    		if UBIGEO>=412 & UBIGEO<=487

replace region="HUANCAVELICA" 			if UBIGEO>=488 & UBIGEO<=552

replace region="HUANUCO" 			    if UBIGEO>=553 & UBIGEO<=617

replace region="ICA" 			    if UBIGEO>=618 & UBIGEO<=654

replace region="JUNIN" 	    if UBIGEO>=655 & UBIGEO<=728

replace region="LA LIBERTAD" 		if UBIGEO>=729 & UBIGEO<=789

replace region="LAMBAYEQUE" 			    if UBIGEO>=790 & UBIGEO<=825

replace region="LIMA" 			if UBIGEO>=826 & UBIGEO<=935

replace region="LORETO"      if UBIGEO>=934 & UBIGEO<=977

replace region="MADRE DE DIOS" 			if UBIGEO>=978 & UBIGEO<=988

replace region="MOQUEGUA" 			    if UBIGEO>=989 & UBIGEO<=1007

replace region="PASCO" 			    if UBIGEO>=1008 & UBIGEO<=1035

replace region="PIURA" 			    if UBIGEO>=1036 & UBIGEO<=1086

replace region="PUNO" 	    if UBIGEO>=1087 & UBIGEO<=1153

replace region="SAN MARTIN" 			    if UBIGEO>=1154 & UBIGEO<=1212

replace region="TACNA" 			if UBIGEO>=1213 & UBIGEO<=1232

replace region="TUMBES" 			if UBIGEO>=1233 & UBIGEO<=1245

replace region="UCAYALI" 			if UBIGEO>=1246 & UBIGEO<=1259

*/


* Argument: Social Trust

foreach p in 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 {

	gen d_`p' = (P1_`p'==3 | P1_`p'==4)
	
	replace d_`p' = .  if P1_`p'==5 
	
	replace d_`p' = .  if P1_`p'==. 
}

*Function: mean

*svyset CONGLOME [pweight=FAMIEGOB07], strata(ESTRATO)

*svy: mean d_01

*collapse (mean) d_01 [iw=FAMIEGOB07]

collapse (mean) d_* [iw=FAMIEGOB07], by (region)

*Labels
rename d_01 JNE

rename d_02 ONPE

rename d_03 RENIEC

rename d_04 Prov

rename d_05 Dist

rename d_06 PNP

rename d_07 FFAA

rename d_08 Nac

rename d_09 PJ

rename d_10 MINEDU

rename d_11 Defens

rename d_12 Congreso

rename d_13 Partidos

rename d_14 Prensa_Escrita

rename d_15 Radio_Televisión

rename d_16 Iglesia_Católica

rename d_17 Procuradoría

rename d_18 Fiscalía

rename d_19 Contraloría

rename d_20 SUNAT

rename d_21 Comisión_Anticorrupción


label var JNE JNE

label var ONPE ONPE

label var RENIEC RENIEC

label var Prov Prov

label var Dist Dist

label var PNP PNP

label var FFAA FFAA

label var Nac Nac

label var PJ PJ

label var MINEDU MINEDU

label var Defens Defens

label var Congreso Congreso

label var Partidos Partidos

label var Prensa_Escrita Prensa_Escrita

label var Radio_Televisión Radio_Televisión

label var Iglesia_Católica Iglesia_Católica

label var Procuradoría Procuradoría

label var Fiscalía Fiscalía

label var Contraloría Contraloría

label var SUNAT SUNAT

label var Comisión_Anticorrupción Comisión_Anticorrupción

*Graphs:


global var1 RENIEC Iglesia_Católica MINEDU FFAA Radio_Televisión Defens PNP Dist Prensa_Escrita Prov Nac Congreso Partidos


*Graph 1

#delimit ;

graph hbar $var1 

if region>=1 & region<=12

, by(region, note(""))


legend(label (1 "RENIEC") label (2 "Iglesia_Católica") label(3 "MINEDU")  label(4 "FFAA") label (5 "Radio_Televisión") label(6 "Defensoria") label( 7 "PNP") 

			  label(8 "Distrital") label (9 "Prensa_Escrita") label (10 "Provincial") label(11 "Nacional") label(12 "Congreso") label(13 "Partidos_Políticos")

	size(tiny) cols(7) rowgap(0.5) colgap(0.5) symysize(1) symxsize(1))  

note(" ") 
;



*Graph 1

#delimit ;

graph hbar $var1 

if region=="AMAZONAS" | region=="ANCASH" | region=="APURIMAC " | region=="AREQUIPA" |  region=="AYACUCHO" | region=="CAJAMARCA"  | region=="CALLAO"

	| region=="CUSCO" | region=="HUANCAVELICA" | region=="HUANUCO"


, by(region) 

legend(label (1 "RENIEC") label (2 "Iglesia_Católica") label(3 "MINEDU")  label(4 "FFAA") label (5 "Radio_Televisión") label(6 "Defensoria") label( 7 "PNP") 

			  label(8 "Distrital") label (9 "Prensa_Escrita") label (10 "Provincial") label(11 "Nacional") label(12 "Congreso") label(13 "Partidos_Políticos")

	size(tiny) cols(7) rowgap(0.5) colgap(0.5) symysize(1) symxsize(1))  
;

*Graph 2


#delimit ;

graph hbar $var1 

if region=="ICA" | region=="JUNIN" | region=="LA LIBERTAD " | region=="LAMBAYEQUE |  region=="LIMA" | region=="LORETO"  | region=="CALLAO"

	| region=="CUSCO" | region=="HUANCAVELICA" | region=="HUANUCO"


, by(region) 

legend(label (1 "RENIEC") label (2 "Iglesia_Católica") label(3 "MINEDU")  label(4 "FFAA") label (5 "Radio_Televisión") label(6 "Defensoria") label( 7 "PNP") 

			  label(8 "Distrital") label (9 "Prensa_Escrita") label (10 "Provincial") label(11 "Nacional") label(12 "Congreso") label(13 "Partidos_Políticos")

	size(tiny) cols(7) rowgap(0.5) colgap(0.5) symysize(1) symxsize(1))  
;









