
for ii = 1:30
    [errTrain(ii) errTest(ii)] = main(ii*50);
end

plot([50:50:1500], errTrain), hold on, plot([50:50:1500], errTest, 'r-')
xlabel('����������Ŀ')
ylabel('������')