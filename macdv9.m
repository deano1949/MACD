function [macdline,tan_macdline,momentum,tan_momentum]=macdv9(fastperiod,slowperiod,signalperiod,closeprice)

tan_macd_lag=2;
tan_momentum_lag=1;
%slow EMA
EMAslow=EMAcalv2(slowperiod,closeprice);
%fast EMA
EMAfast=EMAcalv2(fastperiod,closeprice);

%MACD =difference between EMAfast and EMAslow 
macdline=(EMAfast-EMAslow);
macdline(1:slowperiod-1)=0;

%create macdline tangent (3pts)
macdline_lag2=vertcat(0,0,macdline);
macdline_lag2=macdline_lag2(1:end-tan_macd_lag);
tan_macdline=(macdline-macdline_lag2);
%signalline: when MACDline cross signalline, a buy/sell signal generated
signaline=EMAcalv2(signalperiod,macdline);

%Momentum
momentum=macdline-signaline;
tan_momentum=momentum(1+tan_momentum_lag:end)-momentum(1:end-tan_momentum_lag);
tan_momentum=vertcat(zeros(tan_momentum_lag,1),tan_momentum);
%noofpts: number of points to create tangent

%holdingperiod: alpha trading period

  %variable
