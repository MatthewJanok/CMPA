clc
clear

Is = 0.01E-12;
Ib = 0.1E-12;
Vb = 1.3;
Gp = 0.1;
V = linspace(-1.95, 0.7, 200);

I = Is*(exp((1.2*V)/0.025)-1) + Gp.*V - Ib*exp((1.2*(-(V+Vb))/0.025)-1);
Ivar = I +0.2*I.*rand(1,200);

figure(1)
plot(V,I)
xlabel('Voltage')
ylabel('Current')

figure(2)
plot(V,Ivar)
xlabel('Voltage')
ylabel('Current')

figure(3)
semilogy(V,abs(Ivar))
xlabel('Voltage')
ylabel('Current')

%2-Polynomial Fitting ***Not really good fits
P4 = polyfit(V,Ivar,4);
L4 = polyval(P4,V);
figure(4)
plot(V,Ivar,'b', V,L4,'r')


P8 = polyfit(V,Ivar,8);
L8 = polyval(P8,V);
figure(5)
plot(V,Ivar,'b', V,L8,'r')


%3-Nonlinear Curve Fitting

fo2 = fittype('A.*(exp(1.2*x/25e-3)-1) + Gp.*x - C*(exp(1.2*(-(x+Vb))/25e-3)-1)');
ff2 = fit(V',Ivar',fo2);
If2 = ff2(V');
% figure(6)
% plot(V,Ivar,'b', V,If2,'r')
figure(7)
semilogy(V,abs(Ivar),'b', V,abs(If2),'r')



fo3 = fittype('A.*(exp(1.2*x/25e-3)-1) + B.*x - C*(exp(1.2*(-(x+Vb))/25e-3)-1)');
ff3 = fit(V',Ivar',fo3);
If3 = ff3(V');
% figure(8)
% plot(V,Ivar,'b', V,If3,'r')
figure(9)
semilogy(V,abs(Ivar),'b', V,abs(If3),'r')



fo4 = fittype('A.*(exp(1.2*x/25e-3)-1) + B.*x - C*(exp(1.2*(-(x+D))/25e-3)-1)');
ff4 = fit(V',Ivar',fo4);
If4 = ff4(V');
% figure(10)
% plot(V,Ivar,'b', V,If4,'r')
figure(11)
semilogy(V,abs(Ivar),'b', V,abs(If4),'r')


%Fitting the Neural Net

inputs = V;
targets = Ivar;
hiddenLayerSize = 10;
net = fitnet(hiddenLayerSize);
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
[net,tr] = train(net,inputs,targets);
outputs = net(inputs);
errors = gsubtract(outputs,targets);
performance = perform(net,targets,outputs)
view(net)
Inn = outputs;

% figure(12)
% plot(V,Inn)
figure(13)
semilogy(V,abs(Ivar),'b', V,abs(Inn),'r')















