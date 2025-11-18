# Kids Dataset (100 Rows)

## Schema
```sql
CREATE TABLE kids (
  id INT,
  race VARCHAR(28),
  country VARCHAR(20),
  age DECIMAL(6,3),
  height DECIMAL(7,3),
  weight DECIMAL(7,3),
  sex ENUM('MALE','FEMALE')
);
```

## 100 INSERT Statements
```sql
INSERT INTO kids (id, race, country, age, height, weight, sex) VALUES
(1, 'Native Hawaiian', 'USA', 11.754, 118.604, 71.203, 'MALE'),
(2, 'Asian', 'Korea', 15.307, 111.622, 27.828, 'FEMALE'),
(3, 'Native Hawaiian', 'USA', 14.242, 164.878, 46.077, 'FEMALE'),
(4, 'Black', 'USA', 13.867, 127.167, 21.628, 'FEMALE'),
(5, 'Asian', 'Japan', 8.663, 117.291, 44.236, 'MALE'),
(6, 'Asian', 'China', 12.963, 117.983, 48.544, 'FEMALE'),
(7, 'Black', 'Nigeria', 8.089, 137.792, 22.143, 'FEMALE'),
(8, 'Native Hawaiian', 'USA', 13.781, 156.97, 56.658, 'MALE'),
(9, 'American Indian', 'Canada', 13.708, 127.887, 34.001, 'MALE'),
(10, 'Native Hawaiian', 'USA', 6.667, 150.734, 45.011, 'FEMALE'),
(11, 'Black', 'Brazil', 11.644, 178.303, 27.707, 'FEMALE'),
(12, 'Native Hawaiian', 'USA', 7.686, 131.434, 35.079, 'MALE'),
(13, 'White', 'Germany', 11.282, 128.508, 50.673, 'MALE'),
(14, 'Asian', 'Korea', 11.373, 116.699, 28.12, 'MALE'),
(15, 'American Indian', 'Canada', 12.879, 112.989, 62.721, 'FEMALE'),
(16, 'Asian', 'Japan', 15.843, 131.551, 30.234, 'FEMALE'),
(17, 'American Indian', 'USA', 12.201, 160.333, 56.407, 'FEMALE'),
(18, 'Asian', 'Japan', 9.452, 145.811, 64.205, 'FEMALE'),
(19, 'Native Hawaiian', 'USA', 7.073, 164.912, 41.61, 'MALE'),
(20, 'Black', 'Nigeria', 8.799, 174.267, 61.075, 'FEMALE'),
(21, 'Black', 'Brazil', 14.568, 157.128, 39.985, 'FEMALE'),
(22, 'White', 'Germany', 15.503, 135.102, 31.792, 'FEMALE'),
(23, 'Asian', 'China', 7.482, 173.127, 45.261, 'MALE'),
(24, 'Native Hawaiian', 'USA', 10.632, 173.467, 24.927, 'MALE'),
(25, 'Asian', 'China', 15.763, 156.487, 45.198, 'MALE'),
(26, 'Native Hawaiian', 'USA', 12.981, 140.02, 44.283, 'MALE'),
(27, 'Native Hawaiian', 'USA', 7.209, 110.958, 74.913, 'MALE'),
(28, 'Asian', 'India', 9.27, 125.923, 23.65, 'MALE'),
(29, 'American Indian', 'Canada', 11.884, 113.152, 62.524, 'MALE'),
(30, 'American Indian', 'Canada', 8.709, 167.556, 37.998, 'FEMALE'),
(31, 'White', 'Germany', 7.23, 154.771, 21.596, 'MALE'),
(32, 'Asian', 'India', 12.665, 116.745, 61.744, 'MALE'),
(33, 'American Indian', 'Canada', 11.528, 113.033, 65.482, 'FEMALE'),
(34, 'Asian', 'China', 10.164, 144.155, 25.512, 'FEMALE'),
(35, 'Native Hawaiian', 'USA', 9.291, 115.545, 46.148, 'FEMALE'),
(36, 'American Indian', 'USA', 8.509, 147.345, 41.522, 'MALE'),
(37, 'Asian', 'Japan', 6.57, 140.043, 36.493, 'FEMALE'),
(38, 'Native Hawaiian', 'USA', 8.85, 153.135, 70.55, 'FEMALE'),
(39, 'Native Hawaiian', 'USA', 14.813, 176.096, 48.976, 'FEMALE'),
(40, 'White', 'UK', 7.266, 128.979, 33.693, 'MALE'),
(41, 'American Indian', 'Canada', 7.256, 171.308, 31.912, 'MALE'),
(42, 'White', 'USA', 7.569, 137.834, 73.685, 'FEMALE'),
(43, 'American Indian', 'Canada', 9.229, 146.571, 56.069, 'MALE'),
(44, 'White', 'USA', 15.803, 125.505, 73.776, 'FEMALE'),
(45, 'Native Hawaiian', 'USA', 12.215, 124.166, 34.296, 'FEMALE'),
(46, 'Native Hawaiian', 'USA', 8.593, 158.353, 69.843, 'MALE'),
(47, 'American Indian', 'USA', 13.599, 118.008, 27.787, 'MALE'),
(48, 'Black', 'USA', 14.658, 179.37, 78.88, 'FEMALE'),
(49, 'Asian', 'India', 13.926, 131.536, 54.721, 'FEMALE'),
(50, 'Asian', 'Japan', 11.436, 171.046, 52.705, 'FEMALE'),
(51, 'White', 'UK', 12.597, 116.119, 43.408, 'FEMALE'),
(52, 'Asian', 'Korea', 11.605, 118.818, 24.082, 'MALE'),
(53, 'Asian', 'Japan', 7.142, 139.088, 39.984, 'FEMALE'),
(54, 'Black', 'Nigeria', 10.064, 119.867, 56.879, 'FEMALE'),
(55, 'Native Hawaiian', 'USA', 8.015, 176.912, 43.676, 'MALE'),
(56, 'American Indian', 'Canada', 15.862, 140.674, 39.178, 'FEMALE'),
(57, 'Asian', 'India', 15.86, 139.243, 71.888, 'MALE'),
(58, 'White', 'UK', 8.875, 172.072, 74.726, 'FEMALE'),
(59, 'White', 'France', 10.782, 123.498, 27.196, 'FEMALE'),
(60, 'Black', 'Nigeria', 11.236, 169.718, 66.758, 'FEMALE'),
(61, 'American Indian', 'USA', 15.459, 110.209, 20.916, 'FEMALE'),
(62, 'American Indian', 'Canada', 11.583, 151.242, 26.126, 'FEMALE'),
(63, 'American Indian', 'USA', 15.105, 124.755, 35.942, 'FEMALE'),
(64, 'Black', 'Nigeria', 7.134, 141.004, 43.229, 'FEMALE'),
(65, 'American Indian', 'Canada', 14.01, 119.249, 52.578, 'MALE'),
(66, 'Native Hawaiian', 'USA', 14.346, 138.786, 61.863, 'FEMALE'),
(67, 'Black', 'Nigeria', 12.866, 161.686, 37.708, 'FEMALE'),
(68, 'Black', 'Nigeria', 14.069, 166.853, 70.381, 'MALE'),
(69, 'White', 'Germany', 9.748, 159.239, 79.736, 'MALE'),
(70, 'Native Hawaiian', 'USA', 15.336, 129.974, 59.232, 'MALE'),
(71, 'American Indian', 'Canada', 11.869, 136.738, 28.181, 'FEMALE'),
(72, 'Black', 'Nigeria', 13.011, 122.172, 64.107, 'MALE'),
(73, 'Native Hawaiian', 'USA', 8.773, 149.694, 68.844, 'MALE'),
(74, 'White', 'USA', 14.437, 143.335, 76.112, 'MALE'),
(75, 'Black', 'USA', 14.129, 149.464, 74.871, 'MALE'),
(76, 'Native Hawaiian', 'USA', 10.193, 154.952, 65.91, 'MALE'),
(77, 'Asian', 'Korea', 11.159, 140.803, 58.617, 'MALE'),
(78, 'Black', 'Brazil', 9.829, 133.976, 45.98, 'MALE'),
(79, 'White', 'Germany', 12.716, 154.634, 71.949, 'MALE'),
(80, 'Asian', 'Korea', 7.063, 115.744, 20.609, 'MALE'),
(81, 'Asian', 'Korea', 9.637, 165.63, 22.282, 'FEMALE'),
(82, 'Native Hawaiian', 'USA', 8.307, 140.153, 78.731, 'FEMALE'),
(83, 'White', 'UK', 8.29, 155.459, 49.035, 'FEMALE'),
(84, 'White', 'Germany', 6.991, 173.74, 71.426, 'MALE'),
(85, 'American Indian', 'Canada', 15.408, 165.598, 49.02, 'MALE'),
(86, 'American Indian', 'USA', 6.716, 140.131, 79.781, 'MALE'),
(87, 'American Indian', 'USA', 6.942, 125.091, 66.346, 'MALE'),
(88, 'Black', 'Nigeria', 8.885, 112.158, 41.287, 'FEMALE'),
(89, 'American Indian', 'USA', 15.412, 156.707, 46.22, 'MALE'),
(90, 'Black', 'USA', 14.201, 179.441, 53.865, 'FEMALE'),
(91, 'Asian', 'China', 10.847, 115.755, 56.469, 'FEMALE'),
(92, 'Native Hawaiian', 'USA', 14.204, 141.671, 23.717, 'FEMALE'),
(93, 'American Indian', 'Canada', 10.152, 179.671, 73.369, 'FEMALE'),
(94, 'Asian', 'Japan', 6.936, 166.676, 68.871, 'FEMALE'),
(95, 'American Indian', 'USA', 8.929, 124.37, 35.405, 'FEMALE'),
(96, 'Native Hawaiian', 'USA', 14.081, 165.338, 23.874, 'MALE'),
(97, 'White', 'USA', 12.181, 175.526, 37.092, 'MALE'),
(98, 'Asian', 'Korea', 12.141, 165.952, 67.582, 'FEMALE'),
(99, 'American Indian', 'Canada', 14.708, 155.871, 36.157, 'FEMALE'),
(100, 'Black', 'Nigeria', 10.498, 128.595, 24.66, 'FEMALE');
```

## View `kids` Table

```
mysql> select * from kids;
+------+-----------------+---------+--------+---------+--------+--------+
| id   | race            | country | age    | height  | weight | sex    |
+------+-----------------+---------+--------+---------+--------+--------+
|    1 | Native Hawaiian | USA     | 11.754 | 118.604 | 71.203 | MALE   |
|    2 | Asian           | Korea   | 15.307 | 111.622 | 27.828 | FEMALE |
|    3 | Native Hawaiian | USA     | 14.242 | 164.878 | 46.077 | FEMALE |
|    4 | Black           | USA     | 13.867 | 127.167 | 21.628 | FEMALE |
|    5 | Asian           | Japan   |  8.663 | 117.291 | 44.236 | MALE   |
|    6 | Asian           | China   | 12.963 | 117.983 | 48.544 | FEMALE |
|    7 | Black           | Nigeria |  8.089 | 137.792 | 22.143 | FEMALE |
|    8 | Native Hawaiian | USA     | 13.781 | 156.970 | 56.658 | MALE   |
|    9 | American Indian | Canada  | 13.708 | 127.887 | 34.001 | MALE   |
|   10 | Native Hawaiian | USA     |  6.667 | 150.734 | 45.011 | FEMALE |
|   11 | Black           | Brazil  | 11.644 | 178.303 | 27.707 | FEMALE |
|   12 | Native Hawaiian | USA     |  7.686 | 131.434 | 35.079 | MALE   |
|   13 | White           | Germany | 11.282 | 128.508 | 50.673 | MALE   |
|   14 | Asian           | Korea   | 11.373 | 116.699 | 28.120 | MALE   |
|   15 | American Indian | Canada  | 12.879 | 112.989 | 62.721 | FEMALE |
|   16 | Asian           | Japan   | 15.843 | 131.551 | 30.234 | FEMALE |
|   17 | American Indian | USA     | 12.201 | 160.333 | 56.407 | FEMALE |
|   18 | Asian           | Japan   |  9.452 | 145.811 | 64.205 | FEMALE |
|   19 | Native Hawaiian | USA     |  7.073 | 164.912 | 41.610 | MALE   |
|   20 | Black           | Nigeria |  8.799 | 174.267 | 61.075 | FEMALE |
|   21 | Black           | Brazil  | 14.568 | 157.128 | 39.985 | FEMALE |
|   22 | White           | Germany | 15.503 | 135.102 | 31.792 | FEMALE |
|   23 | Asian           | China   |  7.482 | 173.127 | 45.261 | MALE   |
|   24 | Native Hawaiian | USA     | 10.632 | 173.467 | 24.927 | MALE   |
|   25 | Asian           | China   | 15.763 | 156.487 | 45.198 | MALE   |
|   26 | Native Hawaiian | USA     | 12.981 | 140.020 | 44.283 | MALE   |
|   27 | Native Hawaiian | USA     |  7.209 | 110.958 | 74.913 | MALE   |
|   28 | Asian           | India   |  9.270 | 125.923 | 23.650 | MALE   |
|   29 | American Indian | Canada  | 11.884 | 113.152 | 62.524 | MALE   |
|   30 | American Indian | Canada  |  8.709 | 167.556 | 37.998 | FEMALE |
|   31 | White           | Germany |  7.230 | 154.771 | 21.596 | MALE   |
|   32 | Asian           | India   | 12.665 | 116.745 | 61.744 | MALE   |
|   33 | American Indian | Canada  | 11.528 | 113.033 | 65.482 | FEMALE |
|   34 | Asian           | China   | 10.164 | 144.155 | 25.512 | FEMALE |
|   35 | Native Hawaiian | USA     |  9.291 | 115.545 | 46.148 | FEMALE |
|   36 | American Indian | USA     |  8.509 | 147.345 | 41.522 | MALE   |
|   37 | Asian           | Japan   |  6.570 | 140.043 | 36.493 | FEMALE |
|   38 | Native Hawaiian | USA     |  8.850 | 153.135 | 70.550 | FEMALE |
|   39 | Native Hawaiian | USA     | 14.813 | 176.096 | 48.976 | FEMALE |
|   40 | White           | UK      |  7.266 | 128.979 | 33.693 | MALE   |
|   41 | American Indian | Canada  |  7.256 | 171.308 | 31.912 | MALE   |
|   42 | White           | USA     |  7.569 | 137.834 | 73.685 | FEMALE |
|   43 | American Indian | Canada  |  9.229 | 146.571 | 56.069 | MALE   |
|   44 | White           | USA     | 15.803 | 125.505 | 73.776 | FEMALE |
|   45 | Native Hawaiian | USA     | 12.215 | 124.166 | 34.296 | FEMALE |
|   46 | Native Hawaiian | USA     |  8.593 | 158.353 | 69.843 | MALE   |
|   47 | American Indian | USA     | 13.599 | 118.008 | 27.787 | MALE   |
|   48 | Black           | USA     | 14.658 | 179.370 | 78.880 | FEMALE |
|   49 | Asian           | India   | 13.926 | 131.536 | 54.721 | FEMALE |
|   50 | Asian           | Japan   | 11.436 | 171.046 | 52.705 | FEMALE |
|   51 | White           | UK      | 12.597 | 116.119 | 43.408 | FEMALE |
|   52 | Asian           | Korea   | 11.605 | 118.818 | 24.082 | MALE   |
|   53 | Asian           | Japan   |  7.142 | 139.088 | 39.984 | FEMALE |
|   54 | Black           | Nigeria | 10.064 | 119.867 | 56.879 | FEMALE |
|   55 | Native Hawaiian | USA     |  8.015 | 176.912 | 43.676 | MALE   |
|   56 | American Indian | Canada  | 15.862 | 140.674 | 39.178 | FEMALE |
|   57 | Asian           | India   | 15.860 | 139.243 | 71.888 | MALE   |
|   58 | White           | UK      |  8.875 | 172.072 | 74.726 | FEMALE |
|   59 | White           | France  | 10.782 | 123.498 | 27.196 | FEMALE |
|   60 | Black           | Nigeria | 11.236 | 169.718 | 66.758 | FEMALE |
|   61 | American Indian | USA     | 15.459 | 110.209 | 20.916 | FEMALE |
|   62 | American Indian | Canada  | 11.583 | 151.242 | 26.126 | FEMALE |
|   63 | American Indian | USA     | 15.105 | 124.755 | 35.942 | FEMALE |
|   64 | Black           | Nigeria |  7.134 | 141.004 | 43.229 | FEMALE |
|   65 | American Indian | Canada  | 14.010 | 119.249 | 52.578 | MALE   |
|   66 | Native Hawaiian | USA     | 14.346 | 138.786 | 61.863 | FEMALE |
|   67 | Black           | Nigeria | 12.866 | 161.686 | 37.708 | FEMALE |
|   68 | Black           | Nigeria | 14.069 | 166.853 | 70.381 | MALE   |
|   69 | White           | Germany |  9.748 | 159.239 | 79.736 | MALE   |
|   70 | Native Hawaiian | USA     | 15.336 | 129.974 | 59.232 | MALE   |
|   71 | American Indian | Canada  | 11.869 | 136.738 | 28.181 | FEMALE |
|   72 | Black           | Nigeria | 13.011 | 122.172 | 64.107 | MALE   |
|   73 | Native Hawaiian | USA     |  8.773 | 149.694 | 68.844 | MALE   |
|   74 | White           | USA     | 14.437 | 143.335 | 76.112 | MALE   |
|   75 | Black           | USA     | 14.129 | 149.464 | 74.871 | MALE   |
|   76 | Native Hawaiian | USA     | 10.193 | 154.952 | 65.910 | MALE   |
|   77 | Asian           | Korea   | 11.159 | 140.803 | 58.617 | MALE   |
|   78 | Black           | Brazil  |  9.829 | 133.976 | 45.980 | MALE   |
|   79 | White           | Germany | 12.716 | 154.634 | 71.949 | MALE   |
|   80 | Asian           | Korea   |  7.063 | 115.744 | 20.609 | MALE   |
|   81 | Asian           | Korea   |  9.637 | 165.630 | 22.282 | FEMALE |
|   82 | Native Hawaiian | USA     |  8.307 | 140.153 | 78.731 | FEMALE |
|   83 | White           | UK      |  8.290 | 155.459 | 49.035 | FEMALE |
|   84 | White           | Germany |  6.991 | 173.740 | 71.426 | MALE   |
|   85 | American Indian | Canada  | 15.408 | 165.598 | 49.020 | MALE   |
|   86 | American Indian | USA     |  6.716 | 140.131 | 79.781 | MALE   |
|   87 | American Indian | USA     |  6.942 | 125.091 | 66.346 | MALE   |
|   88 | Black           | Nigeria |  8.885 | 112.158 | 41.287 | FEMALE |
|   89 | American Indian | USA     | 15.412 | 156.707 | 46.220 | MALE   |
|   90 | Black           | USA     | 14.201 | 179.441 | 53.865 | FEMALE |
|   91 | Asian           | China   | 10.847 | 115.755 | 56.469 | FEMALE |
|   92 | Native Hawaiian | USA     | 14.204 | 141.671 | 23.717 | FEMALE |
|   93 | American Indian | Canada  | 10.152 | 179.671 | 73.369 | FEMALE |
|   94 | Asian           | Japan   |  6.936 | 166.676 | 68.871 | FEMALE |
|   95 | American Indian | USA     |  8.929 | 124.370 | 35.405 | FEMALE |
|   96 | Native Hawaiian | USA     | 14.081 | 165.338 | 23.874 | MALE   |
|   97 | White           | USA     | 12.181 | 175.526 | 37.092 | MALE   |
|   98 | Asian           | Korea   | 12.141 | 165.952 | 67.582 | FEMALE |
|   99 | American Indian | Canada  | 14.708 | 155.871 | 36.157 | FEMALE |
|  100 | Black           | Nigeria | 10.498 | 128.595 | 24.660 | FEMALE |
+------+-----------------+---------+--------+---------+--------+--------+
100 rows in set (0.001 sec)
```