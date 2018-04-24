#show [label,rect] info by random list
#Input:rectroiall.txt
import os, sys, inspect, shutil, random, cv2
import argparse

class Annot:
  def __init__(self, path_lbl, shuffle=True):
    self.path_lbl = path_lbl

    with open(self.path_lbl, 'r') as fd_lbl:
      self.lines = fd_lbl.readlines()
    if shuffle:
      random.shuffle(self.lines)

  def sparse_lines(self, line):
    items = line.strip().split(' ')
    path = items[0]
    num  = int(items[1])
    rects = []
    items = items[2:]
    for i in xrange(0, num):
      rect = [int(round(float(items[i*5+1]))), int(round(float(items[i*5+2]))), int(round(float(items[i*5+3]))), int(round(float(items[i*5+4])))]
      rects.append(rect)
    return (path, rects)

  def __iter__(self):
    for line in self.lines:
      path_img, rects = self.sparse_lines(line)
      if not os.path.exists(path_img):
        print '[%s] does not exist' % path_img
        continue
      yield(path_img, rects)

if __name__ == '__main__':
  parser = argparse.ArgumentParser(description='for show label')
  parser.add_argument('-annot', type=str, required=True, help='path to label file')
  parser.add_argument('-shf', type=int, help='is shuffle or not', default=0)
  args = parser.parse_args()

  annots = Annot(args.annot, args.shf)
  for annot in annots:
    (path_img, rects) = annot
    print path_img
    name_img = os.path.basename(path_img)
    img = cv2.imread(path_img, -1)
    for rect in rects:
      cv2.rectangle(img, (rect[0], rect[1]), (rect[0]+rect[2]-1, rect[1]+rect[3]-1), (255,0,0), 1)
    cv2.imshow('show', img)
    cv2.waitKey(0)
