function [MFCAA2] = MFCCA( s1,s2 , opt1 );
%PLO Summary of this function goes here
%  Detailed explanation goes here
%seria musi byc wektorem poziomym
%tryb atomatyczny AUT tryb manualny MAN
% obliczenia dla metody Zhou lub z abs


if nargin<3
   opt1='noabs';
end

if size(s2,2)>size(s2,1)
    s2=s2';
end

if size(s1,2)>size(s1,1)
    s1=s1';
end

macierz_serie(:,1)=s1-mean(s1);
% dlaczego tak odejmujemy srednia s1 a nie s2 ?
macierz_serie(:,2)=s2-mean(s1);

liczba_serii=size(macierz_serie,2);

% calculate the% profile%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Y=cumsum(macierz_serie);

%scale%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N=length(macierz_serie);

min_scale=20;
max_scale=round(N/5);
liczba_skal=40;

%min_scale=40;
%max_scale=12;
%liczba_skal=3;


s=[log(min_scale):(log(max_scale)-log(min_scale))/liczba_skal:log(max_scale)];
s=round(exp(s));

%s=[6,8,10,12,14,16,18 s];

%s=[159];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

m=2;  %stopien wielomianu dopasowywanego do danych 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

F=zeros(length(s),floor(N/s(1))*2);

warning off

for i=1:1:length(s)
 
   disp(['Scale: ',num2str(i),'/',num2str(size(s,2))]);

   % divide for part and fit polynomian %%%%%%%%%%%%%%%%%%%
   
   Ns=floor(N/s(i));
 
   wartosci_start=zeros(N,liczba_serii);
   wartosci_end=zeros(N,liczba_serii);
   
   Y_beztrendu_start=zeros(Ns*s(i),liczba_serii);
   Y_beztrendu_end=zeros(Ns*s(i),liczba_serii);
   
   for k=1:1:liczba_serii  
    
       for j=1:1:Ns
       
           funkcje = polyfit([(j-1)*s(i)+1:(j)*s(i)],Y(((j-1)*s(i)+1):(j)*s(i),k)',m);
           wartosci_start([(j-1)*s(i)+1:(j)*s(i)],k)=polyval(funkcje,[(j-1)*s(i)+1:(j)*s(i)]);
           
           funkcje = polyfit([N-j*s(i)+1:N-(j-1)*s(i)],Y((N-j*s(i)+1:N-(j-1)*s(i)),k)',m);
           wartosci_end([N-j*s(i)+1:N-(j-1)*s(i)],k)=polyval(funkcje,[N-j*s(i)+1:N-(j-1)*s(i)]);
            
       end
      
   end
   
   
   wartosci_start(1+Ns*s(i):N,:)=[];
   wartosci_end(1:N-Ns*s(i),:)=[];
   

   if strcmp(opt1, 'abs')
       
      Y_beztrendu_start=abs(Y(1:Ns*s(i),:)-wartosci_start);  %ABS
      Y_beztrendu_end=abs(Y(N-Ns*s(i)+1:N,:)-wartosci_end);
   
   else
       
      Y_beztrendu_start=(Y(1:Ns*s(i),:)-wartosci_start);  
      Y_beztrendu_end=(Y(N-Ns*s(i)+1:N,:)-wartosci_end);
      
   end
   
   prod_Y_beztrendu_start=prod((Y_beztrendu_start'))';
   prod_Y_beztrendu_end=(prod(Y_beztrendu_end'))';
 
   for j=1:1:Ns
     
     F(i,j)=sum(prod_Y_beztrendu_start([(j-1)*s(i)+1:(j)*s(i)]));
   
   end
   
   
  for j=1:1:Ns
       
       F(i,Ns+j)=sum(prod_Y_beztrendu_end([(j-1)*s(i)+1:(j)*s(i)]));
   
  end
    
  F(i,:)=F(i,:)./s(i);   %%tutaj koniec obliczen F(s)
  
end
 
m=num2str(m);

MFCAA2.Scale=s;
MFCAA2.F=F;
  
warning on

