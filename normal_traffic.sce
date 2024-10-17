//normal traffic

clc
//values
N = 50
ac=10
av=40
ainf=60
Vmax=30


//F
function f=F(a)
    if a>ac then
        f=1-exp(-(a-ac)/(av-ac))
    else
        f=0
    end
endfunction

//making initial values of xn
for i=1:N
    x(i) = i*ainf       //condition of normal traffic
    X(i)=[x(i)]
end
//disp('X=',X)

//distance between the vehicles

for i=1:N
    d(i)=ainf
end

d(N)=ainf
//putting in a matrix
for i=1:N
    D(i)=d(i)
end
//disp("D",D)

//matrix for velocity
for i=1:N
        v(i)=Vmax*F(d(i))
end


//infinite loop for simulation(can be made infinite using while 1)
j=0
while j<100
    //animation
    drawlater();
    clf                     
    plot(X,D) 
    for i=1:N
        plot(x(i),0.0,"O")
    end
    
    xlabel('x')
    ylabel('a(i)/ainf')
    drawnow();
    //finding velocity
    for i=1:N-1
        v(i)=Vmax*F(d(i))
    end
    if j>5 then
        v(N)=Vmax*F(d(N))/4             //presence of a disrution causing the upper limit to become vinf/4
    else
        v(N)=Vmax*F(d(N))
    end
    
    
    //finding new xn
    for i=1:N
        x(i)=x(i)+v(i)          //taking each loop as 1sec
    end
        //change in a(n)=a(n)+v(n+1)-v(n)
    for i=2:N
        d(i-1)=d(i-1)+v(i)-v(i-1)
    end
    j=j+1
    for i=1:N
        V(i)=[v(i)]
        D(i)=[d(i)/ainf]
        X(i)=[x(i)]
        X1(i,j)=[x(i)]              //matrix having all values of xn sorted in columns
    end
    
    //sleep(10)
    //disp(V)
end
//disp(V)



