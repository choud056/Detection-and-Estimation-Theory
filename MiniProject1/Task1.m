%% Mini Project 1 Task 1 Submitted By Neelu Choudhary
clear all
close all
clc
%% 
foldername = ['img'];
cd(['./', foldername]);

number = 2500;   % number of particles
delta = 2;
sigma1 = 0.01;
sigma2 = 2;

A=[eye(2),delta*eye(2); zeros(2,2), eye(2)];
B=[sigma1*eye(2),zeros(2,2); zeros(2,2), sigma2*eye(2)];

v=VideoWriter('Neelu Choudhary_video.avi');
open(v);

%% First Iteration of the algorithm 
Im = imread('0001.jpg');
L1 = redlikelihood(Im);
[n,m]=size(L1);
% Randomaly drawing the particles
particles =  zeros(4,number);
for i=1:number
    particles(1,i)=ceil(1+(n-1)*rand);
    particles(2,i)=ceil(1+(m-1)*rand);
    particles(3,i)=4*rand;
    particles(4,i)=4*rand;
end

partsize=zeros(1,number);

for i=1:number
     cords=particles(1:2,i);
     partsize(i)= L1(cords(1),cords(2));
end
partsizeCDF=cumsum(partsize);
partsizeCDF=partsizeCDF/partsizeCDF(end);

plotstep(particles, Im, partsize, 1, 10)
fig=figure(1);
f=getframe(fig);
writeVideo(v,f);

%% Subsequent steps

for i=2:291
    partsize=zeros(1,number);
    if i<10
        I = ['000',num2str(i),'.jpg'];
    elseif i<100
        I = ['00',num2str(i),'.jpg'];
    else
        I= ['0',num2str(i),'.jpg'];
    end
    particles = resample(particles,partsizeCDF,number);
    particles = ceil(A*particles + B*randn([4,number]));
    for j=1:number
       if particles(1,j)> 480
           particles(1,j)=480;
       end
       if particles(1,j)<1
           particles(1,j)=1;
       end
       if particles(2,j)> 640
           particles(2,j)=640;
       end
       if particles(2,j)<1
           particles(2,j)=1;
       end
    end
            
        I1 = imread(I);
       L1 = redlikelihood(I1);
       for k=1:number
           cords = particles(1:2,k);
           partsize(k)= L1(cords(1),cords(2));
       end
       partsizeCDF=cumsum(partsize);
       partsizeCDF=partsizeCDF/partsizeCDF(end);
       
       plotstep(particles, I1, partsize, i, 10)
       fig=figure(1);
       f=getframe(fig);
       writeVideo(v,f);
end

close(v)
cd('..');