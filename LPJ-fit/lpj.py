from decimal import Decimal
import numpy as np
import  matplotlib.pyplot  as  plt 
import aresplpj as ar

temp = np.linspace(10.0, 30.0, 10) #ºC
temp2 = np.linspace(8.0, 28.0,10) #temperatura do solo

#Fonte: dissertação da Bia
cleaf = np.linspace(0.5, 3.0, 5) * 1000#aqui tem que converter para gramas #KgC/m-2
cwood = np.linspace(5.0,40, 5) * 1000 #KgC/m-2 pra todas ass partes dos tecidos
croot = np.linspace(0.5, 3.0, 5) * 1000 #KgC/m-2

vmax = np.linspace(5.0, 91.0, 5) #(molCO2m-2s-1)

cnl = 29.0
cnw = 330.0
cnr = 29.0

result = np.zeros(10,)
result2 = np.zeros(10,)

for i, t in enumerate (temp):
    TMP = ar.aresplpj.temp(t)
    rm_leaf = ar.aresplpj.rleaf( cleaf, cnl, TMP )
    rm_wood = ar.aresplpj.rwood( cwood, cnw, TMP )
    rm_root = ar.aresplpj.rroot( croot, cnr, temp2 )
    r_growth = ar.aresplpj.rgrowth ( vmax ) 
    rm_total = rm_leaf + rm_wood + rm_root
    
    result[i] = rm_total + r_growth


#plotagem de gráficos

plt.plot(temp, result, 'b', fillstyle='full', label='RA em relação a T')
plt.legend()
plt.title('Sensibilidade da representação de RA do modelo LPJ-fit à temperatura', fontsize=12)
plt.xlabel('Temperatura (T)', fontsize=10)
plt.ylabel('Respiração Autotrófica (gC/m-2s-1,dia)', fontsize=10)
plt.show()







