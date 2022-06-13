################################################################################
#
#   INDIVIDUAL OPERATORS FOR L AND S
#   PURELY BASED ON THEIR NATURAL QUANTUM NUMBERS
#
################################################################################

# delta function
"""
    delta(i,j)

Standard Kroenecker delta ``\\delta_{i,j}``.
"""
function delta(i, j)
    if i == j
        return 1
    else
        return 0
    end
end

# dagger of something
"""
    dagger(x)

The function computes the complex conjugate of a number, ``x^\\dagger``.
"""
function dagger(x)
    return x'
end


# export delta and dagger
export delta, dagger





# operator functions for L
# corresponding to matrix elements
# < l,mlp | operator | l,ml >
"""
    operatorLz(l::Int64, mlp::Int64, ml::Int64) :: Complex{Float64}

This function corresponds to the matrix element ``\\left< l,m_{lp} \\left| L_z \\right| l,m_l \\right>``.
"""
function operatorLz(l::Int64, mlp::Int64, ml::Int64) :: Complex{Float64}
    return delta(mlp, ml)   * ml
end

"""
    operatorLplus(l::Int64, mlp::Int64, ml::Int64) :: Complex{Float64}

This function corresponds to the matrix element ``\\left< l,m_{lp} \\left| L^+ \\right| l,m_l \\right>``.
"""
function operatorLplus(l::Int64, mlp::Int64, ml::Int64) :: Complex{Float64}
    return delta(mlp, ml+1) * sqrt(l*(l+1) - ml*(ml+1))
end

"""
    operatorLminus(l::Int64, mlp::Int64, ml::Int64) :: Complex{Float64}

This function corresponds to the matrix element ``\\left< l,m_{lp} \\left| L^- \\right| l,m_l \\right>``.
"""
function operatorLminus(l::Int64, mlp::Int64, ml::Int64) :: Complex{Float64}
    return delta(mlp, ml-1) * sqrt(l*(l+1) - ml*(ml-1))
end

"""
    operatorLx(l::Int64, mlp::Int64, ml::Int64) :: Complex{Float64}

This function corresponds to the matrix element ``\\left< l,m_{lp} \\left| L_x \\right| l,m_l \\right>``.
"""
function operatorLx(l::Int64, mlp::Int64, ml::Int64) :: Complex{Float64}
    return 0.5 * (operatorLplus(l,mlp,ml) + operatorLminus(l,mlp,ml))
end

"""
    operatorLy(l::Int64, mlp::Int64, ml::Int64) :: Complex{Float64}

This function corresponds to the matrix element ``\\left< l,m_{lp} \\left| L_y \\right| l,m_l \\right>``.
"""
function operatorLy(l::Int64, mlp::Int64, ml::Int64) :: Complex{Float64}
    return -0.5*im * (operatorLplus(l,mlp,ml) - operatorLminus(l,mlp,ml))
end



# export operators
export operatorLx, operatorLy, operatorLz, operatorLplus, operatorLminus


# operator functions for S
# corresponding to matrix elements
# < s,msp | operator | s,ms >
"""
    operatorSz(s::Rational, msp::Rational, ms::Rational) :: Complex{Float64}

This function corresponds to the matrix element ``\\left< s,m_{sp} \\left| S_z \\right| s,m_s \\right>``.
"""
function operatorSz(s::Rational, msp::Rational, ms::Rational) :: Complex{Float64}
    return delta(msp, ms)   * ms
end

"""
    operatorSplus(s::Rational, msp::Rational, ms::Rational) :: Complex{Float64}

This function corresponds to the matrix element ``\\left< s,m_{sp} \\left| S^+ \\right| s,m_s \\right>``.
"""
function operatorSplus(s::Rational, msp::Rational, ms::Rational) :: Complex{Float64}
    return delta(msp, ms+1) * sqrt(s*(s+1) - ms*(ms+1))
end

"""
    operatorSminus(s::Rational, msp::Rational, ms::Rational) :: Complex{Float64}

This function corresponds to the matrix element ``\\left< s,m_{sp} \\left| S^- \\right| s,m_s \\right>``.
"""
function operatorSminus(s::Rational, msp::Rational, ms::Rational) :: Complex{Float64}
    return delta(msp, ms-1) * sqrt(s*(s+1) - ms*(ms-1))
end

"""
    operatorSx(s::Rational, msp::Rational, ms::Rational) :: Complex{Float64}

This function corresponds to the matrix element ``\\left< s,m_{sp} \\left| S_x \\right| s,m_s \\right>``.
"""
function operatorSx(s::Rational, msp::Rational, ms::Rational) :: Complex{Float64}
    return 0.5 * (operatorSplus(s,msp,ms) + operatorSminus(s,msp,ms))
end

"""
    operatorSy(s::Rational, msp::Rational, ms::Rational) :: Complex{Float64}

This function corresponds to the matrix element ``\\left< s,m_{sp} \\left| S_y \\right| s,m_s \\right>``.
"""
function operatorSy(s::Rational, msp::Rational, ms::Rational) :: Complex{Float64}
    return -0.5*im * (operatorSplus(s,msp,ms) - operatorSminus(s,msp,ms))
end



# Spin operators with respect to local coordinate frames
# ASSUMING in coordinate frame cf, the quantisation is given by S = (Sx, Sy, Sz)
# --> new operator in external coordinates

function operatorSx(s::Rational, msp::Rational, ms::Rational, cf::CoordinateFrame) :: Complex{Float64}
    # find out what the x axis is in this frame
    x_prime = get_in_global_coordinates(cf, [1,0,0])
    # return superposition of operators
    return operatorSx(s,msp,ms)*x_prime[1] + operatorSy(s,msp,ms)*x_prime[2] + operatorSz(s,msp,ms)*x_prime[3]
end
function operatorSy(s::Rational, msp::Rational, ms::Rational, cf::CoordinateFrame) :: Complex{Float64}
    # find out what the y axis is in this frame
    y_prime = get_in_global_coordinates(cf, [0,1,0])
    # return superposition of operators
    return operatorSx(s,msp,ms)*y_prime[1] + operatorSy(s,msp,ms)*y_prime[2] + operatorSz(s,msp,ms)*y_prime[3]
end
function operatorSz(s::Rational, msp::Rational, ms::Rational, cf::CoordinateFrame) :: Complex{Float64}
    # find out what the z axis is in this frame
    z_prime = get_in_global_coordinates(cf, [0,0,1])
    # return superposition of operators
    return operatorSx(s,msp,ms)*z_prime[1] + operatorSy(s,msp,ms)*z_prime[2] + operatorSz(s,msp,ms)*z_prime[3]
end


# export operators
export operatorSx, operatorSy, operatorSz, operatorSplus, operatorSminus


# operator functions for J
# corresponding to matrix elements
# < l,mlp,s,msp | operator | l,ml,s,ms >
"""
    operatorJz(l1::Rational, s2::Rational, ml1::Rational, ml2::Rational, ms1::Rational, ms2::Rational, args...) :: Complex{Float64}

This function corresponds to the matrix element ``\\left< j_1,m_{j_2} \\left| J_z \\right| j_2,m_{j_2} \\right>``.
The function is designed to work with the LS basis.
"""
function operatorJz(l1::Rational, s2::Rational, ml1::Rational, ml2::Rational, ms1::Rational, ms2::Rational, args...) :: Complex{Float64}
    return operatorLz(l1,ml1,ml2) + operatorSz(s1,ms1,ms2)
end

"""
    operatorJplus(l1::Rational, s2::Rational, ml1::Rational, ml2::Rational, ms1::Rational, ms2::Rational, args...) :: Complex{Float64}

This function corresponds to the matrix element ``\\left< j,m_{jp} \\left| J^+ \\right| j,m_j \\right>``.
The function is designed to work with the LS basis.
"""
function operatorJplus(l1::Rational, s2::Rational, ml1::Rational, ml2::Rational, ms1::Rational, ms2::Rational, args...) :: Complex{Float64}
    return (Lx(l1,ml1,ml2) + Sx(s1,ms1,ms2,args...) + Ly(l1,ml1,ml2) + Sy(s1,ms1,ms2,args...))/2
end

"""
    operatorJminus(l1::Rational, s2::Rational, ml1::Rational, ml2::Rational, ms1::Rational, ms2::Rational, args...) :: Complex{Float64}

This function corresponds to the matrix element ``\\left< j,m_{jp} \\left| J^- \\right| j,m_j \\right>``.
The function is designed to work with the LS basis.
"""
function operatorJminus(l1::Rational, s2::Rational, ml1::Rational, ml2::Rational, ms1::Rational, ms2::Rational, args...) :: Complex{Float64}
    return (Lx(l1,ml1,ml2) + Sx(s1,ms1,ms2,args...) - Ly(l1,ml1,ml2) - Sy(s1,ms1,ms2,args...))/(2im)
end

"""
    operatorJx(l1::Rational, s2::Rational, ml1::Rational, ml2::Rational, ms1::Rational, ms2::Rational, args...) :: Complex{Float64}

This function corresponds to the matrix element ``\\left< j,m_{jp} \\left| J_x \\right| j,m_j \\right>``.
The function is designed to work with the LS basis.
"""
function operatorJx(l1::Rational, s2::Rational, ml1::Rational, ml2::Rational, ms1::Rational, ms2::Rational, args...) :: Complex{Float64}
    return operatorLx(l1,ml1,ml2) + operatorSx(s1,ms1,ms2,args...)
end

"""
    operatorJy(l1::Rational, s2::Rational, ml1::Rational, ml2::Rational, ms1::Rational, ms2::Rational, args...) :: Complex{Float64}

This function corresponds to the matrix element ``\\left< j,m_{jp} \\left| J_y \\right| j,m_j \\right>``.
The function is designed to work with the LS basis.
"""
function operatorJy(l1::Rational, s2::Rational, ml1::Rational, ml2::Rational, ms1::Rational, ms2::Rational, args...) :: Complex{Float64}
    return operatorLy(l1,ml1,ml2) + operatorSy(s1,ms1,ms2,args...)
end


# export operators
export operatorJx, operatorJy, operatorJz, operatorJplus, operatorJminus
