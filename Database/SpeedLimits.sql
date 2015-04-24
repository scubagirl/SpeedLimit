CREATE TABLE 'SpeedLimits' (

  'latitude' Double DEFAULT NULL,
  'longitude' Double DEFAULT NULL,
  'speedLimit' int(11) DEFAULT NULL,
  'roadName' varchar(10) DEFAULT NULL,
  'direction' Int DEFAULT NULL
);

INSERT INTO 'SpeedLimits' VALUES(30.216751,-97.774651,70,'I35','S');
INSERT INTO 'SpeedLimits' VALUES(30.216823,-97.751386,60,'I35','N');
INSERT INTO 'SpeedLimits' VALUES(29.573856,-98.326454,60,'I35','S');
INSERT INTO 'SpeedLimits' VALUES(29.573567,-98.326588,70,'I35','N');


INSERT INTO 'SpeedLimits' VALUES(30.330299,-97.746009,30,'Shoal Creek','N');
INSERT INTO 'SpeedLimits' VALUES(30.330299,-97.746009,30,'Shoal Creek','S');
INSERT INTO 'SpeedLimits' VALUES(30.333542,-97.740052,35,'Burnet Road','N');
INSERT INTO 'SpeedLimits' VALUES(30.333542,-97.740052,35,'Burnet Road','S');
INSERT INTO 'SpeedLimits' VALUES(30.333871,-97.755400,55,'Mopac','N');
INSERT INTO 'SpeedLimits' VALUES(30.333439,-97.755805,55,'Mopac','S');
