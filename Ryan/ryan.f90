module pavlick

    use types
    implicit none
    private

    !real(r_8), parameter :: beta_leaf = 0.001 !carbono incorporado (dia) na folha
    !real(r_8), parameter :: beta_froot = 0.001 !carbono incorporado (dia) na raíz fina
    ! real(r_8), parameter :: beta_awood = 0.001 !carbono incorporado (dia) na madeira
    ! real(r_8), parameter :: rg_aawood = 0.001 !respiração de crescimento da madeira

    
    !real(r_8) :: ncl = 1.0/29 !1.0/29.0 razão nitrogênio por carbono da folha 
    !real(r_8) :: ncf = 1.0/29 !1.0/29.0 #razão nitrogênio por carbono na raiz fina
    !real(r_8) :: ncs = 1.0/330 !1.0/330.0 razão nitrogênio por carbono da madeira
    !real(r_8) :: cl1 = 0.7 !carbono na folha
    !real(r_8) :: cf1 = 0.7 !carbono na raíz fina
    !real(r_8) :: ca1 = 7.0 !carbono na madeira
   
    public :: rmleaf, rmfroot, rmwood, temp, rmtotal, rg , rg_leaf , rg_wood , rg_root, csai_w

    
   
    contains

    function temp(t) result(tair) !função temperatura do ar

        real(r_8), intent(in) :: t
        real(r_8) :: tair
        tair= t*1.
    end function temp
    

    function rmleaf(cl1, ncl, temp) result (rml64)

        real(r_8), intent(in) :: cl1 
        real(r_8), intent(in) :: ncl 
        real(r_8), intent(in) :: temp !ºC
        real(r_8) :: rml64

        rml64 = ((ncl * (cl1 * 1e3)) * 15. * exp(0.07*temp)) !esse é o lugar onde haviam diminuido um (de 0.07 para 0.03) atributo da função para diminuir sua sensibilidade ao aumento da temperatura

    end function rmleaf

    function rmfroot (cf1, ncf, tsoil) result (rmf64)

        real(r_8), intent(in) :: cf1
        real(r_8), intent(in) :: ncf
        real(r_8), intent(in) :: tsoil
        real(r_8) :: rmf64

        rmf64 = ((ncf * (cf1 * 1e3)) * 15. * exp(0.07*tsoil))

    end function rmfroot

    function rmwood (csa, ncs, temp) result (rms64)

        real(r_8), intent(in) :: csa
        real(r_8), intent(in) :: ncs
        real(r_8), intent(in) :: temp
        real(r_8) :: rms64

        rms64 = ((ncs * (csa * 1e3)) * 15. * exp(0.07*temp))
    
    end function rmwood

    function rmtotal (rml64, rmf64, rms64) result (rm64)

        real(r_8), intent(in) :: rml64
        real(r_8), intent(in) :: rmf64
        real(r_8), intent(in) :: rms64
        real(r_8) :: rm64

        rm64 = (rml64 + rmf64 + rms64)/1e3

    end function rmtotal
    
    function rg_leaf (beta_leaf) result (rgl64)
    	real(r_8), intent(in) :: beta_leaf
    	real(r_8) :: rgl64
    	
    	rgl64 = 1.25 * beta_leaf
    
    end function rg_leaf
    
    function csai_w ( beta_awood ) result ( csai ) !determina a quantidade de carbono no alburno
    	real(r_8), intent(in) :: beta_awood
    	real(r_8) :: csai 
    	
	csai = ( beta_awood * 0.05 )
    	
    end function csai_w
    
    
    function rg_wood (csai) result (rgs64)
    	real(r_8), intent(in) :: csai 
    	real(r_8) :: rgs64
    	
    	rgs64 =  1.25 * csai !carbono no alburno
    	
    end function rg_wood
    
    function rg_root ( beta_froot ) result ( rgf64 )
    	real(r_8), intent(in) :: beta_froot
    	real(r_8) :: rgf64
       
    	rgf64 =  1.25 * beta_froot 
    	
    end function rg_root
    

    function rg (rgl64, rgs64, rgf64) result (rg64)
       real(r_8), intent(in) :: rgl64
       real(r_8), intent(in) :: rgs64
       real(r_8), intent(in) :: rgf64
       real(r_8) :: rg64

        rg64 = (rgl64 + rgf64 + rgs64)/1e3

    end function rg


end module pavlick
