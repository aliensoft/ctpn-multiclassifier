import cv2
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import os
import pdb

pathSrc = "../data/src"
pathPos = "../data/results"
pathOut = "../data/results2/"
files = os.listdir(pathSrc)
ext = [x for x in files if x[-4:]=='.png' or x[-4:]=='.PNG' or x[-4:]=='.jpg' or x[-4:]=='.JPG']
for currfile in ext:
  try:
    currfilepos = 'res_%s.txt' % currfile[:-4]
    print(currfile, currfilepos)

    imgfile = pathSrc + "/" + currfile
    img_rgb_data = cv2.imread(imgfile, cv2.IMREAD_COLOR)
    #plt.imshow(img_rgb_data)
    #plt.show()

    posfile = pathPos + "/" + currfilepos
    dfpos = pd.read_csv(posfile, dtype={'X1':int, 'Y1':int, 'X2':int, 'Y2':int}, header=-1)
    dfpos.columns = ['X1', 'Y1', 'X2', 'Y2']

    for idx, row in dfpos.iterrows():
      #pdb.set_trace()
      [x1,y1,x2,y2] = row
      img_rgb_data01 = img_rgb_data[y1:y2, x1:x2, :]
      #plt.imshow(img_rgb_data01) 
      #plt.show()
      imgfile01 = pathOut + currfile[:-4] + "---" + str(idx) + ".png"
      cv2.imwrite(imgfile01, img_rgb_data01)
  except Exception as e:
    pass


import cv2
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import os
import pdb

pathPos = "../data/results"
img_rgb_data = cv2.imread(pathPos + "/learn.png", cv2.IMREAD_GRAYSCALE) #IMREAD_GRAYSCALE)
#img_rgb_data2 = cv2.equalizeHist(img_rgb_data)
#img_rgb_data3 = cv2.blur(img_rgb_data, (5,5),0)
laplacian = cv2.Laplacian(img_rgb_data, cv2.CV_64F)
#sobelx = cv2.Sobel(img_rgb_data, cv2.CV_64F, 1, 0, ksize=5)
#sobely = cv2.Sobel(img_rgb_data, cv2.CV_64F, 0, 1, ksize=5)
#img_rgb_data4 = img_rgb_data * float(1.2)
#img_rgb_data4[img_rgb_data4 > 255] = 255
plt.imshow(laplacian)
plt.show()
cv2.imwrite(pathPos + "/learn2.png", laplacian)






