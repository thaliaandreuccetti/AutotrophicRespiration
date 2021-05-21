module aresplpj
    !use ISO_FORTRAN_ENV, only: REAL32, r_8, REAL128
   
    use types

    implicit none
    private

    real(r_8), parameter :: phi = 1.61803398875D0
    real(r_8), parameter :: resp_rate = 0.011D0 !Table 3 in Sitch et al 2003!é a taxa de respiração (gCgN-1day-1) na base de 10ºC

    public :: temp, rleaf, rwood, rroot, rtotal, rgrowth

    contains

    function temp( t ) result ( tair ) !função temperatura do ar

        real(r_8), intent(in) :: t
        real(r_8) :: tair
        tair= exp(308.56*((1.0/56.02)-(1/(T+46.02))))

    end function temp
    


    !Funções de respiração autotrófica
    function rleaf (cleaf, cnl, tair) result (rmleaf)

        real(r_8), intent(in) :: cleaf !massa da folha (gC)
        real(r_8), intent(in) :: cnl !é uma razão
        real(r_8), intent(in) :: tair !temperatura do ar
        real(r_8) :: rmleaf !respiração de manutenção foliar

        rmleaf = (resp_rate * (cleaf / cnl) * phi * tair) * 365.2420D0

    end function rleaf

    function rwood (cwood, cnw, tair) result (rmwood)
        real(r_8), intent(in) :: cwood
        real(r_8), intent(in) :: cnw
        real(r_8), intent(in) :: tair
        real(r_8) :: rmwood

        rmwood = (resp_rate * (cwood / cnw) * tair) * 365.2420D0

    end function rwood

    function rroot ( croot, cnr, tsoil ) result ( rmroot )
        real(r_8), intent(in) :: croot
        real(r_8), intent(in) :: cnr
        real(r_8), intent(in) :: tsoil
        real(r_8) :: rmroot

        rmroot = (resp_rate * (croot / cnr) * phi * tsoil) * 365.242D0

    end function rroot

    function rtotal ( rmwood, rmroot, rmleaf ) result ( rmtotal )
        real(r_8), intent(in) :: rmleaf
        real(r_8), intent(in) :: rmwood
        real(r_8), intent(in) :: rmroot
        real(r_8) :: rmtotal

        rmtotal = rmleaf + rmroot + rmwood

    end function rtotal

    function rgrowth (vm) result (rg)
        real(r_8), intent(in) :: vm  !Vcmax (molCO2m-2s-1) MUDAR A VM
        real(r_8) :: rg

        rg= 0.25*vm

    end function rgrowth

end module aresplpj

