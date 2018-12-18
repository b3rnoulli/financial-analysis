function [ MFCAA ] = MFCAA_specmulti( dane , q_range);
% spectmulti Summary of this function goes here
%  Detailed explanation goes here
%program wylicza f(alfa)-spektrum multifraktalne dla zadanego zakresu skal
%q - musi byc wektorem poziomym
%F i SCALE - wynik dzialania programu MFDFA. SCALE sa macieza skal
%utworzona z wektora s .

parametr='P';  % P -obliczenia dla F_plus
% N -obliczenia dla F_minus

m=2;
m=num2str(m);

%l1=; %zakres q
%l2=65;

l1_skala=1; %1,7,17
%l2_skala=81;
eval(['l2_skala=length(dane.Scale);']); %

eval(['Skala=dane.Scale;']);
eval(['Scale=dane.Scale(l1_skala:l2_skala);']);
eval(['F=dane.F;']);


if ~exist('q_range','var')
    q=[-4:0.2:-0.2,0.2:0.2:4];
else
    q=[q_range(1):0.2:q_range(2)];
    q(q==0)=[];
end



liczba_q=length(q);

powerF=zeros(length(Skala),size(F,2));
F_minus=zeros(length(Skala),liczba_q);
Fq_minus=zeros(length(Skala),liczba_q);
F_plus=zeros(length(Skala),liczba_q);
Fq_plus=zeros(length(Skala),liczba_q);

F_Podobnik=zeros(length(Skala),1);

powerF_Zhou=zeros(length(Skala),size(F,2));
Fq2_Zhou=zeros(length(Skala),liczba_q);
Fq_Zhou=zeros(length(Skala),liczba_q);

for i=1:1:liczba_q
    
    for j=1:1:length(Skala)
        
        [a,b]=find(F(j,:));
        znaki=sign(F(j,1:length(a)));
        powerF=(abs(F(j,1:length(a)))).^(q(i)/2);
        
        F_minus(j,i)=-sum(powerF.*znaki)/(length(a));
        Fq_minus(j,i)=F_minus(j,i)^(1/q(i));
        
        F_plus(j,i)=sum(powerF.*znaki)/(length(a));
        Fq_plus(j,i)=F_plus(j,i)^(1/q(i));
        
        
    end
    
end

if parametr=='P'
    loglog(Scale(1:end),Fq_plus(1:end,:),'k')
    xlabel('\its');
    ylabel('\itF_q(s)');
    axis tight
elseif parametr=='N'
    loglog(Scale(1:end),Fq_minus(1:end,:),'k')
    %loglog(Scale(1:end),Fq_minus(1:end,20:end),'k')
    xlabel('\its');
    ylabel('\itF_q(s)');
    axis tight
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[x,y]=ginput(2);

close;

x=round(x);

k(1) = dsearchn(Scale',x(1));
k(2) = dsearchn(Scale',x(2));

liczba_q=length(q);

%%%%%%%%%zakres skal do liczenia

n1=k(1);

n2=k(2);

%obliczenie h  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if parametr=='P'
    for i=1:1:liczba_q
        h(i,:)=polyfit(log(Scale(n1:n2))',log(Fq_plus(n1:n2,i)),1);
    end
elseif parametr=='N'
    for i=1:1:liczba_q
        h(i,:)=polyfit(log(Scale(n1:n2))',log(Fq_minus(n1:n2,i)),1);
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

str=[num2str(n1),':',num2str(n2)];

%    odp=input('Save results ? y/n [n] : ','s');
%
%    if isempty(odp)
%        odp='n';
%     end
%
% if odp=='y'

disp('Saving...');

eval(['dane1=dane;']);
eval(['dane1.Scale=Skala;']);
eval(['dane1.F=F;']);
eval(['dane1.q=q;']);

if parametr=='P'
    eval(['dane1.Plus.F_plus=F_plus;']);
    eval(['dane1.Plus.F_xy_q=Fq_plus;']);
    eval(['dane1.Plus.h=h;']);
    eval(['dane1.Plus.Zakres_skal=str;']);
elseif parametr=='N'
    eval(['dane1.Minus.F_minus=F_minus;']);
    eval(['dane1.Minus.F_xy_q=Fq_minus;']);
    eval(['dane1.Minus.h=h;']);
    eval(['dane1.Minus.Skale_range=str;']);
end

%      s=isfield(dane1,'wsk');
%
%      if s==1
%          ciag=inputname(1);
%      else
%          eval(['dane1.wsk=1;']);
%          ciag=[inputname(1),'_results'];
%      end
%
%      eval([ciag,'=dane1;']);

%      eval(['save ',ciag,'.mat ',ciag]);

MFCAA = dane1;

end