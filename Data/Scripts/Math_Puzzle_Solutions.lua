local solutions = {

	-- 19173
	"1@1|1|-541.51,-17.19|||1;2~1|:2|2|221.79,8.49||||:",

	-- 19230, 19033, 19008
	"2@1|3|-673.94,3.68|||1;4~1|:2|4|-164.00,-49.00|||1;5~1,2;6~1|:3|5|452.00,-180.00||||:4|6|444.00,91.00||||:",

	-- 18480, 18238, 18213
	"3@1|1|-804.03,-10.85|||1;5~1|:3|2|545.00,258.00||||:4|3|530.00,-370.00||||:5|4|534.71,57.85||||:2|5|-440.00,-35.00|||1;8~1,2;7~1|:6|6|524.00,-156.00||||:2|7|8.00,158.00|||1;4~1,2;2~1|:2|8|-11.00,-256.00|||2;6~1,1;3~1|:",

	-- 19563, 19365, 19340
	"4@1|1|-444.93,27.58|||1;2~1|:3|2|0.00,0.00|||1;3~1|:4|3|448.21,0.00||||:",

	-- 19018, 18805, 18780
	"5@1|7|-764.19,-16.57|||1;8~1|:2|8|-338.00,-25.00|||1;10~1,2;9~1|:3|9|20.00,95.00|||1;11~1|:4|10|428.56,-198.31||||:5|11|431.19,66.70||||:",

	-- 18348, 18085, 18060
	"6@1|1|-818.97,2.79|||1;5~1|:4|2|452.00,139.00||||:5|3|457.00,-166.00||||:3|4|-67.00,113.00|||1;2~1|:2|5|-517.00,-89.00|||1;7~1,2;4~1|:3|6|134.00,-360.00|||1;3~1|:2|7|-195.00,-205.00|||2;3~1,1;6~1|:",

	-- 19067, 18804, 18779
	"7@1|1|-691.41,-12.07|||1;5~1|:5|2|370.99,72.80||||:6|3|283.65,-213.94||||:4|5|-215.00,-53.00||6|1;3~1,2;2~1|:",

	-- 18609, 18422, 18397
	"8@1|1|-738.00,24.00|||1;4~1|:5|2|370.77,100.62||||:6|3|370.18,-188.83||||:4|4|-406.00,-188.00||7|1;3~1,2;5~1|:2|5|-66.00,41.00|||2;2~1,1;3~1|:",

	-- 17878, 17665, 17640
	"9@1|1|-799.45,10.17|||1;5~1|:5|2|717.27,-291.39||||:6|3|713.82,-25.86||||:7|4|710.38,241.39||||:4|5|-513.82,-229.32||5.0|2;7~1,1;6~1|:2|6|1.72,-282.77|||1;3~1,2;4~1|:4|7|-341.39,151.73||0|1;3~1,2;8~1|:2|8|55.17,303.46|||2;4~1,1;2~1|:",

	-- 19258, 19095, 19070
	"10@1|12|-799.27,-16.07|||1;16~1|:6|13|434.29,-11.07||||:5|14|17.13,-34.48|||1;13~1|:2|16|-398.63,-29.69|||2;14~2,1;14~1|:",

	-- 17555, 17193, 17168
	"11@1|19|-828.69,-7.00|||1;23~1|:6|20|870.44,-225.71||||:7|21|828.29,162.99||||:3|22|-383.31,44.44|||1;31~1|:4|23|-579.16,-196.90||0|2;24~1,1;28~1|:2|24|-708.23,287.93|||1;22~1,2;21~1|:2|27|564.28,-54.94|||2;21~1,1;20~1|:2|28|-173.74,-337.08|||2;30~2,1;30~1|:5|29|262.84,47.52|||1;27~1|:5|30|185.62,-322.23|||1;27~1|:2|31|-46.03,40.09|||1;29~1,2;29~2|:",

	"12@1|32|-1151.63,-38.13|||1;35~1|:6|33|734.07,-137.28||||:5|34|-99.15,-358.45|||1;37~1|:4|35|-835.12,-278.37||11.199999809265|2;36~1,1;34~1|:2|36|-835.12,112.49|||2;38~2,1;38~1|:2|37|-62.92,-34.32|||1;39~1,2;39~2|:5|38|-434.72,19.07|||1;34~2|:5|39|327.95,-38.13|||1;33~1|:",

	--
	"13@1|1|-827.00,15.00|||1;5~1|:6|2|439.00,-8.00||||:7|3|446.00,374.00||||:8|4|440.00,-337.00||||:2|5|-792.00,-330.00|||2;11~1,1;6~1|:2|6|-438.00,-341.00|||1;7~1,2;7~2|:5|7|-119.00,-342.00|||1;19~1|:5|17|-280.00,72.00|||1;21~1|:3|9|154.00,-240.00|||1;4~1|:2|11|-797.00,269.00|||1;20~1,2;20~2|:2|18|-160.00,352.00|||2;17~2,1;17~1|:2|19|-145.00,-136.00|||1;9~1,2;2~1|:5|20|-480.00,295.00|||1;18~1|:3|21|129.00,119.00|||1;3~1|:",

	--
	"14@1|1|-963.01,-23.98|||1;3~1|:7|2|621.71,-35.05||||:2|3|-431.69,-16.60|||1;4~1,2;4~2|:6|4|60.88,-18.45|||1;2~1|:",

	--
	"15@1|1|-835.00,-29.00|||1;5~1|:7|2|704.74,-228.85||||:8|3|725.56,288.77||||:4|4|-382.00,-350.00||5|1;6~1,2;10~1|:4|5|-782.00,-325.00||2|2;9~1,1;4~1|:2|6|-777.00,313.00|||1;7~1,2;7~2|:5|7|-418.00,285.00|||1;8~1|:2|8|-47.00,280.00|||1;2~1,2;3~1|:2|9|-530.92,-32.08|||2;14~2,1;11~2|:2|10|4.81,-306.36|||1;13~1,2;11~1|:6|11|-110.67,-62.56|||1;13~2|:5|13|332.02,-91.43|||1;14~1|:6|14|364.10,147.57|||1;2~1|:",

	
}

return solutions