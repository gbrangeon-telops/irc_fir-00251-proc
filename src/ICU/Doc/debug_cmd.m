genGetRegister_v10('ICUPosition', comPort)


%%

setPoint = 1;

genSetRegister_v10('ICUPositionSetPoint', setPoint, comPort);

disp('ICUPositionSetPoint')
disp(genGetRegister_v10('ICUPositionSetPoint', comPort))
disp('ICUPosition')
disp(genGetRegister_v10('ICUPosition', comPort))