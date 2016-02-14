SetActiveLib -work
clearlibrary fir_00229



# Top level
acom  d:\Telops\Common_HDL\SPI\ad7478_driver.vhd
acom d:\Telops\FIR-00229\src\FIR-00229\IRIG\ad7478_driver_TB.vhd

 
asim -ses ad7478_driver_TB 


wave /UUT/*  
 
## pour visulaliser le generateur de statut
#wave /UUT/U1/U11/* 

## pour visulaliser le contrôleur de trigs
#wave /UUT/U1/U1/* 

## pour visulaliser le contrôleur principal du bloc
#wave /UUT/U1/U2/* 

## pour visulaliser le contrôleur principal du bloc
#wave /UUT/U1/U4/* 

## pour visulaliser le contrôleur du detecteur
#wave /UUT/U1/U3/U1/* 

##pour visulaliser le spi_master
#wave /UUT/U1/U3/U6/* 

##pour visulaliser le registre MCR
#wave /UUT/U1/U3/U2/* 

##pour visulaliser le registre WCR
#wave /UUT/U1/U3/U3/*  

##pour visulaliser le registre WDR
#wave /UUT/U1/U3/U5/* 

##pour visulaliser le concatenateur de WDR
#wave /UUT/U1/U3/U5/U3/* 

##pour visulaliser le fifo LL8 de WDR
#wave /UUT/U1/U3/U5/U4/* 

##pour visulaliser le contrôleur de trigs
#wave /UUT/U1/U1/* 

##pour visulaliser le hawk_dval_gen
#wave /UUT/U1/U8/* 

##pour visulaliser le compteur des echantillons
#wave /UUT/U1/U5/* 

##pour visulaliser le selectionneur d'echantillons
#wave /UUT/U1/U6/* 

##pour visulaliser le sommateur d'echantillons
#wave /UUT/U1/U7/* 

##pour visulaliser le convertisseur 64 à 16 bits
#wave /UUT/U1/U9/* 

##pour visulaliser la sortie du pilote hw
#wave /UUT/U1/U3/U7/*   

##pour visulaliser le compteur des clocks
#wave /UUT/U1/U3/U9/* 

##pour verifier les données SPI
#wave /UUT/U1/U3/U8/* 

run  3000 us
