CREATE TABLE 'SpeedLimits' (
  'latitude' Double DEFAULT NULL,
  'longitude' Double DEFAULT NULL,
  'speedLimit' int(11) DEFAULT NULL,
  'roadName' varchar(10) DEFAULT NULL,
  'direction' Int DEFAULT NULL
);

INSERT INTO 'SpeedLimits' VALUES(30.184669,-97.774651,70,'I35','S');
INSERT INTO 'SpeedLimits' VALUES(30.184558,-97.774426,65,'I35','N');
INSERT INTO 'SpeedLimits' VALUES(29.573856,-98.326454,65,'I35','S');
INSERT INTO 'SpeedLimits' VALUES(29.573567,-98.326588,70,'I35','N');

