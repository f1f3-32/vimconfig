import os
import re
#from subprocess import run
import subprocess as run
# 1. 检测 cmakelists
# 2. 检测 build

def find_prj_name():
    # file = open("./CMakeLists.txt", 'r', encoding="utf-8")
    file_content=''
    try:
        file = open("./CMakeLists.txt", 'r', encoding='utf-8')
        file_content = file.read()
        print("utf8")
    except UnicodeDecodeError:
        file = open("./CMakeLists.txt", 'r', encoding='gb18030')
        file_content = file.read()
        print("gb18030")
    except Exception() as e:
        file = open("./CMakeLists.txt", 'r', encoding='gbk')
        file_content = file.read()
        print("gbk")

    file.close()
    pattern = re.compile(r"project\(\w*\s")
    search = pattern.search(file_content)
    search_str = search[0]
    
    str_len = len(search_str)
    idx = 0
    for i in range(0, str_len):
        if search_str[i] == '(':
            idx = i+1
            break
    
    goal_str = ''
    
    for i in range(idx, str_len):
        if search_str[i] == ' ':
            break
        goal_str += search_str[i]

    print("Project Name：", goal_str)
    return goal_str
            

def run_qt():

    print("run_qt.py", os.getcwd())
    cmake_generate = "cmake .."
    cmake_build = "cmake --build ."
    project_name = find_prj_name()
    cmakelists = os.path.exists("CMakeLists.txt")
    build_dir = os.path.exists("build")
    cmake_cache = os.path.exists("CMakeCache.txt")
    run_cmd = ".\\build\\Debug\\"+project_name+".exe"
    if( build_dir ):
        # run("cd build&&"+cmake_build, shell=True)          # 进入操作，只对这一次有效，下一次会失去效果
        run.run("cmd /c cd build&&"+cmake_build)
        # run(cmake_build, shell=True)
        run.run("cmd /c "+run_cmd+"&&pause")
        # run(run_cmd, shell=True)
    elif(cmake_cache):
        # run(cmake_build, shell=True)
        run.run("cmd /c "+cmake_build)
        # run(".\\Debug\\"+project_name+".exe", shell=True)
        run.run("cmd /c .\\Debug\\"+project_name+"&&pause")
    elif(cmakelists):
        # run("mkdir build&&cd build&&"+cmake_generate + "&&" + cmake_build, shell=True)
        run.run("cmd /c mkdir build&&cd build&&"+cmake_generate + "&&" + cmake_build)
        # run(run_cmd, shell=True)
        run.run("cmd /c"+run_cmd+"&&pause")
    else:
        print("Not in the CMake Project!")


if __name__ == "__main__":
    run_qt()
