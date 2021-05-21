module testeadgvm
    
    use types
    implicit none

    private
    
    real(r_8), parameter :: yc3 = 0.37 !Razão do raio do dossel para a altura (prop)
    real(r_8), parameter :: yc4 = 0.4 !Razão do raio do dossel para a altura (prop)
    real(r_8), parameter :: o = 0.35 !constante da respiração de crescimento (prop)
    real(r_8), parameter :: r3 = 0.015 !proporção assumida para plantas C3  (Collatz et al. 1991, 1992)
    real(r_8), parameter :: r4 = 0.025 !proporção assumida para plantas C4  (Collatz et al. 1991, 1992)
    real(r_8), parameter :: bn3= 0.128 !Taxa de respiração para raízes e caules (kgC/kgN)
    real(r_8), parameter :: br3= 2.5 !Fração de alburno na raiz (%)
    real(r_8), parameter :: bs3= 2.5 !Fração de alburno nos caules (%)
    real(r_8), parameter :: vs3= 150.0 !Razão C/N para caule (prop)
    real(r_8), parameter :: vr3= 60.0 !Razão C/N para raizes (prop)

    real(r_8), parameter :: bn4= 0.128 !Taxa de respiração para raízes e caules (kgC/kgN)
    real(r_8), parameter :: br4= 15.0 !Fração de alburno na raiz (%)
    real(r_8), parameter :: bs4= 15.0 !Fração de alburno nos caules (%)
    real(r_8), parameter :: vs4 = 120.0 !Razão C/N para caule (prop)
    real(r_8), parameter :: vr4 = 120.0 !Razão C/N para raizes (prop)

    public :: temperature, canopy3, canopy4, respg3, respg4, respml3, respml4, respms3, respms4, respmr3, respmr4 
    public :: respmt3, respmt4, respmt , respgt, respa

    contains

    function temperature (T) result (ft)
        real(r_8), intent(in) :: T !ºC
        real(r_8) :: ft !função de temperatura

        ft = ( 3.22 - 0.046 * T ) ** T - 20 / 10

    end function temperature

    !função de determinação de dossel

    function canopy3 (h) result (c3)
        real(r_8), intent(in) :: h !altura da planta
        real(r_8) :: c3

        c3 = 3.14*((h*yc3)**2)
    end function canopy3

    function canopy4 (h) result (c4)
        real(r_8), intent(in) :: h !altura da planta
        real(r_8) :: c4

        c4 = 3.14*((h*yc4)**2)
    end function canopy4

    !respiração de crescimento

    function respg3 ( acs, c3 ) result ( rg3 )
        real(r_8), intent(in) :: acs !(é uma variável) Fotossíntese do dossel sob estresse por água e luz (umol/m2s)
        real(r_8), intent(in) :: c3
        real(r_8) :: rg3

        rg3= o * acs * c3

    end function respg3

    function respg4 (acs, c4) result (rg4)
        real(r_8), intent(in) :: acs !(é uma variável) Fotossíntese do dossel sob estresse por água e luz (umol/m2s)
        real(r_8), intent(in) :: c4
        real(r_8) :: rg4

        rg4= o * acs * c4
        
    end function respg4

    !respiração de manutenção foliar

    function respml3 (acs) result (rml3) !respiração por folha rmls= r * Vmax
        real(r_8), intent(in) :: acs !(é uma variável) Fotossíntese do dossel sob estresse por água e luz (umol/m2s)
        real(r_8) :: rml3

        rml3 = r3 * acs

    end function respml3

    function respml4 (acs) result (rml4) !respiração por folha rmls= r * Vmax
        real(r_8), intent(in) :: acs !(é uma variável) Fotossíntese do dossel sob estresse por água e luz (umol/m2s)

        real(r_8) :: rml4

        rml4 = r4 * acs
    end function respml4

    !respiração de manutenção caulinar

    function respms3 (ft) result (rms3)
        real(r_8), intent(in) :: ft
        
        real(r_8) :: rms3

        rms3 = Bn3*(Br3*Bs3/vs3)*ft
    end function respms3

    function respms4 ( ft ) result ( rms4 )
        real(r_8), intent(in) :: ft
        real(r_8) :: rms4

        rms4 = Bn4  *( br4 * Bs4 / vs4 ) * fT

    end function respms4

    !respiração de manutenção radicular

    function respmr3 ( bl , rml3, ft) result (rmr3)
        real(r_8), intent(in) :: bl !biomassa das folhas por dossel (kg)
        real(r_8), intent(in) :: ft
        real(r_8), intent(in) :: rml3
        real(r_8) :: rmr3

        rmr3 = bn3  * ( bs3 * ( br3 - bl ) / vr3 ) * ft + rml3

    end function respmr3

    function respmr4 ( bl, rml4, ft ) result (rmr4)
        real(r_8), intent(in) :: rml4
        real(r_8), intent(in) :: ft
        real(r_8), intent(in) :: bl !biomassa das folhas por dossel (kg)

        real(r_8) :: rmr4

        rmr4 = bn4 * ( bs4 * ( br4 - bl ) / vr4 ) * fT + rml4
    end function respmr4

    function respmt3 (rml3, rms3, rmr3) result (rmt3)
        real(r_8), intent(in) :: rml3
        real(r_8), intent(in) :: rms3
        real(r_8), intent(in) :: rmr3
        real(r_8) :: rmt3

        rmt3= rml3 + rms3 + rmr3
    end function respmt3

    function respmt4 (rml4, rms4, rmr4) result (rmt4)
        real(r_8), intent(in) :: rml4
        real(r_8), intent(in) :: rms4
        real(r_8), intent(in) :: rmr4
        real(r_8) :: rmt4

        rmt4 = rml4 + rms4 + rmr4

    end function respmt4

    function respmt (rmt3, rmt4) result (rm)
        real(r_8), intent(in) :: rmt4
        real(r_8), intent(in) :: rmt3
        real(r_8) :: rm

        rm = rmt3 + rmt4

    end function respmt

    function respgt ( respg3, respg4 ) result (rgt)
        real(r_8), intent(in) :: respg4
        real(r_8), intent(in) :: respg3
        real(r_8) :: rgt

        rgt = respg3 + respg4
    end function respgt

    function respa (rmt, rgt) result (ra)
        real(r_8), intent(in) :: rgt
        real(r_8), intent(in) :: rmt
        real(r_8) :: ra

        ra = rmt + rgt
    end function respa

end module testeadgvm