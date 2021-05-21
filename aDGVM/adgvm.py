from decimal import Decimal
import numpy as np
import  matplotlib.pyplot  as  plt
import testeadgvm as ta

temp = np.linspace ( 10.0, 30.0, 10 ) #ºC

vmax = np.linspace ( 5.0, 91.0, 5 ) #(molCO2m-2s-1)

h = np.linspace (1.0, 35.0, 5 ) #altura das arvores em metros

bl = np.linspace ( 3.0, 20.0, 5) #biomassa de folhas (kg/planta) ESSES NÙMEROS EU INVENTEI PRA TESTAR O MODELO< ACHAR OS NUMEOS CERTOS

result3 = np.zeros(10,)
result4 = np.zeros(10,)

#bloco para plantas c3
for i, t in enumerate ( temp ):
    TMP = ta.testeadgvm.temperature ( t )
    canopy3 = ta.testeadgvm.canopy3 ( h )
    growth3 = ta.testeadgvm.respg3 ( vmax, canopy3 )
    leaf3 = ta.testeadgvm.respml3 ( vmax )
    sapwood3 = ta.testeadgvm.respms3( TMP )
    root3 = ta.testeadgvm.respmr3 (bl, TMP, leaf3)
    rmtotal3 = ta.testeadgvm.respmt3 ( leaf3, sapwood3, root3)

    result3[i] = rmtotal3 + growth3

#bloco para plantas c4
for i, t in enumerate ( temp ):
    TMP = ta.testeadgvm.temperature ( t )
    canopy4 = ta.testeadgvm.canopy4 ( h )
    growth4 = ta.testeadgvm.respg4 ( vmax, canopy4 ) #umol/m-2s
    leaf4 = ta.testeadgvm.respml4 ( vmax )
    sapwood4 = ta.testeadgvm.respms4( TMP )
    root4 = ta.testeadgvm.respmr4 (bl, TMP, leaf3)
    rmtotal4 = ta.testeadgvm.respmt4 ( leaf4, sapwood4, root4 )

    result4[i] = rmtotal4 + growth4

plt.plot(temp, result3, 'r', fillstyle='full', label='plantas C3')
plt.plot(temp, result4, 'b', fillstyle='full', label='plantas C4')
plt.legend()

plt.xlabel('temperatura', fontsize=10)
plt.ylabel('Respiração Autotrófica (kg/d,planta)', fontsize=10)
plt.show()

    
   

