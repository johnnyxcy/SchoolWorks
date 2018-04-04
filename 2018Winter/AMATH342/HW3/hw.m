%% PART 1
%euler method simulator

deltat=0.01 ; %timestep
Tmax=50;

tlist=linspace(0,Tmax,Tmax/deltat +1) ;
V1=zeros(1,length(tlist));
V2=zeros(1,length(tlist));

%initialize
V0=0;
V1(1)=V0;
V2(1)=V0;

%circuit parameters
R=10;
C=1;

%define input currents
I1=1.05157 * ones(1,length(tlist));
I2=-64.681* sin(tlist);


for n=1:length(tlist)-1
    t=tlist(n);
    V1(n+1)=V1(n) + (-V1(n)/(R*C) + I1(n)/C )*deltat;
    V2(n+1)=V2(n) + (-V2(n)/(R*C) + I2(n)/C )*deltat;
end
%% voltage
figure(1)
subplot(211)
plot(tlist,V1,'.-','LineWidth',2, 'MarkerSize', 10); hold on
xlabel('t (ms)'); ylabel('V_1(t) (mV)');
axis([0 50 0 20])
line([30 30], [0 30]);
txt1 = '\leftarrow V_1(t=30ms) = 10mV';
text(30, V1(tlist==30), txt1);

subplot(212)
plot(tlist,V2,'-','LineWidth',2, 'MarkerSize', 10); hold on
xlabel('t (ms)'); ylabel('V_2(t) (mV)');
axis([0 50 0 20])
line([30 30], [0 30]);
txt2 = '\leftarrow V_2(t=30ms) = 10mV';
text(30, V1(tlist==30), txt2);
%% current
figure(1)
subplot(211)
plot(tlist,I1,'.-','LineWidth',2, 'MarkerSize', 10); hold on
xlabel('t (s)'); ylabel('I_1(t)'); 


subplot(212)
plot(tlist,I2,'-','LineWidth',2, 'MarkerSize', 10); hold on
xlabel('t (s)'); ylabel('I_2(t)');
%% ===============================================================
%% PART 2
deltat=0.1 ; %timestep
Tmax=100;

tlist=linspace(0,Tmax,Tmax/deltat +1) ;
Vlist=zeros(1,length(tlist));
Ialist=zeros(1,length(tlist));
width=30; t1=30; t2=t1+width;
Ialist(tlist>=t1&tlist<t2) = 0.5;

%initialize
V0=0;
Vlist(1)=V0;

%circuit parameters
R=10;
C=1;

for n=1:length(tlist)-1
    t=tlist(n);
    Vlist(n+1)=Vlist(n) + ( -Vlist(n)/(R*C) +Ialist(n)/C)*deltat;
end

figure(2);
plot(tlist,Vlist,'.-','LineWidth',2,'MarkerSize',10); hold on; grid on;
axis([0 100 0 10]);
xlabel('t (ms)'); ylabel('V(t) (mV)'); 

%% PART 3
deltat=0.1 ; %timestep
Tmax=100;

tlist=linspace(0,Tmax,Tmax/deltat +1) ;
Vlist=zeros(1,length(tlist));
Ialist=zeros(1,length(tlist));
width=30; t1=30; t2=t1+width;
Ialist(tlist>=t1&tlist<t2) = 0.5;

%initialize
V0=0;
Vlist(1)=V0;
threshold = 10;
N = 1;

%circuit parameters
R=10;
C=1;

while max(Vlist) < threshold
    for n=1:length(tlist)-1
        t=tlist(n);
        Vlist(n+1)=Vlist(n) + ( -Vlist(n)/(R*C) +Ialist(n)/C)*deltat;
    end
    N = N + 0.00001;
    Ialist(tlist>=t1&tlist<t2) = N * 0.5;
end
figure
plot(tlist,Vlist,'.-','LineWidth',2); hold on; grid on;
xlabel('t'); ylabel('V(t)'); 
%% PART 4
deltat=0.1 ; %timestep
Tmax=100;

tlist=linspace(0,Tmax,Tmax/deltat +1) ;
Vlist=zeros(1,length(tlist));

%initialize
V0=0;
Vlist(1)=V0;

%define input conductance
gapplist=zeros(1,length(tlist));
t1 = 10; t2 = t1 + 20;
gapplist(tlist>=t1&tlist<t2) = 0.5;

%circuit parameters
R=10;
C=1;
E=11;
for n=1:length(tlist)-1
    t=tlist(n);
    Vlist(n+1)=Vlist(n) + ( -Vlist(n)/(R*C) + gapplist(n)*(E-Vlist(n)) )*deltat;
end

figure
plot(tlist,Vlist,'.-','LineWidth',2); hold on; grid on;
xlabel('t'); ylabel('V(t)'); 
%%
deltat=0.1 ; %timestep
Tmax=100;
width = 20;

tlist=linspace(0,Tmax,Tmax/deltat +1) ;
V1=zeros(1,length(tlist));
V2=zeros(1,length(tlist));
V3=zeros(1,length(tlist));
V4=zeros(1,length(tlist));

%initialize
V0=0;
V1(1)=V0;
V2(1)=V0;
V3(1)=V0;
V4(1)=V0;

%define input conductance
g1=zeros(1,length(tlist));
t1 = 10; t2 = t1 + width;
g1(tlist>=t1&tlist<t2) = 0.1;

g2=zeros(1,length(tlist));
t1 = 40; t2 = t1 + width;
g2(tlist>=t1&tlist<t2) = 0.3;

g3=g1+g2;


%circuit parameters
R=10;
C=1;
E=11;
for n=1:length(tlist)-1
    t=tlist(n);
    V1(n+1)=V1(n) + ( -V1(n)/(R*C) + g1(n)*(E-V1(n)) )*deltat;
    V2(n+1)=V2(n) + ( -V2(n)/(R*C) + g2(n)*(E-V2(n)) )*deltat;
    V3(n+1)=V3(n) + ( -V3(n)/(R*C) + g3(n)*(E-V3(n)) )*deltat;
end

figure(3);
plot(tlist,V1,'.-','LineWidth',2, 'MarkerSize', 26); hold on
xlabel('t'); ylabel('V(t)');
plot(tlist,V2,'.-','LineWidth',2, 'MarkerSize', 26);
plot(tlist,V3,'.-','LineWidth',2, 'MarkerSize', 26);
plot(tlist,V1+V2,'.-','LineWidth',2, 'MarkerSize', 26);
legend('V1','V2','V3','V1+V2')
%%
rate = zeros(20, 1);
I = zeros(20, 1);
for k=1:20
    I(k) = -10 + k;
    rate(k) = hhmodel(I(k));
end

figure(4);
plot(I, rate, '.-','LineWidth', 2, 'MarkerSize', 26)
grid on;
xlabel('Current I_A (\mu A)'); ylabel('Firing Rate (Hz)');

%%
rate = zeros(20, 1);
I = zeros(20, 1);
for k=1:20
    I(k) = -10 + k;
    rate(k) = hhmodel(I(k));
end

figure(4);
plot(I, rate, '.-','LineWidth', 2, 'MarkerSize', 26)
grid on;
symbol = 'I';
xlabel('Current Amplitude Ibar (\mu A)'); ylabel('Firing Rate (Hz)');
%%
rate = zeros(20, 1);
I = zeros(20, 1);
fano = zeros(20, 1);

for k=1:20
    I(k) = -10 + k;
    [rate(k), fano(k)] = hhmodel_with_noise(I(k));
end

figure(4);
plot(I, rate, '.-','LineWidth', 2, 'MarkerSize', 26)
grid on;
symbol = 'I';
xlabel('Current Amplitude Ibar (\mu A)'); ylabel('Firing Rate (Hz)');

%%
I = 5;
fano = zeros(10, 1);
a = zeros(10, 1);
i = 1;
for k = 0.001:0.001:0.1
    noise = zeros(500, 1);
    for n = 1:500
        noise(n) = -k* rand() + k * rand();
    end
    fano(i) = var(noise) / mean(noise);
    a(i) = max(noise);
    i = i + 1;
end

plot(fano, a, '.-', 'LineWidth', 2, 'MarkerSize', 16);
xlabel('Amplitude of noise'); ylabel('Fano Factor');