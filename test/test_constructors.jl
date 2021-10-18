# TESTSET FOR ALL CONCRETE TYPES
# mainly test dependencies of concrete types and availability
@testset "Constructor Functions" begin
@testset "Basis Constructors" begin
    
        @testset "Basis State Costructors" begin
            
            @testset "Single-Particle Basis State Constructors" begin
                
#                 @testset "t2g basis state constructors" begin
#                     @test BasisStateA1G <: AbstractSPSSBasisState
#                     @test BasisStateJ <: AbstractSPSSBasisState
#                     @test BasisStateLS <: AbstractSPSSBasisState
#                     @test BasisStateXYZ <: AbstractSPSSBasisState 
#                 end
                
                @testset "composite basis state constructors" begin
                    @test_nowarn SPSSCompositeBasisState(rand(10), getT2GBasisLS())
                    @test typeof(SPSSCompositeBasisState(rand(10), getT2GBasisLS())) <: SPSSCompositeBasisState
                        
                    @test_nowarn SPMSCompositeBasisState(rand(10), getMultiSiteBasis(getT2GBasisLS(),3))
                    @test typeof(SPMSCompositeBasisState(rand(10), getMultiSiteBasis(getT2GBasisLS(),3))) <: 
                end
                
                @testset "multi-site basis state constructors" begin
                    @test SPMSBasisState <: AbstractSPBasisState
                end
            end
            
            
            @testset "Multi-Particle Basis State Constructors" begin
                
                @test MPBasisState <: AbstractBasisState
                @test MPBasis <: AbstractBasis
                
            end
            
        end #end concrete basis state definitions
            
        
    end
  
#######################################################################################
    
    
    @testset "Operator definition" begin
        
        @testset "Abstract Operator definitions" begin
            @test AbstractOperator <: Any
            @test AbstractSPOperator <: AbstractOperator
            @test AbstractMPOperator <: AbstractOperator
            
            @test AbstractSPSSOperator <: AbstractSPOperator
            @test AbstractSPMSOperator <: AbstractSPOperator
            
            @test AbstractMP1POperator <: AbstractMPOperator
            @test AbstractMP2POperator <: AbstractMPOperator
            @test AbstractMPInteractionHamiltonian <: AbstractMPOperator
            
            @test AbstractMPDensityDensityOperator <: AbstractMP2POperator{MPB} where MPB
            
            @test AbstractMP2PScatteringOperator <: AbstractMP2POperator{MPB} where MPB
        end
        
        @testset "Concrete Operator definitions" begin
            
            @test SPLocalMSOperator <: AbstractSPMSOperator
            
            @testset "Multi-Particle Operators definitions" begin
                @test MPGeneralizedSPOperator <: AbstractMP1POperator
                
                @test MPElectronDensityDensityOperator <: AbstractMPDensityDensityOperator
                @test MPHoleDensityDensityOperator <: AbstractMPDensityDensityOperator
                
                @test MPElectron2PScatteringOperator <: AbstractMP2PScatteringOperator
                @test MPHole2PScatteringOperator <: AbstractMP2PScatteringOperator 
            end
            
            @testset "Mathematical Operator types" begin
                @test ScalarProductOperator <: AbstractOperator{B} where B
                @test SettableScalarProductOperator <: AbstractOperator{B} where B
                @test ZeroOperator <: AbstractOperator{B} where B
                @test SumOperator <: AbstractOperator{B} where B
            end
            
            @testset "Specific Operator types" begin
                @test DistortionOperator <: AbstractSPSSOperator{SPB} where SPB
                @test MagneticFieldOperator <: AbstractSPSSOperator{SPB} where SPB
                @test SpinOrbitOperator <: AbstractSPSSOperator{SPB} where SPB
                
                @test DipoleOperator <: AbstractSPMSOperator
                @test AbstractSPHoppingOperator <: AbstractSPMSOperator{SPB} where SPB
                
                @test MPElectronPerkinsWoelfleHamiltonian <: AbstractMPInteractionHamiltonian{2, MPB} where MPB<:(MPBasis{N, SPBS} where {N, SPBS})
                @test MPHolePerkinsWoelfleHamiltonian <: AbstractMPInteractionHamiltonian{2, MPB} where MPB<:(MPBasis{N, SPBS} where {N, SPBS})
            end
            
            @testset "Projector Operator types" begin
                @test SPSSProjectorOperator <: AbstractSPSSOperator
                @test SPMSProjectorOperator <: AbstractSPMSOperator
                @test MPProjectorOperator <: AbstractMPOperator
                @test GeneralProjectorOperator <: AbstractOperator
            end
            
        end # end concrete operator type testset

              
    end # end operator testset
    
#######################################################################################
    
    
    @testset "Coordinate Frame definitions" begin
       @testset "Concrete Coordinate Frame types" begin
            CoordinateFrame <: Any
        end
    end
    
    
#######################################################################################   
    
    @testset "Transition definitions" begin
        
        @testset "Abstract Spectrum and Transition types" begin
            @test AbstractTransition <: Any
            @test AbstractSpectrum <: Any
        end
        
        @testset "Concrete Spectrum and Transition types" begin
            @test Transition <: AbstractTransition
            @test Spectrum <: AbstractSpectrum{T} where T
        end
        
    end
    
    @testset "Lab System definitions" begin
        @testset "Concrete Lab System types" begin
           @test LabSystem <: Any 
        end
    end
        
    
# end the testset    
end