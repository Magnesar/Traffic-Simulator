//general model
clc
//values  ---- all units are in SI
N = 50          //No. of vehicles
ac=10           //critical value of distance between 2 vehicles
ainit=5         // initial distance between all vehicles
av=40           //safety distance for vehicle travelling at V
ainf=60         //Vinf=V*f(ainf)        the distance all vehicle tend towards
Vmax=30      //maximum velocity, V

//Function of distance between 2 vehicles 
function f=F(a)
    if a>ac then
        f=1-exp(-(a-ac)/(av-ac))
    else
        f=0
    end
endfunction

//making initial values of xn
for i=1:N
    x(i) = (i-1)*ainit
    X(i)=[x(i)]
end
//disp('X=',X)

//initial distance between the vehicles
for i=1:N-1
    d(i)=ainit
end
d(N)=ainf           //since the Nth vehicle leads all 
//putting a_n/ainf in a matrix for plotting later
for i=1:N
    D(i)=[d(i)/ainf]
end
//disp("D",D)

//matrix for velocities of the vehicles
for i=1:N
    v(i)=0          //since they're not moving at t=0
    V(1,i)=[v(i)]
end



// loop for simulation(can be made infinite using while 1)
j=0
while j<50                         //value of j=time in seconds
     //animation
    drawlater();
    clf
    plot(X,D)           //plots the curve
    for i=1:N
        plot(x(i),0.0,"O")          //plots the points
    end
    
    xlabel('x(metres)','fontsize','3')
    ylabel('a_n/a_inf','fontsize','3')
    drawnow();
    //sleep(10)             //can be used to slow the transition
    
    //finding velocity
    for i=1:N
        v(i)=Vmax*F(d(i))
    end
    //v(N)=Vmax*F(d(N))
    
    //finding new values of xn
    for i=1:N
        x(i)=x(i)+v(i)          //distance travelled in one sec=velocity of object
    end
    
    //change in a(n)=a(n)+v(n+1)-v(n)
    for i=2:N           //for the loop to have all valid values 
        d(i-1)=d(i-1)+v(i)-v(i-1)
    end
    
    
    for i=1:N
        V(i)=[v(i)]
        D(i)=[d(i)/ainf]
        X(i)=[x(i)]
        //X1(i,j)=[x(i)]              //matrix having all values of xn sorted in columns
    end
    
   
    //disp(V)
    j=j+1           //increasing value of j by 1
end
//disp(V)               //can be used to display the final matrix of velocities 
disp('Vinf',max(V))

cM=(ainit/(ac-ainit))*max(V)
disp('Propogation speed of velocity for ac='+string(ac)+'and ainit='+string(ainit)+':',cM)
