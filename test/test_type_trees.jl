# TESTSET FOR ALL ABSTRACT AND CONCRETE TYPES
# mainly test dependencies of abstract types and availability
@testset "Type Definitions" begin
    
    @testset "Basis definition" begin
        
        @testset "Abstract Basis definitions" begin
            @testset "Abstract Single-Particle Basis definitions" begin
                @test AbstractBasis <: Any
                @test AbstractBasisState <: Any

                @test AbstractSPBasisState <: AbstractBasisState
                @test AbstractSPSSBasisState <: AbstractSPBasisState

                @test SPBasis <: AbstractBasis
            end
        end
        
        @testset "Concrete Basis State definitions" begin
            
            @testset "Single-Particle Basis State definitions" begin
                
                @testset "t2g basis state types" begin
                    @test BasisStateA1G <: AbstractSPSSBasisState
                    @test BasisStateJ <: AbstractSPSSBasisState
                    @test BasisStateLS <: AbstractSPSSBasisState
                    @test BasisStateXYZ <: AbstractSPSSBasisState 
                end
                
                @testset "composite basis state types" begin
                    @test SPSSCompositeBasisState <: AbstractSPSSBasisState
                    @test SPMSCompositeBasisState <: AbstractSPBasisState
                end
                
                @testset "multi-site basis state types" begin
                    @test SPMSBasisState <: AbstractSPBasisState
                end
            end
            
            
            @testset "Multi-Particle Basis State definitions" begin
                
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
                @test ScalarProductOperator <: AbstractOperator
                @test SettableScalarProductOperator <: AbstractOperator
                @test ZeroOperator <: AbstractOperator
                @test SumOperator <: AbstractOperator
            end
            
            @testset "Specific Operator types" begin
                @test DistortionOperator <: AbstractSPSSOperator
                @test MagneticFieldOperator <: AbstractSPSSOperator
                @test SpinOrbitOperator <: AbstractSPSSOperator
                
                @test DipoleOperator <: AbstractSPMSOperator
                @test AbstractSPHoppingOperator <: AbstractSPMSOperator
                
                @test MPElectronPerkinsWoelfleHamiltonian <: AbstractMPInteractionHamiltonian
                @test MPHolePerkinsWoelfleHamiltonian <: AbstractMPInteractionHamiltonian
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
            @test Spectrum <: AbstractSpectrum
        end
        
    end
    
    @testset "Lab System definitions" begin
        @testset "Concrete Lab System types" begin
           @test LabSystem <: Any 
        end
    end
        
    
# end the testset    
end