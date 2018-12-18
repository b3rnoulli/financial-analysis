function MFDFA2 = specmulti( dane, filename, bottom_bound, top_bound)

m=2;
m=num2str(m);

l1=1;
eval(['l2=length(dane.q);']); %

l1_skala=1; %1,7,17
eval(['l2_skala=length(dane.Scale);']); %

eval(['Skala=dane.Scale;']);
eval(['Scale=dane.Scale(l1_skala:l2_skala);']);
eval(['Fq=dane.Fq(l1_skala:l2_skala,l1:l2);']);
eval(['q=dane.q(l1:l2);']);
loglog(Scale(1:end),Fq(1:end,31:70),'-k')
xlabel('s','FontSize', 14);
ylabel('F_q(s)','FontSize', 14);

axis tight
% ylim([10^-5 5000])
if ~exist('bottom_bound','var') && ~exist('top_bound','var')
    [ x, ~ ] = ginput(2);
    top_bound = x(2);
    bottom_bound = x(1);
end

k(1) = dsearchn(Scale',bottom_bound);
k(2) = dsearchn(Scale',top_bound);

fprintf('BOTTOM BOUND: %s TOP BOUND: %s \n',num2str(bottom_bound),num2str(top_bound));

liczba_q=length(q);

n1=k(1);
%n1=20;

n2=k(2);

%obliczenie h i bledu dopasowania prostej %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:1:liczba_q
    h(i,:)=polyfit(log(Scale(n1:n2))',log(Fq(n1:n2,i)),1);
end

%obliczenie tau (T) i jego bledu %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

T=zeros(1,liczba_q);

T=q'.*h(:,1)-1;
%T=q'.*h(:,1);


% obliczenie obliczenie alfa oraz f %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%figure
%plot(q,T)
dT=diff(T);
dq=diff(q);
alfa=dT./dq';
f=q(1:length(q)-1)'.*alfa-T(1:length(T)-1);

% plot(alfa(31:70),f(31:70),'+k');
% xlabel('\bfalfa');
% ylabel('\bff(alfa)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

str=[num2str(n1),':',num2str(n2)];



dane1=dane;

eval(['Fq=dane.Fq;'])
eval(['q=dane.q;'])

eval(['MFDFA',m,'.Fq=Fq;']);
eval(['MFDFA',m,'.Scale=Skala;']);
eval(['MFDFA',m,'.q=q;']);
eval(['MFDFA',m,'.h=h(:,1);']);
eval(['MFDFA',m,'.T=T;']);
eval(['MFDFA',m,'.alfa=alfa;']);
eval(['MFDFA',m,'.f=f;']);
eval(['MFDFA',m,'.Zakres_skal=str;'])
eval(['MFDFA',m,'.bottom_scale=n1;'])
eval(['MFDFA',m,'.top_scale=n2;'])

if ~isempty(filename)
    save(filename,'MFDFA2');
end

end

