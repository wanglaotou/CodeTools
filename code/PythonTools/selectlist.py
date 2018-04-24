import os, sys
import argparse

# ************* select the special list ***************
ap = argparse.ArgumentParser()
ap.add_argument("-i", "--inputpath", required=True, help="path of the input")
ap.add_argument("-o", "--outputpath", required=True, help="path of the output")
ap.add_argument("-s", "--special", required=True, help="the special list name")
args = vars(ap.parse_args())

print(args["special"])
fo = open(args["outputpath"],'w')
with open(args["inputpath"]) as fp:
	Strlines = fp.readlines()
	for line in Strlines:
		# print(line)
		Srcline = line.strip().split(' ')
		imgpath = Srcline[0].strip()
		Simgline = imgpath.strip().split('/')
		scene = Simgline[1].strip()
		if(scene!=args["special"]):
			fo.write(line)

		# fo.write('\n')