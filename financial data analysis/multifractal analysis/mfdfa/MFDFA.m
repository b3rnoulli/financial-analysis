function [MFDFA2] = MFDFA( seria , nazwa, save_result, opts );
%PLO Summary of this function goes here
%  Detailed explanation goes here
%seria musi byc wektorem poziomym
%tryb atomatyczny AUT tryb manualny MAN

disp('Licze')

if ~exist('save_result','var')
    save_result = true; 
end


meanx=mean(seria);

N=length(seria);

seria1=seria-meanx;
Y=cumsum(seria1);

min_scale=20;
max_scale=round(N/5);
%%%max_scale=2000;
liczba_skal=40;


s=[log(min_scale):(log(max_scale)-log(min_scale))/liczba_skal:log(max_scale)];
s=round(exp(s));


m=2;  %stopien wielomianu dopasowywanego do danych 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

q=[-10:0.2:-0.2,0.2:0.2:10];


liczba_q=length(q);

F=zeros(length(s),floor(N/s(1))*2);

Fn=zeros(length(s),floor(N/s(1)));

Fq=zeros(length(s),liczba_q);
powerF=zeros(length(s),floor(N/s(1))*2);

warning off



for i=1:1:length(s)
 
    disp(['Obliczam dla skali: ',num2str(i),'/',num2str(size(s,2))]);

    % divide for part and fit polynomian %%%%%%%%%%%%%%%%%%%
    
   Ns=floor(N/s(i));
   % funkcje = zeros(1,m+1);
   wartosci_start=zeros(Ns,s(i));
   wartosci_end=zeros(Ns,s(i));
   x_start=zeros(Ns,s(i));
   y_start=zeros(Ns,s(i));
   x_end=zeros(Ns,s(i));
   y_end=zeros(Ns,s(i));

   for j=1:1:Ns
       
       x_start(j,:)=[(j-1)*s(i)+1:(j)*s(i)];
       y_start(j,:)=Y(((j-1)*s(i)+1):(j)*s(i));
          
       x_end(j,:)=[N-j*s(i)+1:N-(j-1)*s(i)];
       y_end(j,:)=Y(N-j*s(i)+1:N-(j-1)*s(i));
        
   end
   
   for j=1:1:Ns
       
       funkcje = polyfit(x_start(j,:),y_start(j,:),m);
       wartosci_start(j,:)=polyval(funkcje,x_start(j,:));
         
       funkcje = polyfit(x_end(j,:),y_end(j,:),m);
       wartosci_end(j,:)=polyval(funkcje,x_end(j,:));
   
   end

   j=[1:1:Ns]; 
   F(i,1:length(j))= (sum(((y_start(j,:)-wartosci_start(j,:)).^2)'))/s(i);
  % Fn(i,1:length(j))=F(i,1:length(j));  %%%%
   F(i,Ns+1:Ns+length(j))=(sum(((y_end(j,:)-wartosci_end(j,:)).^2)'))/s(i);

   %%% cd dla zapisu serii zdetrendowanej
  
   %  aa=find(indeksy==i);
      
      
   %   if aa
  
   %      seria_zdetrendowana=y_start(j,:)-wartosci_start(j,:);
   %      seria_zdetrendowana=seria_zdetrendowana';
         
         
   %      eval(['serie_zdetrendowane.s',num2str(numerek),'=s(i);']);
   %      eval(['serie_zdetrendowane.seria',num2str(numerek),'=seria_zdetrendowana(:);']);
   %      numerek=numerek+1;
    
   %   end
  
   %%%%%%%%%%%%%% jescze jedna czesc nizej
  
end

   
%obliczenie Fq %%%%%%%%%%%%%%%%%%%%%%%%%%%% 

for i=1:1:liczba_q    

    for j=1:1:length(s)
        powerF=F(j,1:floor(N/s(j))*2).^(q(i)/2);   
        Fq(j,i)=(sum(powerF)/(2*floor(N/s(j))))^(1/q(i)); 
    end

end

%plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% if opts=='MAN'
% 
%     figure
%     loglog(s',Fq,'k');
%     xlabel('\its');
%     ylabel('\itF_q(s)');
% 
%     [x,y]=ginput(2);
% 
%     close;
% 
%     x=round(x);
% 
%     k(1) = dsearchn(s',x(1));
%     k(2) = dsearchn(s',x(2));
% 
%     n1=k(1);               %zakres skal do liczenia
%     n2=k(2);
% 
% else
    
     n1=1;               %zakres skal do liczenia
     n2=length(s);
    
% end

%obliczenie h i bledu dopasowania prostej %%%%%%%%%%%%%%%%%%%%%%%%

for i=1:1:liczba_q
    h(i,:)=polyfit(log(s(n1:n2)'),log(Fq(n1:n2,i)),1);
end

%obliczenie tau (T) i jego bledu %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

T=zeros(1,liczba_q);

T=q'.*h(:,1)-1;

% obliczenie obliczenie alfa oraz f %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dT=diff(T);
dq=diff(q);
alfa=dT./dq';
f=q(1:length(q)-1)'.*alfa-T(1:length(T)-1); 

% if opts=='MAN'
%    figure
%    plot(alfa,f,'+k');
%    xlabel('\bfalfa');
%    ylabel('\bff(alfa)');
% end

%zapis%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

str=[num2str(n1),':',num2str(n2)];
m=num2str(m);

%eval([inputname(1),'_wyniki.MFDFA',m,'.F=F;']); 
eval(['MFDFA',m,'.Fq=Fq;']); 
eval(['MFDFA',m,'.q=q;']); 
eval(['MFDFA',m,'.Scale=s;']); 
eval(['MFDFA',m,'.h=h(:,1);']); 
eval(['MFDFA',m,'.T=T;']); 
eval(['MFDFA',m,'.alfa=alfa;']); 
eval(['MFDFA',m,'.f=f;']); 
eval(['MFDFA',m,'.Zakres_skal=str;']); 

if save_result == true
    save(nazwa, ['MFDFA',m]);
end
% eval(['save ',nazwa,'_m',m,'_wyniki.mat ','MFDFA',m]); 


%eval(['save ',inputname(1),'_only2scale_wyniki2.mat ',inputname(1),'_wyniki']); 


   %%%% cd dla zapisu serii zdetrendowanej
   %    eval(['save ',inputname(1),'_m',m,'_seriedetr.mat serie_zdetrendowane']);
   %%%%%%



warning on



