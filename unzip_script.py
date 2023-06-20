import zipfile
import sys

zip_file = sys.argv[1]

with zipfile.ZipFile(zip_file, 'r') as zip_ref:
    zip_ref.extractall('.')