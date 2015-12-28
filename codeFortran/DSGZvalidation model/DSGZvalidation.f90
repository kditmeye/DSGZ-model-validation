!###################################################
!########## Validation of the  DSGZ model ##########
!###################################################

program DSGZvalidation

IMPLICIT NONE

!!!!    definition of variables   


integer :: i,mesh_size ! loop variables
double precision :: K,c1,c2,c3,c4,a,m,alpha ! material coefficients
double precision :: T,strain_rate,strain_domain
double precision :: f,h,dstrain ! DSGZ model variables
double precision,dimension(:),allocatable :: sigma,strain !matrix definition


!! initialize stress/strain variable, allocatable

!!!!    read input data   

open(10,file='input.txt') !! open the file
read(10,*) K
read(10,*) c1
read(10,*) c2
read(10,*) c3
read(10,*) c4
read(10,*) a
read(10,*) m
read(10,*) alpha
read(10,*) T
read(10,*) mesh_size
read(10,*) strain_domain
read(10,*) strain_rate 

!!! values printing
print*, '*******  material coefficients  *******'
print*,' K=', SNGL(K)
print*,' C1=', SNGL(c1)
print*,' C2=',SNGL(C2)
print*,' C3=',SNGL(C3)
print*,' C4=',SNGL(C4)
print*,' a=',SNGL(a)
print*,' m=',SNGL(m)
print*,' alpha=',SNGL(alpha)
print*, '************ Temperature **************'
print*, SNGL(T)
print*, '************ mesh size ****************'
print*, mesh_size
print*, '*********** strain domain *************'
print*, SNGL(strain_domain)
print*, '************* strain rate *************'
print*, SNGL(strain_rate)

close(10)

!! allocate memory for the matrix
allocate(sigma(mesh_size))
allocate(strain(mesh_size))

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!! obtain stress with strain via DSGZ model !!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


!!! Mesh size
dstrain = strain_domain/mesh_size

do i=1,int(mesh_size)
strain(i)=i*dstrain
end do

!! Compute DSGZ model

h = (strain_rate**m)*exp(a/T)

do i=1,int(mesh_size)

f = ((exp(-c1*strain(i)))+strain(i)**c2)*(1-exp(-alpha*strain(i)))

sigma(i) = K*(f + (strain(i)*exp(1-strain(i)/(c3*h))/(c3*h)- f)*exp((log(h)-c4)*strain(i)))*h

end do

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!! result output - text file !!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


open (11,file="1-result1.txt",action="write",status="replace")

write(11,*) 0.0,0.0
do i=1,mesh_size
write(11,*) strain(i),sigma(i)
end do
close (11)

print*, '                               '
print*, '**********************************************'
print*, 'calculation succed '
print*, 'result file created'
print*, 'end of the program '
print*, '**********************************************'
print*, '                               '

end program DSGZvalidation













