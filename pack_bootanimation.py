
from __future__ import print_function
import sys, os, zipfile
import struct

try:
    import StringIO
except:
    import io
    class StringIO:
        pass
    StringIO.StringIO = io.BytesIO

from PIL import Image



if __name__ == "__main__":
    directory = "./bootanimation/"
    archivio = zipfile.ZipFile('bootanimation.zip', "w", allowZip64=False, compresslevel=zipfile.ZIP_STORED)
    for root, subdirs, files in os.walk(directory):
        for filename in files:
            print (filename)
            if(filename.endswith('.png') or filename.endswith('.txt')):
                if(filename.endswith('png')):
                    im = Image.open(root + '/' + filename)
                    rgb_im = im.convert('RGB')
                    newsize = (160, 128)
                    rgb_im = rgb_im.resize(newsize)
                    rgb_im.save(root + '/' + filename)
                archivio.write(root + '/' + filename, arcname=root[16:] + '/' +filename)
            else:
                print('skipped ' + filename)
    archivio.close()
