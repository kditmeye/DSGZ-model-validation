program DSGZmaterialcoefficients

IMPLICIT NONE

!!!!    definition of variables  

! variables for computing C1 and C2
double precision :: stress(3),strain(3),f(2),jacobi(2,2),invjacobi(2,2),deltaC(2),errori(2),Cold(2),Cnew(2)
double precision :: det,tol,error,C1_guess,C2_guess
double precision :: tempo
integer :: kk
logical :: convergence
! varialbles for computing m
double precision :: strain_rate1_m,strain_rate2_m,stress1_m,stress2_m,strain_m,m 
! variables for computing a
double precision :: stress1_a,stress2_a,T1,T2,a
! variables for computing K 
double precision :: stress_K,strain_rate_K,strain_K,K,h
! variables for computing C3 
double precision :: strain_yield,C3 
! variables for computing the fitting coefficients
double precision :: coef_c4,C4 ! variable for computing C4
double precision :: strain_alpha,alpha ! variable for computing alpha

!! initialize stress/strain variable, allocatable

!!!!    read input data   

open(10,file='input-PC.txt') !! open the file
read(10,*) strain(1)
read(10,*) strain(2)
read(10,*) strain(3)
read(10,*) stress(1)
read(10,*) stress(2)
read(10,*) stress(3)
read(10,*) C1_guess
read(10,*) C2_guess
read(10,*) strain_rate1_m
read(10,*) strain_rate2_m
read(10,*) strain_m
read(10,*) stress1_m
read(10,*) stress2_m
read(10,*) T1
read(10,*) T2
read(10,*) stress1_a
read(10,*) stress2_a
read(10,*) strain_rate_K
read(10,*) strain_yield
read(10,*) strain_alpha
read(10,*) coef_c4
close(10)

!!! debug use, verifing variable value
print*,'*************************************'
print*,'**          INPUT DATA             **'
print*,'*************************************'
print*,'                                     '
print*,'* In order to compute C1 and C2 *'
print*,'(strain 1 = ',SNGL(strain(1)),' stress 1 = ',SNGL(stress(1)),')'
print*,'(strain 2 = ',SNGL(strain(2)),'stress 2 = ',SNGL(stress(2)),')'
print*,'(strain 3 = ',SNGL(strain(3)),'stress 3 = ',SNGL(stress(3)),')'
print*,'* Initial guess for C1 and C2  *'
print*,'C1= ',SNGL(C1_guess),' C2 = ',SNGL(C2_guess)
print*,'*************************************'
print*,'* In order to compute m *'
print*,'strain rate 1 = ',SNGL(strain_rate1_m)
print*,' (strain = ',SNGL(strain_m),' stress 1 = ',SNGL(stress1_m),')'
print*,'strain rate 2 = ',SNGL(strain_rate2_m)
print*,' (strain = ',SNGL(strain_m),' stress 2 = ',SNGL(stress2_m),')'
print*,'*************************************'
print*,'* In order to compute a *'
print*,'Temperature 1 = ',SNGL(T1),' stress 1 = ',SNGL(stress1_a)
print*,'Temperature 2 = ',SNGL(T2),' stress 2 = ',SNGL(stress2_a)
print*,'*************************************'
print*,'* In order to compute K *'
print*,'strain rate = ',SNGL(strain_rate_K)
print*,' (Large strain = ',SNGL(strain(3)),'Large stress = ',SNGL(stress(3)),')'
print*,'*************************************'
print*,'* In order to compute C3 *'
print*,'yield strain before softening = ',SNGL(strain_yield)
print*,'*************************************'
print*,'* In order to compute alpha *'
print*,'End point of softening, strain =~ ',SNGL(strain_alpha)
print*,'*************************************'
print*,'* In order to compute C4 *'
print*,'Glassy polymer / Semicristalline polymer constant = ',SNGL(coef_c4)
print*,'*************************************'
print*,'                                     '
print*,'                                     '

print*,'*************************************'
print*,'**      OUTPUT COEFFICENTS         **'
print*,'*************************************'
print*,'                                     '

!########################
!## compute C1 and C2  ##
!########################

!! Initial guess for C1 and C2, we must have a good initial gess
!! for the Newton-Raphson method converge
Cold(1) = C1_guess
Cold(2) = C2_guess

!! Tolerance for Newton iteration
tol = 1.d-20

! Initialisation of error
error = 1
errori(1) = 1
errori(2) = 1
! Initialisation of number of iterations counter
kk=0


do while ( error > tol)

!! compute the function F
tempo = stress(2)*exp(-Cold(1)*strain(1)) + stress(2)*strain(1)**Cold(2)
f(1) = tempo - stress(1)*exp(-Cold(1)*strain(2)) - stress(1)*strain(2)**Cold(2)

tempo = stress(3)*exp(-Cold(1)*strain(1)) + stress(3)*strain(1)**Cold(2)
f(2) = tempo - stress(1)*exp(-Cold(1)*strain(3)) - stress(1)*strain(3)**Cold(2)

!! compute the jacobian matrix of F
jacobi(1,1) = -stress(2)*strain(1)*exp(-Cold(1)*strain(1)) + stress(1)*strain(2)*exp(-Cold(1)*strain(2))
jacobi(1,2) = stress(2)*log(strain(1))*strain(1)**Cold(2) - stress(1)*log(strain(2))*strain(2)**Cold(2)

jacobi(2,1) = -stress(3)*strain(1)*exp(-Cold(1)*strain(1)) + stress(1)*strain(3)*exp(-Cold(1)*strain(3))
jacobi(2,2) = stress(3)*log(strain(1))*strain(1)**Cold(2) - stress(1)*log(strain(3))*strain(3)**Cold(2)

!! compute the inverse of jacobian matrix

!determinent of the jacobian matrix
det = jacobi(1,1)*jacobi(2,2)-jacobi(1,2)*jacobi(2,1)
!inverse of a 2*2 matix
invjacobi(1,1) = (1/det)*jacobi(2,2)
invjacobi(1,2) = -(1/det)*jacobi(1,2)
invjacobi(2,1) = -(1/det)*jacobi(2,1)
invjacobi(2,2) = (1/det)*jacobi(1,1)

!!compute deltaC
deltaC(1)=-(invjacobi(1,1)*f(1) + invjacobi(1,2)*f(2))
deltaC(2)=-(invjacobi(2,1)*f(1) + invjacobi(2,2)*f(2))

!! compute new C1 and C2
Cnew(1) = Cold(1) + deltaC(1)
Cnew(2) = Cold(2) + deltaC(2)

!! compute the norm 2 error
errori(1) = abs(Cnew(1) - Cold(1))
errori(2) = abs(Cnew(2) - Cold(2))
error = dsqrt((errori(1))**2 + (errori(2))**2)

!! update C1 and C2 for next iteration
Cold = Cnew

!! iteration counter
kk=kk+1
!! if convergence
convergence=.TRUE.

!! if divergence of the Newton-Raphson method
if (kk> 1000) then
print*,'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
print*,'!! divergence of the Newton-Raphson method !!'
print*,'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
Cnew(1)=0
Cnew(2)=0
convergence=.FALSE.  
EXIT
end if

end do



print*,'****************'
print*,'Number of iterations = ',kk
print*,'C1 = ', SNGL(Cnew(1))
print*,'C2 = ', SNGL(Cnew(2))

!################
!## compute m  ##
!################

!! two different curves, the same strain, but two different stresses
!! two different strain rate

m = log(stress1_m/stress2_m)/log(strain_rate1_m/strain_rate2_m)
print*,'****************'
print*,'m =  ', SNGL(m)

!################
!## compute a  ##
!################

!! two different curves, the same strain, but two different stresses
!! two different temperature

a = log(stress1_a/stress2_a)/(1/T1 - 1/T2)
print*,'****************'
print*,'a =  ', SNGL(a)

!################
!## compute K  ##
!################

!! K should be computed by using the large strain point
!! we use the data from which we have computed C1 and C2

h = ((strain_rate_K)**m)*exp(a/T1)

! if converge
if (convergence) then

strain_K = strain(3)
stress_K = stress(3)

! C1 C2 is computed by the curve at T=293k

K = stress_K/((exp(-cnew(1)*strain_K)+strain_K**cnew(2))*h)

! if divergence
else
K=0
end if

print*,'****************'
print*,'K =  ', SNGL(K)

!#################
!## compute C3  ##
!#################

!! C3*h = yield strain

C3 = strain_yield/h
print*,'****************'
print*,'C3 =  ', SNGL(C3)

!####################
!## compute Alpha  ##
!####################

!! C3*h = yield strain

alpha = -log(0.03)/strain_alpha
print*,'****************'
print*,'alpha =  ', SNGL(alpha)

!#################
!## compute C4  ##
!#################

!! C3*h = yield strain

C4 = coef_c4 + log((strain_rate_K**m)*exp(a/T1))
print*,'****************'
print*,'C4 =  ', SNGL(C4)

!#############
!## Output  ##
!#############

open (20,file="output-PC.txt",action="write",status="replace")
write(20,*) 'C1', Cnew(1)
write(20,*) 'C2', Cnew(2)
write(20,*) 'm', m
write(20,*) 'a', a
write(20,*) 'K', K
write(20,*) 'C3', C3
write(20,*) 'alpha', alpha 
write(20,*) 'C4', C4
close (20)

!open (21,file="output-PC1.txt",action="write",status="replace")
!write(21,*)K,' !K'
!write(21,*)Cnew(1),' !C1' 
!write(21,*)Cnew(2),' !C2'
!write(21,*)C3,' !C3'
!write(21,*)C4,' !C4'
!write(21,*)a,' !a'
!write(21,*)m,' !m' 
!write(21,*)alpha,' !alpha' 




close (21)
end
