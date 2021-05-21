from decimal import Decimal
import numpy as np
import  matplotlib.pyplot  as  plt 
import pavlick as p

temp = np.linspace(10.0, 30.0, 10) #ºC

#Fonte: dissertação da Bia
cleaf = np.linspace(0.5, 3.0, 5) * 1000 #KgC/m-2
csa= np.linspace(7.0,20.0, 5) * 1000 #KgC/m-2
croot = np.linspace(0.5, 3.0, 5) * 1000 #KgC/m-2

beta_leaf = 0.1 #carbono incorporado (dia) na folha
beta_froot = 0.1 #carbono incorporado (dia) na raíz fina
beta_awood = 0.5 #carbono incorporado (dia) no tec. lenhoso

vmax = np.linspace(5.0, 91.0, 5) #(molCO2m-2s-1)

cnl = 29.0
cnw = 330.0
cnr = 29.0


result = np.zeros(10,)


for i, t in enumerate (temp):
    tmp = p.pavlick.temp(t)
    rm_leaf2 = p.pavlick.rmleaf ( cleaf, cnl, tmp )
    rm_root2 = p.pavlick.rmfroot ( croot, cnr, tmp )
    rm_wood2 = p.pavlick.rmwood ( csa, cnw, tmp )
    rgleaf = p.pavlick.rg_leaf ( beta_leaf )
    csai = p.pavlick.csai_w (beta_awood) #determinação da quantidade de Carbono no alburno
    rgwood = p.pavlick.rg_wood ( csai )
    rgroot = p.pavlick.rg_root (beta_froot)
    
    rgrowth = p.pavlick.rg ( rgleaf, rgwood, rgroot)
    rm_total = rm_leaf2 + rm_root2 + rm_wood2
    
    result[i] = rgrowth + rm_total


plt.plot(temp, result,  'b', fillstyle='full', label='RA em relação a T')
plt.legend()
plt.xlabel('temperatura', fontsize=10)
plt.ylabel('Respiração Autotrófica (kg/m-2/ano)', fontsize=10)
plt.show()
