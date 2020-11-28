# unity5.6_shader
1、dissolve  溶解效果， 详细参见：https://blog.csdn.net/shi_tou_ge/article/details/107894372

两种不同的溶解效果

    第一种基于噪声图，利用其中的某一个通道比如R 通道，与阈值进行比较。如果小于0 ，则抛弃这个像素点。
    第二种，在世界坐标下，如果当前片元的Y 轴坐标大于设定的偏移值，则抛弃这个像素点。
