
# read file
# 保留所有单词
# 排序所有单词
# ~~去掉重复者~~
# 不去掉重复者，而是将所有单词提取出来，然后去重

import re
import os
import sys
import hashlib
import time

def file_md5(file_path):
    with open(file_path, 'rb') as f:
        file_data = f.read()
        return hashlib.md5(file_data).hexdigest()

HOME_PATH = os.path.expanduser('~').replace("\\", "/")
VIM_ALL_DICT_FILE = ""
if sys.argv[1]:
    VIM_ALL_DICT_FILE = HOME_PATH+"/vimfiles/complete/dictionary/add_to_dict_from_editing.txt"
else:
    VIM_ALL_DICT_FILE = HOME_PATH+"/vimfiles/complete/dictionary/"+sys.argv[1]

print(sys.argv[1])


# TODO: 判断文件是否修改
# hash 值是否存在？
# 有则判断
# 无则提示并生成一个 hash 值，将提示写 log 文件中

# print(VIM_ALL_DICT_FILE)

words = []

with open(VIM_ALL_DICT_FILE, 'r', encoding='utf-8') as f:
    # contents = f.readlines();
    contents = f.read()
    words = list(set(re.findall("\\w{4,}", contents)))
    # print(words)

with open(VIM_ALL_DICT_FILE, 'w', encoding='utf-8') as f:
    # TODO: 使用不分大小的排序方法
    words.sort()
    for line in words:
        f.write(line + '\n')
