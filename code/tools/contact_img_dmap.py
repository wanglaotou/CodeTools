#import pandas as pd
#file_path = '111.txt'
#new_file_path = '222.txt'
#df = pd.read_csv(file_path, header=None)
#df.columns = ['column_1']
#df['column_2'] = df['column_1']
#df.to_csv(new_file_path,index=False, header=None)

old_file = 'map_1_4_scene.txt'
new_file = 'map_1_4_scene_dmap.txt'
fr = open(old_file, 'r')
fw = open(new_file, 'w')
for line in fr.readlines():
	#print(type(line))
    new_line = line.strip() + ' ' + line
    fw.write(new_line)
fw.flush()
fw.close(); fr.close()